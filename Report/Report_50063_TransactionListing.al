report 50063 "Transaction Listing"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\TransactionListing.rdl';

    dataset
    {
        dataitem("Value Entry"; "Value Entry")
        {
            column(CompanyName; grecCompanyInfo.Name) { }
            column(CompanyAddress; grecCompanyInfo.Address) { }
            column(gdateEndDate; gdateEndDate) { }
            column(Posting_Date; format("Posting Date")) { }
            column(Document_No_; "Document No.") { }
            //column(Document_Type; item) { }
            column(Document_Type; "Item Ledger Entry Type") { }
            column(Item_No_; "Item No.") { }
            column(Description; Description) { }
            column(Item_Ledger_Entry_Quantity; "Item Ledger Entry Quantity") { }
            column(gdecAmount; gdecAmount) { }
            column(Source_No_; "Source No.") { }
            column(VendorName; grecVendor.Name) { }
            column(gintCount; gintCount) { }

            trigger OnAfterGetRecord()
            begin
                if grecItem.Get("Item No.") then begin
                    if grecItem.Module then
                        CurrReport.Skip();
                end;

                if not grecVendor.get("Source No.") then
                    Clear(grecVendor);

                Clear(gdecAmount);
                if "Cost Amount (Actual)" <> 0 then
                    gdecAmount := "Cost Amount (Actual)"
                else
                    gdecAmount := "Cost Amount (Expected)";

                //gintCount += 1;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", gdateStartDate, gdateEndDate);

                grecValueEntry.Reset();
                grecValueEntry.SetRange("Posting Date", gdateStartDate, gdateEndDate);
                gintCount := grecValueEntry.Count;

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Date Filter")
                {
                    field("Start Date"; gdateStartDate) { ApplicationArea = All; }
                    field("End Date"; gdateEndDate) { ApplicationArea = All; }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if (gdateStartDate = 0D) or (gdateEndDate = 0D) then
            Error('Please input Start Date and End Date.');

        if gdateStartDate > gdateEndDate then
            Error('Start Date should be less or equal to End Date.');

        grecCompanyInfo.get;
        gintCount := 0;
    end;

    var
        grecCompanyInfo: Record "Company Information";
        gdateStartDate: Date;
        gdateEndDate: Date;
        grecVendor: Record Vendor;
        gdecAmount: Decimal;
        gintCount: Integer;
        grecItem: Record Item;
        grecValueEntry: Record "Value Entry";
}