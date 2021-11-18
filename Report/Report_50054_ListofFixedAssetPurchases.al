report 50054 "List of Fixed Asset Purchases"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\FixedAssetPurchases.rdl';

    dataset
    {
        dataitem("FA Ledger Entry"; "FA Ledger Entry")
        {
            DataItemTableView = sorting("Entry No.") where("FA Posting Type" = filter('Acquisition Cost'), "FA Posting Category" = filter(''), Reversed = filter(false));
            RequestFilterFields = "FA No.";

            column(CompanyName; grecCompanyInfo.Name) { }
            column(StartDate; format(gdateStartDate)) { }
            column(EndDate; format(gdateEndDate)) { }
            column(FA_Class_Code; "FA Class Code") { }
            column(FA_Subclass_Code; "FA Subclass Code") { }
            column(Document_No_; "Document No.") { }
            column(FA_No_; "FA No.") { }
            column(Posting_Date; format("Posting Date")) { }
            column(Description; Description) { }
            column(Make; grecFixedAsset.Make) { }
            column(SerialNo; grecFixedAsset."Serial No.") { }
            column(Supplier; grecPurchInvHdr."Buy-from Vendor Name") { }
            column(PONumber; grecPurchInvHdr."Order No.") { }
            column(Cost; Amount) { }
            column(Life; grecFADeprBook."No. of Depreciation Years") { }
            column(FA_Supplier_No_; "FA Supplier No.") { }
            column(VendorRec_Name; VendorRec.Name) { }

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", gdateStartDate, gdateEndDate);
            end;

            trigger OnAfterGetRecord()
            begin
                if grecFixedAsset.Get("FA No.") then;
                if grecPurchInvHdr.Get("Document No.") then;
                if grecFADeprBook.Get("FA No.", "Depreciation Book Code") then;
                if not VendorRec.Get("FA Supplier No.") then
                    Clear(VendorRec.Name);
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
        if gdateStartDate > gdateEndDate then
            Error('Start Date should be less or equal to End Date.');
        grecCompanyInfo.get;
    end;


    var
        gdateStartDate: Date;
        gdateEndDate: Date;
        grecCompanyInfo: Record "Company Information";
        grecFixedAsset: Record "Fixed Asset";
        grecPurchInvHdr: Record "Purch. Inv. Header";
        grecFADeprBook: Record "FA Depreciation Book";
        VendorRec: Record Vendor;

}