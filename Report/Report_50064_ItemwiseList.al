report 50064 "Itemwise List"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\ItemwiseList.rdl';

    dataset
    {
        dataitem("Value Entry"; "Value Entry")
        {
            //DataItemTableView = sorting("Entry No.");
            DataItemTableView = sorting("Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code") where("Item Ledger Entry Quantity" = filter(<> 0));
            RequestFilterFields = "Item No.";

            column(CompanyName; grecCompanyInfo.Name) { }
            column(CompanyAddress; grecCompanyInfo.Address) { }
            column(gdateStartDate; gdateStartDate) { }
            column(gdateEndDate; gdateEndDate) { }
            column(Posting_Date; format("Posting Date")) { }
            column(Item_Ledger_Entry_Type; "Item Ledger Entry Type") { }
            column(Document_No_; "Document No.") { }
            column(Requested_By; "Requested By") { }
            column(Item_Ledger_Entry_Quantity; "Item Ledger Entry Quantity") { }
            column(gdecAmount; gdecAmount) { }

            column(Item_No_; "Item No.") { }
            column(Description; grecitem.Description) { }

            column(gdecBalanceBF1; gdecBalanceBF[1]) { }
            column(gdecBalanceBF2; gdecBalanceBF[2]) { }
            column(gdecBalanceBFTotal1; gdecBalanceBFTotal[1]) { }
            column(gdecBalanceBFTotal2; gdecBalanceBFTotal[2]) { }
            column(gdecAmountAsIs; gdecAmountAsIs) { }


            trigger OnAfterGetRecord()
            begin
                if grecItem.Get("Item No.") then begin
                    if grecItem.Module then
                        CurrReport.Skip();
                end;

                Clear(gdecAmount);
                if "Cost Amount (Actual)" <> 0 then
                    gdecAmount := "Cost Amount (Actual)"
                else
                    gdecAmount := "Cost Amount (Expected)";

                gdecAmountAsIs := gdecAmount;

                if gdecAmount < 0 then
                    gdecAmount := gdecAmount * -1;

                if gtextItemNo <> "Item No." then begin
                    clear(gdecBalanceBF);
                    clear(gdecBalanceBFTotal);
                    grecValueEntry.Reset();
                    grecValueEntry.SetCurrentKey("Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code");
                    grecValueEntry.SetRange("Item No.", "Item No.");
                    grecValueEntry.SetRange("Posting Date", 0D, gdateStartDate - 1);
                    grecValueEntry.SetFilter("Item Ledger Entry Quantity", '<>%1', 0);
                    grecValueEntry.CalcSums("Cost Amount (Expected)", "Cost Amount (Actual)", "Item Ledger Entry Quantity");
                    gdecBalanceBF[1] := grecValueEntry."Item Ledger Entry Quantity";
                    gdecBalanceBF[2] := grecValueEntry."Cost Amount (Actual)" + grecValueEntry."Cost Amount (Expected)";
                    gdecBalanceBFTotal[1] := gdecBalanceBF[1] + "Item Ledger Entry Quantity";
                    gdecBalanceBFTotal[2] := gdecBalanceBF[2] + ("Cost Amount (Actual)" + "Cost Amount (Expected)");
                end else begin
                    gdecBalanceBFTotal[1] += "Item Ledger Entry Quantity";
                    gdecBalanceBFTotal[2] += ("Cost Amount (Actual)" + "Cost Amount (Expected)");
                end;
                gtextItemNo := "Item No.";
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", gdateStartDate, gdateEndDate);
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
    end;

    var
        grecCompanyInfo: Record "Company Information";
        gdateStartDate: Date;
        gdateEndDate: Date;
        gdecAmount: Decimal;
        gdecAmountAsIs: Decimal;
        gdecBalanceBF: array[2] of Decimal;
        grecValueEntry: Record "Value Entry";
        gtextItemNo: Text;
        grecItem: Record Item;
        gdecBalanceBFTotal: array[2] of Decimal;
}