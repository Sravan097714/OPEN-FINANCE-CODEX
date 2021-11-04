report 50036 "List of Payment Vouchers"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\ListofPaymentVoucher.rdl';

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = where("Document Type" = filter('Payment'), "PV Number" = filter(<> ''));
            RequestFilterFields = "Document Type", "Document No.", "Bank Account No.", "Bal. Account Type", "Bal. Account No.", "PV Number";
            column(CompanyName; grecCompanyInfo.Name) { }
            column(Posting_Date; format("Posting Date")) { }
            column(PV_No; "PV Number") { }
            column(PayeeName; Payee) { }
            column(Amount__LCY_; "Amount (LCY)") { }
            column(ChequeNo; "Document No.") { }
            column(BankName; gtextBankName) { }
            column(gtextDateFilter; gtextDateFilter) { }

            trigger OnPreDataItem()
            begin
                SetFilter("Posting Date", gtextDateFilter);
            end;

            trigger OnAfterGetRecord()
            begin
                Clear(gtextBankName);
                if grecBankAccount.get("Bank Account No.") then
                    gtextBankName := grecBankAccount.Name;
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
        gtextDateFilter: Text;
        gtextBankName: Text;
        grecBankAccount: Record "Bank Account";
        grecCompanyInfo: Record "Company Information";
}