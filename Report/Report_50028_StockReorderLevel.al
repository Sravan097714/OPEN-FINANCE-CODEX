report 50028 "Stock Reorder Level"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\StockReorderLevel.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = where(Module = filter(false));
            column(CompanyName; grecCompany.Name) { }
            column(No_; "No.") { }
            column(Description; Description) { }
            column(Minimum_Order_Quantity; "Minimum Order Quantity") { }
            column(Maximum_Order_Quantity; "Maximum Order Quantity") { }
            column(Reorder_Quantity; "Reorder Quantity") { }
            column(Inventory; Inventory) { }
            column(gtextfilter; gtextfilter) { }
        }
    }

    trigger OnPreReport()
    begin
        grecCompany.get;
        gtextfilter := gcuFormatDoc.GetRecordFiltersWithCaptions(Item);
    end;

    var
        grecCompany: Record "Company Information";
        gtextfilter: Text;
        gcuFormatDoc: Codeunit "Format Document";
}