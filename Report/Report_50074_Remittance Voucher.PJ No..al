report 50074 "Remittance Voucher.PJ No."
{
    UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\RemittanceVoucher2.rdl';


    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
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
            column(Description; Description) { }
            column(gintEntryNo; gintEntryNo) { }
            column(Entry_No_; "Entry No.") { }
            column(Payment_Journal_No_; "Payment Journal No.") { }

            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "Payment Journal No." = field("Payment Journal No.");
                DataItemTableView = where("Bal. Account Type" = filter('Bank Account'), "Source Type" = filter(<> 'Vendor'));
                column(Description1; gtextDescription) { }
                column(PAYE; "G/L Entry".Amount) { }

                trigger OnAfterGetRecord()
                begin
                    Clear(gtextDescription);
                    if "TDS Code" <> '' then
                        gtextDescription := 'TDS Code';

                    if "Retention Fee" then
                        gtextDescription := 'Retention';

                    if VAT then
                        gtextDescription := 'PAYE';

                    gintEntryNo += 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                gintEntryNo := 1;
                Clear(gtextAddress);
                if grecVendor.get("Vendor No.") then begin
                    gtextVendorName := grecVendor.Name;
                    gtextAddress := grecVendor.Address + ' ' + grecVendor."Address 2";
                end;

                Clear(gtextVendBankAcc);
                Clear(gtextVendBank);
                grecVendorBankAccount.Reset();
                grecVendorBankAccount.SetRange("Vendor No.", "Vendor No.");
                if grecVendorBankAccount.FindFirst() then begin
                    gtextVendBankAcc := grecVendorBankAccount."Bank Account No.";
                    gtextVendBank := grecVendorBankAccount.Code
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
        gtextVendBank: Text;
        gintEntryNo: Integer;
        gtextVendorName: Text;
        gtextDescription: Text;
        gdecTotal: Decimal;
}