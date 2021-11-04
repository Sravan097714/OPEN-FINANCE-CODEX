report 50076 "SOE Finance.PJ No."
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //Caption = 'Statement of Emoluments Finance';
    RDLCLayout = 'Report\Layout\Emoluments2.rdl';
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

                            grecGLEntry.Reset();
                            grecGLEntry.SetCurrentKey("Entry No.");
                            grecGLEntry.SetRange("Bal. Account Type", grecGLEntry."Bal. Account Type"::"Bank Account");
                            grecGLEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                            grecGLEntry.SetRange("Payment Journal No.", grecVendLedgerEntry."Payment Journal No.");
                            grecGLEntry.SetRange(VAT, true);
                            if grecGLEntry.FindSet then begin
                                repeat
                                    gdecPAYEAmt += grecGLEntry.Amount;
                                until grecGLEntry.Next = 0;
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
}