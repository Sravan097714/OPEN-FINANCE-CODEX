report 50048 "Deposits Outstanding Cheques"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'List of deposits and outstanding cheques';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\DepositsOutstandingCheques.rdl';

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = where("Statement Status" = filter('Open'));
            RequestFilterFields = "Posting Date", "Bank Account No.", "Document No.", "Payment Method Code";
            column(CompanyName; grecCompanyInfo.Name) { }
            column(Posting_Date; format("Posting Date")) { }
            column(BankCode; "Bank Account No.") { }
            column(BankName; gtextBankName) { }
            column(BankAccNo; gtextBankAccNo) { }
            column(DocumentNo; "Document No.") { }
            column(External_Document_No_; "External Document No.") { }
            column(Description; Description) { }
            column(Amount__LCY_; "Amount (LCY)") { }
            column(PaymentMethodDesc; gtextPaymentMethodDesc) { }
            column(gtextfilter; gtextfilter) { }

            trigger OnAfterGetRecord()
            begin
                Clear(gtextBankName);
                Clear(gtextBankAccNo);
                if grecBankAccount.get("Bank Account No.") then begin
                    gtextBankName := grecBankAccount.Name;
                    gtextBankAccNo := grecBankAccount."Bank Account No.";
                end;

                Clear(gtextPaymentMethodDesc);
                if grecPaymentMethod.Get("Payment Method Code") then
                    gtextPaymentMethodDesc := grecPaymentMethod.Description;
            end;
        }
    }

    trigger OnPreReport()
    var
        gcuFormatDocument: Codeunit "Format Document";
    begin
        gtextfilter := gcuFormatDocument.GetRecordFiltersWithCaptions("Bank Account Ledger Entry");
        grecCompanyInfo.get;
    end;

    var
        gtextBankName: Text;
        gtextBankAccNo: Text;
        gtextPaymentMethodDesc: Text;
        grecBankAccount: Record "Bank Account";
        grecPaymentMethod: Record "Payment Method";
        grecCompanyInfo: Record "Company Information";
        gtextfilter: Text;
}