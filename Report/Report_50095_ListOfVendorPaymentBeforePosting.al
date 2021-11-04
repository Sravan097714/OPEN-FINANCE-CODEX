report 50095 "List of Vendor Pymts Bfr Post"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'List Of Payments Before Posting';
    RDLCLayout = 'Report\Layout\ListofVendorPymtsBfrPost.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            CalcFields = Amount;
            DataItemTableView = SORTING("Document Type", "No.") where(Amount = filter(<> 0));
            RequestFilterFields = "Posting Date", "Document Type", "No.", "Buy-from Vendor No.", "Buy-from Vendor Name", Status;
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(ReportNameCaption; ReportNameCaptionLbl) { }
            column(DatePrintedCaption; DatePrintedCaptionLbl) { }
            column(PrintedByCaption; PrintedByCaptionLbl) { }
            column(DocNoCaption; DocNoCaptionLbl) { }
            column(AccNoCaption; AccNoCaptionlbl) { }
            column(AccNameCaption; AccNameCaptionLbl) { }
            column(Des2Caption; Des2CaptionLbl) { }
            column(AmtCaption; AmtCaptionLbl) { }
            column(AmtExcVatCaption; AmtExcVatCaptionLbl) { }
            column(PreparedByCaption; PreparedByCaptionLbl) { }
            column(ListCheckedCaption; ListCheckedCaptionLbl) { }
            column(InputMadeByCaptionLbl; InputMadeByCaptionLbl) { }
            column(CorrectionMadeCaption; CorrectionMadeCaptionLbl) { }
            column(FinalListingCaption; FinalListingCaptionLbl) { }
            column(RecCountCaption; RecCountCaptionLbl) { }
            column(RecordCount; RecordCount) { }
            column(VendorNameCaptionLbl; VendorNameCaptionLbl) { }
            column(VendorNoCaptionLbl; VendorNoCaptionLbl) { }
            column(GLBudgetNameCaptionLbl; GLBudgetNameCaptionLbl) { }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
            column(No_PH; "No.") { }
            column(UserID; UserId) { }
            column(PrintDate; format(Today, 0)) { }
            column(ReportFilters; ReportFilters) { }

            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                column(Document_No_; "Document No.") { }
                column(No_; "No.") { }
                column(Description; Description) { }
                column(Line_Amount; "Line Amount") { }
                column(Line_Amount_Excluding_VAT; "Line Amount Excluding VAT") { }
                column(Document_Type; "Document Type") { }
                column(PreParedBy; "Purchase Header"."Created By") { }
                column(G_L_Account_for_Budget; "G/L Account for Budget") { }
                column(Description_2; "Description 2") { }
                column(TotalAmt; TotalAmt) { }
                column(TotalAmtExcVat; TotalAmtExcVat) { }
                column(GLAccBudgetName; GLAccBudgetName) { }
                trigger OnAfterGetRecord()
                var
                    GLAcc: Record "G/L Account";
                begin
                    IF ("Purchase Line"."No." = '') and
                       (Amount = 0) and
                       ("Purchase Line".Description = '') and
                       ("Purchase Line"."Description 2" = '') then
                        CurrReport.Skip();
                    if not GLAcc.Get("G/L Account for Budget") then
                        Clear(GLAccBudgetName);
                    GLAccBudgetName := GLAcc.Name;
                    RecordCount += 1;
                    TotalAmt += "Line Amount";
                    TotalAmtExcVat += "Line Amount Excluding VAT";

                end;
            }
            trigger OnPreDataItem()
            begin
                Clear(RecordCount);
                Clear(TotalAmt);
                Clear(TotalAmtExcVat);
                ReportFilters := GetFilters;
            end;

            trigger OnAfterGetRecord()
            begin
                /* Clear(RecordCount);
                Clear(TotalAmt);
                Clear(TotalAmtExcVat); */
                ReportFilters := GetFilters;
            end;
        }


    }


    trigger OnPreReport()
    begin
        CompanyInfo.Get();
    end;

    var
        CompanyInfo: Record "Company Information";
        DatePrintedCaptionLbl: Label 'Date Printed :';
        PrintedByCaptionLbl: Label 'Printed By :';
        DocNoCaptionLbl: Label 'Document No.';
        AccNoCaptionlbl: Label 'Account No.';
        AccNameCaptionLbl: Label 'Account Name';
        Des2CaptionLbl: Label 'Description 2';
        AmtCaptionLbl: Label 'Amount';
        AmtExcVatCaptionLbl: Label 'Amount Exc VAT';
        PreparedByCaptionLbl: Label 'Prepared By';
        ListCheckedCaptionLbl: Label 'Listing checked by           :';
        InputMadeByCaptionLbl: Label 'Input made by           :';

        CorrectionMadeCaptionLbl: Label 'Corrections made by      :';
        FinalListingCaptionLbl: Label 'Final Listings checked by :';
        RecCountCaptionLbl: Label 'Record count reached     :';
        ReportNameCaptionLbl: Label 'List of Payments before posting';
        VendorNoCaptionLbl: Label 'Vendor No.';
        VendorNameCaptionLbl: Label 'Vendor Name';
        GLBudgetNameCaptionLbl: Label 'G/L Account for Budget Name';

        DoctypeCaptionLbl: Label 'Type';
        TotalAmt: Decimal;
        TotalAmtExcVat: Decimal;
        ReportFilters: Text;
        RecordCount: Integer;
        GLAccBudgetName: Text;

}