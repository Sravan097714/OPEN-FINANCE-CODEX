report 50056 "Fixed Asset Inventory Sheet"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\FixedAssetInventorySheet.rdl';

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "FA Class Code", "FA Subclass Code", "FA Location Code", "Responsible Employee";

            column(CompanyName; grecCompanyInfo.Name) { }
            column(gintEntry; gintEntry) { }
            column(FA_Location_Code; "FA Location Code") { }
            column(FA_No_; "No.") { }
            column(Description; Description) { }
            column(Responsible_Employee; "Responsible Employee") { }
            column(FA_Subclass_Code; "FA Subclass Code") { }
            column(Make; Make) { }
            column(SerialNo; "Serial No.") { }
            column(PONumber; grecPurchInvHdr."Order No.") { }
            column(DateOfPurchase; FORMAT(grecFALedgerEntry."Posting Date")) { }
            column(gtextFilter; gtextFilter) { }

            trigger OnAfterGetRecord()
            begin
                gintEntry += 1;

                grecFALedgerEntry.Reset();
                grecFALedgerEntry.SetCurrentKey("Entry No.");
                grecFALedgerEntry.SetRange("FA No.", "No.");
                grecFALedgerEntry.SetRange("FA Posting Type", grecFALedgerEntry."FA Posting Type"::"Acquisition Cost");
                grecFALedgerEntry.SetRange("FA Posting Category", grecFALedgerEntry."FA Posting Category"::" ");
                grecFALedgerEntry.SetRange(Reversed, false);
                if grecFALedgerEntry.FindFirst() then
                    if grecPurchInvHdr.Get(grecFALedgerEntry."Document No.") then;
            end;

            trigger OnPreDataItem()
            begin
                gtextFilter := "Fixed Asset".GetFilters;
            end;
        }
    }

    trigger OnPreReport()
    begin
        grecCompanyInfo.get;
        gintEntry := 0;

        /* if "Fixed Asset".GetFilter("FA Location Code") = '' then
            Error('Please insert a Location first.'); */
    end;


    var
        grecCompanyInfo: Record "Company Information";
        gintEntry: Integer;
        grecFALedgerEntry: Record "FA Ledger Entry";
        grecPurchInvHdr: Record "Purch. Inv. Header";
        gtextFilter: Text;
}