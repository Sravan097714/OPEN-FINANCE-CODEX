report 50033 "Fixed Asset Inventory"
{
    UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\FixedAssetByLocation.rdl';
    Caption = 'Fixed Asset Inventory List By Location';

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            RequestFilterFields = "FA Location Code";
            column(No_; "No.") { }
            column(Description; Description) { }
            column(Serial_No_; "Serial No.") { }
            column(FA_Posting_Group; "FA Posting Group") { }
        }
    }
}