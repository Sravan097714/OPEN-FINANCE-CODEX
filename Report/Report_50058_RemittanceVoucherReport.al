report 50058 "Remittance Voucher Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\RemittanceVoucher.rdl';

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = where("Source Code" = filter('PAYMENTJNL'), "Vendor Category" = filter('TUTOR'));
            CalcFields = "Original Amt. (LCY)";
            column(CompanyName; grecCompanyInfo.Name) { }
            column(CompanyAddress; grecCompanyInfo.Address) { }
            column(CompanyPhone; grecCompanyInfo."Phone No.") { }
            column(Posting_Date; format("Posting Date")) { }
            column(PV_Number; "PV Number") { }
            column(Vendor_Name; gtextVendorName) { }
            column(gtextAddress; gtextAddress) { }
            column(Original_Amt___LCY_; "Original Amt. (LCY)") { }
            column(gtextVendBankAcc; gtextVendBankAcc) { }
            column(gtextVendBank; gtextVendBank) { }
            column(vendorbankacc; vendorbankacc) { }
            column(vendorbank; vendorbank) { }
            column(Description; Description) { }
            column(gintEntryNo; gintEntryNo) { }
            column(Entry_No_; "Entry No.") { }
            column(Payment_Journal_No_; "Payment Journal No.") { }
            column(DescriptionVar; DescriptionVar) { }

            dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
            {
                DataItemLink = "Document No." = field("Document No.");
                DataItemTableView = where("Initial Document Type" = filter('Payment'), "Entry Type" = filter('Application'));

                dataitem(DetailedVendorLedgEntry2; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Applied Vend. Ledger Entry No." = field("Applied Vend. Ledger Entry No.");
                    DataItemTableView = where("Initial Document Type" = filter('Invoice'));

                    dataitem(VendorLedgerEntry2; "Vendor Ledger Entry")
                    {
                        DataItemLink = "Entry No." = field("Vendor Ledger Entry No.");

                        dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
                        {
                            DataItemLink = "Document No." = field("Document No.");
                            DataItemTableView = where("TDS Code" = filter(<> ''), "Line Amount" = filter(<> 0));

                            column(Description1; "Description 2") { }
                            column(PAYE1; abs(grecPurchInvLine."Line Amount")) { }

                            trigger OnAfterGetRecord()
                            begin
                                grecPurchInvLine.Reset();
                                grecPurchInvLine.SetRange("No.", "Purch. Inv. Line"."TDS Account No.");
                                if grecPurchInvLine.FindFirst then;
                            end;
                        }

                        dataitem(PurchInvLineVAT; "Purch. Inv. Line")
                        {
                            DataItemLink = "Document No." = field("Document No.");
                            DataItemTableView = where(VAT = filter(true), "Line Amount" = filter(<> 0));

                            column(Description2; "Description 2") { }
                            column(PAYE2; abs("VAT Amount Input")) { }
                        }

                        dataitem(PurchInvLineRetention; "Purch. Inv. Line")
                        {
                            DataItemLink = "Document No." = field("Document No.");
                            DataItemTableView = where("Retention Fee" = filter(true), "Line Amount" = filter(<> 0));

                            column(Description3; "Description 2") { }
                            column(PAYE3; abs(Amount)) { }
                        }

                        dataitem(PurchInvLinePAYE; "Purch. Inv. Line")
                        {
                            DataItemLink = "Document No." = field("Document No.");
                            DataItemTableView = where(PAYE = filter(true), quantity = filter(< 0));

                            column(Description4; "Description 2") { }
                            column(PAYE4; abs(Amount)) { }
                        }
                    }
                }

            }

            trigger OnAfterGetRecord()
            var
                VendLedEntry: Record "Vendor Ledger Entry";
                PurchInvLineLRec: Record "Purch. Inv. Line";
            begin

                Clear(gtextAddress);
                if grecVendor.get("Vendor No.") then begin
                    gtextVendorName := grecVendor.Name;
                    gtextAddress := grecVendor.Address + ' ' + grecVendor."Address 2";
                end;

                /* Clear(vendorbankacc);
                Clear(vendorbank);
                grecVendorBankAccount.Reset();
                grecVendorBankAccount.SetRange("Vendor No.", "Vendor No.");
                if grecVendorBankAccount.FindFirst() then begin
                    vendorbankacc := grecVendorBankAccount."Bank Account No.";
                    vendorbank := grecVendorBankAccount.Name; */

                Clear(vendorbankacc);
                Clear(vendorbank);
                grecVendor.Reset();
                grecVendor.SetRange("No.", "Vendor No.");
                if grecVendor.FindFirst then begin
                    vendorbank := grecVendor."Bank Name";
                    vendorbankacc := grecVendor."Bank Accout No."
                end;
                VendLedEntry.Reset();
                VendLedEntry.SetRange("Closed by Entry No.", "Vendor Ledger Entry"."Entry No.");
                if VendLedEntry.FindFirst() then begin
                    PurchInvLineLRec.Reset();
                    PurchInvLineLRec.SetRange("Document No.", VendLedEntry."Document No.");
                    if PurchInvLineLRec.FindFirst() then
                        DescriptionVar := PurchInvLineLRec."Description 2";
                end;

            end;

        }
    }


    trigger OnPreReport()
    begin
        grecCompanyInfo.get;
        gintEntryNo := 0;
    end;

    var
        grecCompanyInfo: Record "Company Information";
        grecVendor: Record Vendor;
        gtextAddress: Text;
        grecVendorBankAccount: Record 288;
        gtextVendBankAcc: Text;
        vendorbankacc: Text;
        vendorbank: Text;
        gtextVendBank: Text;
        gintEntryNo: Integer;
        gtextVendorName: Text;
        gtextDescription: Text;
        gdecTotal: Decimal;
        gdecAmount: Decimal;

        grecPurchInvLine: Record "Purch. Inv. Line";
        gdecTDSAmt: Decimal;
        DescriptionVar: Text;
}