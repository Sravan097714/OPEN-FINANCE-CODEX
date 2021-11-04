report 50037 "List of Supplier Payments"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\ListofSupplierPayments.rdl';

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = where("Document Type" = filter('Payment'));//, "Vendor Category" = filter('<>TUTOR'));
            RequestFilterFields = "Document Type", "Document No.", "Bal. Account Type", "Bal. Account No.", "PV Number";
            column(CompanyName; grecCompanyInfo.Name) { }
            column(Posting_Date; format("Posting Date")) { }
            column(PV_No; "PV Number") { }
            column(VendorNo; "Vendor No.") { }
            //column(VendorName; gtextVendorName) { }
            column(Vendor_Name; "Vendor Name") { }
            column(VendorBRN; gtextVendorBRN) { }
            column(vendbrn; vendbrn) { }
            column(Amount__LCY_; "Amount (LCY)") { }
            column(ChequeNo; "Document No.") { }
            column(BankName; gtextBankName) { }
            column(BankAccNo; gtextBankAccNo) { }
            column(gtextDateFilter; gtextDateFilter) { }

            dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
            {
                DataItemLink = "Document No." = field("Document No.");
                DataItemTableView = where("Initial Document Type" = filter('Payment'), "Entry Type" = filter('Initial Entry'));

                dataitem(DetailedVendorLedgEntry2; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Applied Vend. Ledger Entry No." = field("Vendor Ledger Entry No.");
                    DataItemTableView = where("Initial Document Type" = filter('Invoice'));

                    dataitem(VendorLedgerEntry2; "Vendor Ledger Entry")
                    {
                        DataItemLink = "Entry No." = field("Vendor Ledger Entry No.");
                        DataItemTableView = where("Vendor Category" = filter(<> 'TUTOR'));

                        dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
                        {
                            DataItemLink = "Document No." = field("Document No.");

                            column(Document_No_; "Document No.") { }
                            column(DescriptionPurchInvLine; Description) { }
                            column(G_L_Account_for_Budget; "G/L Account for Budget") { }
                            column(gdecAmount; gdecAmount) { }
                            column(gdecTDS; gdecTDS) { }
                            column(gdecPAYE; gdecPAYE) { }
                            column(gdecVAT; gdecVAT) { }
                            column(gdecRetention; gdecRetention) { }
                            column(grecPurchInvHdr; grecPurchInvHdr."Currency Code") { }

                            trigger OnAfterGetRecord()
                            begin
                                if grecPurchInvHdr.Get("Purch. Inv. Line"."Document No.") then;

                                clear(gdecAmount);
                                grecPurchInvLine.Reset();
                                grecPurchInvLine.SetRange("Document No.", "Document No.");
                                grecPurchInvLine.SetRange("TDS Code", '');
                                grecPurchInvLine.SetRange(PAYE, false);
                                grecPurchInvLine.SetRange("Retention Fee", false);
                                if grecPurchInvLine.FindFirst() then
                                    gdecAmount := grecPurchInvLine.Amount;

                                grecPurchInvLine.Reset();
                                grecPurchInvLine.SetRange("Document No.", "Document No.");
                                grecPurchInvLine.SetFilter("TDS Code", '<>%1', '');
                                if grecPurchInvLine.FindFirst() then
                                    gdecTDS := grecPurchInvLine.Amount;

                                grecPurchInvLine.Reset();
                                grecPurchInvLine.SetRange("Document No.", "Document No.");
                                grecPurchInvLine.SetFilter("TDS Code", '<>%1', '');
                                if grecPurchInvLine.FindFirst() then
                                    gdecTDS := grecPurchInvLine.Amount;

                                grecPurchInvLine.Reset();
                                grecPurchInvLine.SetRange("Document No.", "Document No.");
                                grecPurchInvLine.SetRange(PAYE, true);
                                if grecPurchInvLine.FindFirst() then
                                    gdecPAYE := grecPurchInvLine.Amount;

                                grecPurchInvLine.Reset();
                                grecPurchInvLine.SetRange("Document No.", "Document No.");
                                grecPurchInvLine.SetRange(VAT, true);
                                if grecPurchInvLine.FindFirst() then
                                    gdecVAT := grecPurchInvLine.Amount;

                                grecPurchInvLine.Reset();
                                grecPurchInvLine.SetRange("Document No.", "Document No.");
                                grecPurchInvLine.SetRange("Retention Fee", true);
                                if grecPurchInvLine.FindFirst() then
                                    gdecRetention := grecPurchInvLine.Amount;
                            end;
                        }
                    }
                }

            }


            trigger OnPreDataItem()
            begin
                SetFilter("Posting Date", gtextDateFilter);
            end;

            trigger OnAfterGetRecord()
            begin
                if grecVendor.get("Bal. Account No.") then begin
                    if grecVendor."Vendor Category" = 'TUTOR' then
                        CurrReport.Skip();
                end;

                Clear(gtextBankName);
                Clear(gtextBankAccNo);
                if grecBankAccount.get("Bal. Account No.") then begin
                    gtextBankName := grecBankAccount.Name;
                    gtextBankAccNo := grecBankAccount."Bank Account No.";
                end;

                /* Clear(gtextVendorName);
                Clear(gtextVendorBRN);
                if grecVendor.get("Bal. Account No.") then begin
                    gtextVendorName := grecVendor.Name;
                    gtextVendorBRN := grecVendor.BRN;
                end; */
                Clear(vendbrn);
                grecVendor.Reset();
                grecVendor.SetRange("No.", "Vendor No.");
                if grecVendor.FindFirst then
                    vendbrn := grecVendor.BRN;

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Date Filter ")
                {
                    field("Date Filter"; gtextDateFilter)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        grecCompanyInfo.get;
    end;

    var
        grecCompanyInfo: Record "Company Information";
        gtextDateFilter: Text;

        gtextBankName: Text;
        gtextBankAccNo: Text;
        gtextVendorName: Text;
        gtextVendorBRN: Text;
        vendbrn: Text;

        grecVendor: Record Vendor;
        grecBankAccount: Record "Bank Account";

        grecDetVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        grecDetVendLedgEntry2: Record "Detailed Vendor Ledg. Entry";
        grecVendLedgerEntry: Record "Vendor Ledger Entry";
        grecPurchInvHdr: Record "Purch. Inv. Header";
        grecPurchInvLine: Record 123;

        gdecAmount: Decimal;
        gdecTDS: Decimal;
        gdecPAYE: Decimal;
        gdecVAT: Decimal;
        gdecRetention: Decimal;
        gcodeCurrency: Text;
}