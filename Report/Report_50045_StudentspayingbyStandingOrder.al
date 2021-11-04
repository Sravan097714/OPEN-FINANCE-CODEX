report 50045 "Students Pay By Standing Order"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'List of Students paying by Standing Order';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\StudentspayingbyStandingOrder.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = where("Document Type" = filter('Payment'), "Payment Method Code" = filter('STNDGORDER'), Reversed = filter(false));
            column(CompanyName; grecCompanyInfo.Name) { }
            column(gtextDateFilter; gtextDateFilter) { }
            column(Posting_Date; format("Posting Date")) { }
            column(ReceiptNumber; "Document No.") { }
            column(Description; Description) { }
            column(Original_Amt___LCY_; "Original Amt. (LCY)") { }
            column(CourseEnrolled; gtextProgramName) { }
            column(Intake; "Global Dimension 2 Code") { }

            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("Customer No.");
                DataItemTableView = sorting("No.");

                column(No_; "No.") { }
                column(Name; Name) { }
                column(Address; Address + ' ' + "Address 2") { }
                column(City; City) { }
            }

            trigger OnPreDataItem()
            begin
                SetFilter("Posting Date", gtextDateFilter);
            end;

            trigger OnAfterGetRecord()
            begin
                grecDimValue.Reset();
                grecDimValue.SetRange(Code, "Global Dimension 2 Code");
                if grecDimValue.FindFirst then
                    gtextProgramName := grecDimValue.Name;
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
        grecDimValue: Record "Dimension Value";
        gtextProgramName: Text;

}