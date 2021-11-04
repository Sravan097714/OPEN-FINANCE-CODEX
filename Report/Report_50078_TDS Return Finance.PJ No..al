report 50078 "TDS Return Finance.PJ No."
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\TDSReturn2.rdl';


    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = sorting("Vendor No.", "Posting Date", "Currency Code") where("Document Type" = filter('PAYMENT'));
            column(CompanyName; grecCompanyInfo.Name) { }
            column(CompanyBRN; grecCompanyInfo.BRN) { }
            column(CompanyPhone; grecCompanyInfo."Phone No.") { }
            column(CompanyMobile; grecCompanyInfo."Mobile Number") { }
            column(NameofDeclarant; grecCompanyInfo."Name Of Declarant") { }
            column(VATEmail; grecCompanyInfo."MRA VAT Email Address") { }


            column(gtextNID; gtextNID) { }
            column(VendorName; gtextVendorName) { }
            column(gtextVendorName2; gtextVendorName2) { }
            column(gdecEmolument; gdecEmolument) { }
            column(gdecPAYEAmt; gdecPAYEAmt) { }


            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", gdateStartDate, gdateEndDate);
            end;

            trigger OnAfterGetRecord()
            begin
                if gtextVendor <> "Vendor No." then begin
                    clear(gtextNID);
                    clear(gtextVendorName);
                    Clear(gtextVendorName2);
                    if grecVendor.get("Vendor No.") then begin
                        gtextNID := grecVendor.NID;
                        gtextVendorName := grecVendor.Name;
                        gtextVendorName2 := grecVendor."Name 2";
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
                            grecGLEntry.SetFilter("TDS Code", '<> %1', '');
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
        grecCompanyInfo.get;
        gtextVendor := '';
    end;

    var
        grecCompanyInfo: Record "Company Information";
        gdateStartDate: Date;
        gdateEndDate: Date;
        grecVendor: Record Vendor;
        gtextVendorName: Text;
        gtextVendorName2: Text;
        gtextNID: Text;
        grecVendLedgerEntry: Record "Vendor Ledger Entry";
        gdecEmolument: Decimal;
        gdecPAYEAmt: Decimal;
        grecGLEntry: Record "G/L Entry";
        gtextVendor: Text;
}
