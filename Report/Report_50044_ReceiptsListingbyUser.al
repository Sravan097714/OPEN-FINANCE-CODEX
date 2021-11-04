report 50044 "Receipts Listing by User"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\ReceiptsListingbyUser.rdl';

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            RequestFilterFields = "Bank Account No.", "Bal. Account Type", "Bal. Account No.", "Currency Code", Amount, "Amount (LCY)", "Document No.", "User ID";

            column(CompanyName; grecCompanyInfo.Name) { }
            column(gtextDateFilter; gtextDateFilter) { }
            column(Posting_Date; format("Posting Date")) { }
            column(ReceiptNumber; "Document No.") { }
            column(Description; Description) { }
            column(Amount; Amount) { }
            column(Currency_Code; "Currency Code") { }
            column(Amount__LCY_; "Amount (LCY)") { }
            column(gtextCustomerNo; gtextCustomerNo) { }
            column(gtextCustName; gtextCustName) { }
            column(Journal_Batch_Name; "Journal Batch Name") { }
            column(User_ID; "User ID") { }
            column(gtextUserName; gtextUserName) { }


            trigger OnPreDataItem()
            begin
                SetFilter("Posting Date", gtextDateFilter);
                SetRange("Source Code", 'CASHRECJNL');
            end;

            trigger OnAfterGetRecord()
            begin
                Clear(gtextCustomerNo);
                Clear(gtextCustName);
                if grecCustomer.get("Bal. Account No.") then begin
                    gtextCustomerNo := "Bal. Account No.";
                    gtextCustName := grecCustomer.Name;
                end;
                if "Bal. Account Type" = "Bal. Account Type"::"G/L Account" then
                    gtextCustName := Payee;

                Clear(gtextUserName);
                grecUser.reset;
                grecUser.SetRange("User Name", "User ID");
                if grecUser.findfirst then
                    gtextUserName := grecUser."Full Name";
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
        grecUser: Record User;
        gtextUserName: Text;
        grecCompanyInfo: Record "Company Information";
        gtextCustomerNo: Text;
        gtextCustName: Text;
        grecCustomer: Record Customer;
        grecGLAccount: Record "G/L Account";
}