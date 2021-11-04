report 50079 "Request for Purchase List"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\RequestForPurchList.rdl';

    dataset
    {
        dataitem("Requisition Line"; "Requisition Line")
        {
            RequestFilterFields = "Requested Date", "Requested By", "CRP/RFP", "No.", "Purchase Order No.", "Supplier Quotation No.", "Due Date";
            DataItemTableView = sorting("Worksheet Template Name", "Journal Batch Name", "Line No.");

            column(CompanyName; grecCompanyInfo.Name) { }
            column(Requested_Date; format("Requested Date")) { }
            column(SN; gintSN) { }
            column(Requisition_No_; "Requisition No.") { }
            column(CRP_RFP; "CRP/RFP") { }
            column(Requested_By; "Requested By") { }
            column(ItemNo_; "No.") { }
            column(Description; Description) { }
            column(Unit_of_Measure_Code; "Unit of Measure Code") { }
            column(Quantity; Quantity) { }
            column(Supplier_Quotation_No_; "Supplier Quotation No.") { }
            column(Purchase_Order_No_; "Purchase Order No.") { }
            column(Rate; Rate) { }
            column(Requisition_Amount; "Requisition Amount") { }
            column(DateSupplied; format("Due Date")) { }
            column(Remarks; Remarks) { }

            trigger OnAfterGetRecord()
            begin
                if gtextReqNo <> "Requisition No." then
                    gintSN += 1;
            end;
        }

        dataitem("Requisition Line Archive"; "Requisition Line Archive")
        {
            RequestFilterFields = "Requested Date", "Requested By", "CRP/RFP", "No.", "Purchase Order No.", "Supplier Quotation No.", "Due Date";
            DataItemTableView = sorting("Worksheet Template Name", "Journal Batch Name", "Line No.");

            column(Requested_Date2; format("Requested Date")) { }
            column(SN2; gintSN2) { }
            column(Requisition_No_2; "Requisition No.") { }
            column(CRP_RFP2; "CRP/RFP") { }
            column(Requested_By2; "Requested By") { }
            column(ItemNo_2; "No.") { }
            column(Description2; Description) { }
            column(Unit_of_Measure_Code2; "Unit of Measure Code") { }
            column(Quantity2; Quantity) { }
            column(Supplier_Quotation_No_2; "Supplier Quotation No.") { }
            column(Purchase_Order_No_2; "Purchase Order No.") { }
            column(Rate2; Rate) { }
            column(Requisition_Amount2; "Requisition Amount") { }
            column(DateSupplied2; format("Due Date")) { }
            column(Remarks2; Remarks) { }

            trigger OnPreDataItem()
            var
                gtextfilter: Text;
            begin
                gtextfilter := "Requisition Line".GetView;
                "Requisition Line Archive".SetView(gtextfilter);
            end;

            trigger OnAfterGetRecord()
            begin
                if gtextReqNo2 <> "Requisition No." then
                    gintSN2 += 1;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    /* field(Name; SourceExpression)
                    {
                        ApplicationArea = All;

                    } */
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    trigger OnPreReport()
    begin
        gintSN := 0;
        gintSN2 := 0;

        grecCompanyInfo.get;
    end;

    var
        gintSN: Integer;
        gintSN2: Integer;
        gtextReqNo: Text;
        gtextReqNo2: Text;

        grecCompanyInfo: Record "Company Information";
}