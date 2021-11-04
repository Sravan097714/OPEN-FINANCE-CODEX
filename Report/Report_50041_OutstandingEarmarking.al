report 50041 "Outstanding Earmarking"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Outstanding Earmarking by Earmarked Date';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\OutstandingEarmarking.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("No.") where("Document Type" = filter('Order' | 'Invoice' | 'Credit Memo'), "Earmark ID" = filter(<> ''));
            RequestFilterFields = "Order Date", "No.", "Earmark ID";
            column(gtextDateFilter; gtextDateFilter) { }
            column(CompanyName; grecCompanyInfo.Name) { }
            column(DocNo_; "No.") { }
            column(Order_Date; format("Order Date")) { }

            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where("G/L Account for Budget" = filter(<> ''));
                RequestFilterFields = "No.";
                column(Document_Type; "Document Type") { }
                column(No_; "No.") { }
                column(gtextAccountType; gtextAccountType) { }
                column(Type; Type) { }
                column(Description; Description) { }
                column(GLName; gtextGLName) { }
                column(Earmark_ID; "Earmark ID") { }
                column(Amount_Earmarked; "Line Amount") { }
                column(Date_Earmarked; format("Date Earmarked")) { }

                trigger OnAfterGetRecord()
                begin
                    clear(gtextGLName);
                    if grecGLAccount.get("G/L Account for Budget") then begin
                        gtextGLName := grecGLAccount.Name;
                        gtextAccountType := format(grecGLAccount."Account Type");
                    end;
                end;
            }

            trigger OnPreDataItem()
            begin
                gtextDateFilter := "Purchase Header".GetFilter("Order Date");
            end;
        }
    }

    trigger OnPreReport()
    begin
        grecCompanyInfo.get;
    end;


    var
        grecCompanyInfo: Record "Company Information";
        grecGLAccount: Record "G/L Account";
        gtextGLName: Text;
        gtextAccountType: Text;
        gtextDateFilter: Text;
}