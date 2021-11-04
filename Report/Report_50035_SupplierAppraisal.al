report 50035 "Supplier's Appraisal"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Suppliers Appraisal on Performance';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\SupplierAppraisal.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = where("Document Type" = filter('Order'), "Buy-from Vendor No." = filter(<> ''));

            column(gtextFilter; gtextFilter)
            { }
            column(No_; "No.") { }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No." + ' - ' + "Buy-from Vendor Name") { }
            column(Amount_Including_VAT; "Amount Including VAT") { }
            column(Price; Price) { }
            column(Quality; Quality) { }
            column(Responsiveness; Responsiveness) { }
            column(Delivery; Delivery) { }
            column(Average2; gdecAverage2) { }

            trigger OnPreDataItem()
            begin
                SetFilter("Posting Date", gtextFilter);
            end;

            trigger OnAfterGetRecord()
            begin
                Clear(gdecAverage2);
                Clear(gdecAverage);
                if Price <> '' then
                    Evaluate(gdecAverage, Price);
                gdecAverage2 += gdecAverage;

                Clear(gdecAverage);
                if Delivery <> '' then
                    Evaluate(gdecAverage, Delivery);
                gdecAverage2 += gdecAverage;

                Clear(gdecAverage);
                if Responsiveness <> '' then
                    Evaluate(gdecAverage, Responsiveness);
                gdecAverage2 += gdecAverage;

                Clear(gdecAverage);
                if Quality <> '' then
                    Evaluate(gdecAverage, Quality);
                gdecAverage2 += gdecAverage;

                Clear(gdecAverage);
                if gdecAverage2 <> 0 then
                    gdecAverage2 := gdecAverage2 / 4;
            end;
        }

        dataitem("Purchase Header Archive"; "Purchase Header Archive")
        {
            DataItemTableView = sorting("Document Type", "No.", "Doc. No. Occurrence", "Version No.") where("Buy-from Vendor No." = filter(<> ''));
            column(No_2; "No.") { }
            column(Buy_from_Vendor_No_2; "Buy-from Vendor No." + ' - ' + "Buy-from Vendor Name") { }
            column(Amount_Including_VAT2; "Amount Including VAT") { }
            column(Price2; Price) { }
            column(Quality2; Quality) { }
            column(Responsiveness2; Responsiveness) { }
            column(Delivery2; Delivery) { }
            column(Average3; gdecAverage3) { }

            trigger OnPreDataItem()
            begin
                SetFilter("Order Date", gtextFilter);
            end;

            trigger OnAfterGetRecord()
            begin
                if gtextDocNo <> "No." then begin
                    Clear(gdecAverage3);

                    Clear(gdecAverage);
                    if Price <> '' then
                        Evaluate(gdecAverage, Price);
                    gdecAverage3 += gdecAverage;

                    Clear(gdecAverage);
                    if Delivery <> '' then
                        Evaluate(gdecAverage, Delivery);
                    gdecAverage3 += gdecAverage;

                    Clear(gdecAverage);
                    if Responsiveness <> '' then
                        Evaluate(gdecAverage, Responsiveness);
                    gdecAverage3 += gdecAverage;

                    Clear(gdecAverage);
                    if Quality <> '' then
                        Evaluate(gdecAverage, Quality);
                    gdecAverage3 += gdecAverage;

                    if gdecAverage3 <> 0 then
                        gdecAverage3 := gdecAverage3 / 4;

                    gtextDocNo := "No.";
                end else
                    CurrReport.Skip();
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
                    field(Date; gtextFilter)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    var
        gtextFilter: Text;
        gdecAverage: Decimal;
        gdecAverage2: Decimal;
        gdecAverage3: Decimal;

        gtextDocNo: Text;
}