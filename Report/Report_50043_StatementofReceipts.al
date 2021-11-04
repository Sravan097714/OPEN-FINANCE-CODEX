report 50043 "Statement of Receipts"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\StatementofReceipts.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = where("Document Type" = filter('Payment'), Reversed = filter(false));
            RequestFilterFields = "Customer No.";
            column(CompanyName; grecCompanyInfo.Name) { }
            column(gtextDateFilter; gtextDateFilter) { }
            column(Posting_Date; format("Posting Date")) { }
            column(ReceiptNumber; "Document No.") { }
            column(Description; Description) { }
            column(Currency_Code; "Currency Code") { }
            column(Original_Amt___LCY_; Amount) { }

            column(No_; grecCustomer."No.") { }
            column(Name; grecCustomer.Name) { }
            column(Address; grecCustomer.Address + ' ' + grecCustomer."Address 2") { }
            column(City; grecCustomer.City) { }

            dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
            {
                DataItemLink = "Document No." = field("Document No.");
                DataItemTableView = where("Entry Type" = filter('Application'), "Initial Document Type" = filter('Payment'));

                dataitem(DetailedCustLedgEntry2; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Applied Cust. Ledger Entry No." = field("Applied Cust. Ledger Entry No.");
                    DataItemTableView = where("Initial Document Type" = filter('Invoice'));

                    column(Currency_Code2; "Currency Code") { }
                    column(Amount2; Amount) { }

                    dataitem(CustLedgerEntry2; "Cust. Ledger Entry")
                    {
                        DataItemLink = "Entry No." = field("Cust. Ledger Entry No.");
                        column(Document_No_2; "Document No.") { }
                        column(Description2; Description) { }
                    }
                }
            }

            trigger OnPreDataItem()
            begin
                SetFilter("Posting Date", gtextDateFilter);
            end;

            trigger OnAfterGetRecord()
            begin
                if grecCustomer.get("Customer No.") then;
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
        grecCompanyInfo: Record "Company Information";
        grecCustomer: Record Customer;

    procedure SetDateFilter(ptextDateFilter: Date)
    begin
        gtextDateFilter := format(ptextDateFilter);
    end;
}