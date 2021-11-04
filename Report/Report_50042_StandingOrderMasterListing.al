report 50042 "Standing Order Master Listing"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\StandingOrderMasterListing.rdl';

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = where("Bal. Account Type" = filter('Vendor'), "Document Type" = filter('Payment'), "Payment Method Code" = filter('DIRECTDEBT'));
            RequestFilterFields = "Document Type", "Document No.", "Bank Account No.", "Bal. Account Type", "Bal. Account No.";
            column(CompanyName; grecCompanyInfo.Name) { }
            column(gtextDateFilter; gtextDateFilter) { }
            column(Posting_Date; format("Posting Date")) { }
            column(DocumentNo; "Document No.") { }
            column(VendorNo; "Bal. Account No.") { }
            column(VendorName; gtextVendorName) { }
            column(Amount__LCY_; ABS("Amount (LCY)")) { }
            column(Description; Description) { }

            trigger OnPreDataItem()
            begin
                SetFilter("Posting Date", gtextDateFilter);
            end;

            trigger OnAfterGetRecord()
            begin
                Clear(gtextVendorName);
                if grecVendor.get("Bal. Account No.") then begin
                    gtextVendorName := grecVendor.Name;
                end;
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
        gtextVendorName: Text;
        grecVendor: Record Vendor;
        grecCompanyInfo: Record "Company Information";
}