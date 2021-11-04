
report 50068 "Return Procurement Activities"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\ProcurementActivities.rdl';
    ApplicationArea = All;
    Caption = 'Return on Procurement Activities';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = where("Order No." = filter(<> ''));
            column(CompanyName; grecCompanyInfo.Name) { }
            column(gdateStartDate; format(gdateStartDate)) { }
            column(gdateEndDate; format(gdateEndDate)) { }
            column(Procurement_Reference_No_; "Procurement Reference No.") { }
            column(Posting_Description; "Posting Description") { }
            column(PO_Category; "PO Category") { }
            column(Updated_Estimated_Cost__Rs_; "Updated Estimated Cost (Rs)") { }
            column(Procurement_Method; "Procurement Method") { }
            column(Date_Bidding_Document_Issued; format("Date Bidding Document Issued")) { }
            column(Closing_Date_of_Bids; format("Closing Date of Bids")) { }
            column(Bidders_Invited; "Bidders Invited") { }
            column(Type_of_Procurement; "Type of Procurement") { }
            column(No_of_SMEs_Invited; "No of SMEs Invited") { }
            column(No__of_Bids_Received; "No. of Bids Received") { }
            column(No_of_Bids_Received_from_SMEs; "No of Bids Received from SMEs") { }
            column(No__of_Responsive_Bids; "No. of Responsive Bids") { }
            column(Challenge___Y_N_; "Challenge  (Y/N)") { }
            column(Date_Contract_Awarded; format("Date Contract Awarded")) { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
            column(Category_of_Successful_Bidder; "Category of Successful Bidder") { }
            column(Margin_Preference_benefitted; "Margin Preference benefitted") { }
            column(Contract_Amount_Approved__Rs_; "Contract Amount Approved (Rs)") { }
            column(gdecAbove100; gdecAbove100) { }
            column(gdecBelow100; gdecBelow100) { }
            column(gdecSMEVendor; gdecSMEVendor) { }
            column(gintSMEVendor; gintSMEVendor) { }

            trigger OnAfterGetRecord()
            begin
                if "Contract Amount Approved (Rs)" >= 100000 then
                    gdecAbove100 += "Contract Amount Approved (Rs)"
                else
                    gdecBelow100 += "Contract Amount Approved (Rs)";

                if grecVendor.get("Buy-from Vendor No.") then begin
                    if grecVendor."Vendor Type" = 'SME' then begin
                        gdecSMEVendor += "Contract Amount Approved (Rs)";
                        gintSMEVendor += 1;
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Document Date", gdateStartDate, gdateEndDate);
            end;
        }


        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = where("Document Type" = filter(Order));
            column(Procurement_Reference_No_2; "Procurement Reference No.") { }
            column(Posting_Description2; "Posting Description") { }
            column(PO_Category2; "PO Category") { }
            column(Updated_Estimated_Cost__Rs_2; "Updated Estimated Cost (Rs)") { }
            column(Procurement_Method2; "Procurement Method") { }
            column(Date_Bidding_Document_Issued2; format("Date Bidding Document Issued")) { }
            column(Closing_Date_of_Bids2; format("Closing Date of Bids")) { }
            column(Bidders_Invited2; "Bidders Invited") { }
            column(Type_of_Procurement2; "Type of Procurement") { }
            column(No_of_SMEs_Invited2; "No of SMEs Invited") { }
            column(No__of_Bids_Received2; "No. of Bids Received") { }
            column(No_of_Bids_Received_from_SMEs2; "No of Bids Received from SMEs") { }
            column(No__of_Responsive_Bids2; "No. of Responsive Bids") { }
            column(Challenge___Y_N_2; "Challenge  (Y/N)") { }
            column(Date_Contract_Awarded2; format("Date Contract Awarded")) { }
            column(Buy_from_Vendor_Name2; "Buy-from Vendor Name") { }
            column(Category_of_Successful_Bidder2; "Category of Successful Bidder") { }
            column(Margin_Preference_benefitted2; "Margin Preference benefitted") { }
            column(Contract_Amount_Approved__Rs_2; "Contract Amount Approved (Rs)") { }
            column(gdecAbove1002; gdecAbove100) { }
            column(gdecBelow1002; gdecBelow100) { }
            column(gdecSMEVendor2; gdecSMEVendor) { }
            column(gintSMEVendor2; gintSMEVendor) { }

            trigger OnAfterGetRecord()
            begin
                if "Contract Amount Approved (Rs)" >= 100000 then
                    gdecAbove100 += "Contract Amount Approved (Rs)"
                else
                    gdecBelow100 += "Contract Amount Approved (Rs)";

                if grecVendor.get("Buy-from Vendor No.") then begin
                    if grecVendor."Vendor Type" = 'SME' then begin
                        gdecSMEVendor += "Contract Amount Approved (Rs)";
                        gintSMEVendor += 1;
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Document Date", gdateStartDate, gdateEndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Date Filter")
                {
                    field("Start Date"; gdateStartDate)
                    {
                        ApplicationArea = All;
                    }
                    field("End Date"; gdateEndDate)
                    {
                        ApplicationArea = All;
                    }
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
        gdecAbove100 := 0;
        gdecBelow100 := 0;
        gdecSMEVendor := 0;
        gintSMEVendor := 0;
    end;


    var
        grecCompanyInfo: Record "Company Information";
        gdateStartDate: date;
        gdateEndDate: Date;
        gdecAbove100: Decimal;
        gdecBelow100: Decimal;
        gdecSMEVendor: Decimal;
        gintSMEVendor: Integer;
        grecVendor: Record Vendor;
}
