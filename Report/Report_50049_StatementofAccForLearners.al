report 50049 "Statement of Account Leaners"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Statement of Account for Leaners';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\StatementofAccLearners.rdl';

    dataset
    {
        dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
        {
            DataItemTableView = where("Source Code" = filter('CASHRECJNL'), "Entry Type" = filter('Initial Entry'));
            RequestFilterFields = "Customer No.", "Initial Entry Global Dim. 1";
            PrintOnlyIfDetail = true;

            column(Customer_No_; "Customer No.") { }
            column(CustName; gtextCustName) { }
            column(Initial_Entry_Global_Dim__1; "Initial Entry Global Dim. 1") { }
            column(DimName2; gtextDimName2) { }

            column(CompanyPicture; grecCompanyInfo.Picture) { }
            column(CompanyName; grecCompanyInfo.Name) { }
            column(CompanyAddr; grecCompanyInfo.Address) { }
            column(Country; gtextCountry) { }
            column(CompanyVAT; grecCompanyInfo."VAT Registration No.") { }
            column(CompanyBRN; grecCompanyInfo.BRN) { }

            column(Signature; grecSalesReceivableSetup."Sign for Statement of Accounts") { }

            dataitem(DetailedCustLedgEntry2; "Detailed Cust. Ledg. Entry")
            {
                DataItemLink = "Applied Cust. Ledger Entry No." = field("Cust. Ledger Entry No.");
                DataItemTableView = sorting("Entry No.") where("Initial Document Type" = filter('Invoice'), Unapplied = filter(false));
                PrintOnlyIfDetail = true;

                column(Amount; Amount * -1) { }

                dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                {
                    DataItemLink = "Entry No." = field("Cust. Ledger Entry No.");
                    RequestFilterFields = "Customer No.", "Global Dimension 1 Code";

                    column(DimName; gtextDimName) { }

                    trigger OnAfterGetRecord()
                    begin
                        Clear(gtextDimName);
                        if grecDimensionValue.get('INTAKE', "Global Dimension 2 Code") then
                            gtextDimName := grecDimensionValue.Name;
                    end;
                }
            }
            trigger OnAfterGetRecord()
            begin
                Clear(gtextCustName);
                if grecCustomer.get("Customer No.") then
                    gtextCustName := grecCustomer.Name;

                Clear(gtextDimName2);
                if grecDimensionValue.get('PROGRAMME', "Initial Entry Global Dim. 1") then
                    gtextDimName := grecDimensionValue."Name 2";
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("Posting Date", '<=%1', gdatefilter);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Date)
                {
                    field("Date Filter"; gdatefilter)
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
        grecCompanyInfo.CalcFields(Picture);

        Clear(gtextCountry);
        if grecCountry.Get(grecCompanyInfo."Country/Region Code") then
            gtextCountry := grecCountry.Name;

        grecSalesReceivableSetup.get;
    end;

    var
        gdatefilter: Date;
        grecCustomer: Record Customer;
        gtextCustName: Text;
        grecDimensionValue: Record "Dimension Value";
        gtextDimName: Text;
        gtextDimName2: Text;
        grecCompanyInfo: Record "Company Information";
        grecSalesReceivableSetup: Record "Sales & Receivables Setup";
        grecCountry: Record "Country/Region";
        gtextCountry: Text;
}