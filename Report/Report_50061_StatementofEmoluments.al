report 50061 "Statement Emoluments Finance"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Statement of Emoluments Finance';
    RDLCLayout = 'Report\Layout\Emoluments.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = sorting("Vendor No.", "Posting Date", "Currency Code") where("Document Type" = filter(Payment));
            column(gdateStartDate; format(gdateStartDate)) { }
            column(gdateEndDate; format(gdateEndDate)) { }

            column(CompanyName; grecCompanyInfo.Name) { }
            column(CompanyBRN; grecCompanyInfo.BRN) { }

            column(gtextNID; gtextNID) { }
            column(gtextVendorName; gtextVendorName) { }
            column(gtextVendorAddress; gtextVendorAddress) { }

            column(gdecEmolument; gdecEmolument) { }
            column(gdecPAYEAmt; gdecPAYEAmt) { }

            column(Sign; grecPurchPayableSetup."Sign for Emoluments") { }

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", gdateStartDate, gdateEndDate);
            end;

            trigger OnAfterGetRecord()
            begin
                if grecVendor2.get("Vendor No.") then begin
                    if grecVendor2."Vendor Category" <> 'TUTOR' then
                        CurrReport.Skip();
                end;

                if gtextVendor <> "Vendor No." then begin
                    clear(gtextNID);
                    clear(gtextVendorName);
                    Clear(gtextVendorAddress);
                    if grecVendor.get("Vendor No.") then begin
                        gtextNID := grecVendor.NID;
                        gtextVendorName := grecVendor.Name;
                        gtextVendorAddress := grecVendor.Address;
                    end;

                    Clear(gdecEmolument);
                    Clear(gdecPAYEAmt);
                    grecVendLedgerEntry.Reset();
                    grecVendLedgerEntry.SetCurrentKey("Entry No.");
                    grecVendLedgerEntry.SetRange("Document Type", grecVendLedgerEntry."Document Type"::Payment);
                    grecVendLedgerEntry.SetRange("Posting Date", gdateStartDate, gdateEndDate);
                    grecVendLedgerEntry.SetRange("Vendor No.", "Vendor No.");
                    if grecVendLedgerEntry.FindSet then begin
                        repeat
                            grecVendLedgerEntry.CalcFields("Original Amt. (LCY)");
                            gdecEmolument += grecVendLedgerEntry."Original Amt. (LCY)";

                            /* grecGLEntry.Reset();
                            grecGLEntry.SetCurrentKey("Entry No.");
                            grecGLEntry.SetRange("Bal. Account Type", grecGLEntry."Bal. Account Type"::"Bank Account");
                            grecGLEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                            grecGLEntry.SetRange("Payment Journal No.", grecVendLedgerEntry."Payment Journal No.");
                            grecGLEntry.SetRange(VAT, true);
                            if grecGLEntry.FindSet then begin
                                repeat
                                    gdecPAYEAmt += grecGLEntry.Amount;
                                until grecGLEntry.Next = 0;
                            end; */

                            grecDetailedVendLedgerEntry.Reset();
                            grecDetailedVendLedgerEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                            grecDetailedVendLedgerEntry.SetRange("Entry Type", grecDetailedVendLedgerEntry."Entry Type"::Application);
                            grecDetailedVendLedgerEntry.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Payment);
                            if grecDetailedVendLedgerEntry.FindFirst() then begin
                                grecDetailedVendLedgerEntry2.Reset();
                                grecDetailedVendLedgerEntry2.SetRange("Applied Vend. Ledger Entry No.", grecDetailedVendLedgerEntry."Applied Vend. Ledger Entry No.");
                                grecDetailedVendLedgerEntry2.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Invoice);
                                if grecDetailedVendLedgerEntry2.FindFirst() then begin
                                    repeat
                                        grecVendLedgerEntry2.Reset();
                                        grecVendLedgerEntry2.SetRange("Entry No.", grecDetailedVendLedgerEntry2."Vendor Ledger Entry No.");
                                        if grecVendLedgerEntry2.FindFirst then begin
                                            repeat
                                                grecPurchInvLine.Reset();
                                                grecPurchInvLine.SetRange("Document No.", grecVendLedgerEntry2."Document No.");
                                                grecPurchInvLine.SetRange(PAYE, true);
                                                if grecPurchInvLine.FindFirst() then
                                                    gdecPAYEAmt += grecPurchInvLine."Line Amount";
                                            until grecVendLedgerEntry2.Next = 0;
                                        end;
                                    until grecDetailedVendLedgerEntry2.Next = 0;
                                end;
                            end;

                        until grecVendLedgerEntry.Next = 0;
                    end;
                    gtextVendor := "Vendor No.";
                end else
                    CurrReport.Skip();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Date Filter")
                {
                    field("Start Date"; gdateStartDate) { ApplicationArea = All; }
                    field("End Date"; gdateEndDate) { ApplicationArea = All; }
                    field("Vendor No."; gcodeVendor)
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            Clear(gpageVendor);
                            grecVendor3.Reset();
                            grecVendor3.SetRange("Vendor Category", 'TUTOR');
                            if grecVendor3.FindFirst() then begin
                                gpageVendor.SetRecord(grecVendor3);
                                gpageVendor.SetTableView(grecVendor3);
                                gpageVendor.LookupMode(true);
                                if gpageVendor.RunModal() = Action::LookupOK then begin
                                    gpageVendor.GetRecord(grecVendor3);
                                    gcodeVendor := grecVendor3."No.";
                                end;
                            end;
                        end;
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if (gdateStartDate = 0D) or (gdateEndDate = 0D) then
            Error('Both dates should be filled in.');

        if gdateStartDate > gdateEndDate then
            Error('Start Date cannot be greater than End Date.');

        grecCompanyInfo.get;
        grecPurchPayableSetup.Get;
    end;

    var
        gtextVendor: Text;
        gtextVendorAddress: Text;
        gtextNID: text;
        grecCompanyInfo: Record "Company Information";
        gdateStartDate: Date;
        gdateEndDate: Date;
        grecVendor: Record Vendor;
        gtextVendorName: Text;
        grecVendLedgerEntry: Record "Vendor Ledger Entry";
        gdecEmolument: Decimal;
        grecGLEntry: Record "G/L Entry";
        gdecPAYEAmt: Decimal;
        grecPurchPayableSetup: Record "Purchases & Payables Setup";
        grecDetailedVendLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        grecDetailedVendLedgerEntry2: Record "Detailed Vendor Ledg. Entry";
        grecVendLedgerEntry2: Record "Vendor Ledger Entry";
        grecPurchInvLine: Record "Purch. Inv. Line";
        grecVendor2: Record Vendor;
        gcodeVendor: Code[20];
        grecVendor3: Record Vendor;
        gpageVendor: Page "Vendor List";
}