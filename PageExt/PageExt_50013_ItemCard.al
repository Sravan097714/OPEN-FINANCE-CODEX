pageextension 50013 ItemCard extends "Item Card"
{
    layout
    {

        modify(Blocked)
        {
            Visible = false;
        }
        modify(Type)
        {
            Visible = true;
            Editable = false;
        }
        modify("Last Date Modified")
        {
            Visible = false;
        }
        modify(GTIN)
        {
            Visible = false;
        }
        modify("Service Item Group")
        {
            Visible = false;
        }
        modify(PreventNegInventoryDefaultNo)
        {
            Visible = false;
        }
        modify("Automatic Ext. Texts")
        {
            Visible = false;
        }
        modify("Common Item No.")
        {
            Visible = false;
        }
        modify("Shelf No.")
        {
            Visible = false;
        }
        modify("Created From Nonstock Item")
        {
            Visible = false;
        }
        modify("Search Description")
        {
            Visible = false;
        }
        modify("Qty. on Service Order")
        {
            Visible = false;
        }
        modify("Qty. on Job Order")
        {
            Visible = false;
        }
        modify("Qty. on Assembly Order")
        {
            Visible = false;
        }
        modify("Qty. on Asm. Component")
        {
            Visible = false;
        }
        modify("Qty. on Component Lines")
        {
            Visible = false;
        }
        modify("Qty. on Prod. Order")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Production BOM No.")
        {
            Visible = false;
        }
        modify("Routing No.")
        {
            Visible = false;
        }
        modify(Replenishment_Production)
        {
            Visible = false;
        }
        modify(StockoutWarningDefaultYes)
        {
            Visible = false;
        }
        modify(StockoutWarningDefaultNo)
        {
            Visible = false;
        }
        modify("Net Weight")
        {
            Visible = false;
        }
        modify("Gross Weight")
        {
            Visible = false;
        }
        modify("Unit Volume")
        {
            Visible = false;
        }
        modify("Unit Price")
        {
            Visible = false;
        }
        modify("Qty. on Sales Order")
        {
            Visible = false;
        }
        modify("Costing Method")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Standard Cost")
        {
            Visible = false;
        }
        modify("Indirect Cost %")
        {
            Visible = false;
        }
        modify("Last Direct Cost")
        {
            Visible = false;
        }
        modify("Cost is Adjusted")
        {
            Visible = true;
        }
        modify("Cost is Posted to G/L")
        {
            Visible = false;
        }
        modify(SpecialPurchPricesAndDiscountsTxt)
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify(ForeignTrade)
        {
            Visible = false;
        }
        modify(CalcUnitPriceExclVAT)
        {
            Visible = false;
        }
        modify("Price Includes VAT")
        {
            Visible = false;
        }
        modify("Price/Profit Calculation")
        {
            Visible = false;
        }
        modify("Profit %")
        {
            Visible = false;
        }
        modify(SpecialPricesAndDiscountsTxt)
        {
            Visible = false;
        }
        modify("Allow Invoice Disc.")
        {
            Visible = false;
        }
        modify("Item Disc. Group")
        {
            Visible = false;
        }
        modify("Sales Unit of Measure")
        {
            Visible = false;
        }
        modify("Sales Blocked")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Gr. (Price)")
        {
            Visible = false;
        }
        modify("Replenishment System")
        {
            Visible = false;
        }
        modify(LotForLotParameters)
        {
            Visible = false;
        }
        modify(PreventNegInventoryDefaultYes)
        {
            Visible = false;
        }
        modify(Warehouse)
        {
            Visible = false;
        }
        modify("Net Invoiced Qty.")
        {
            Visible = false;
        }
        modify("Vendor No.")
        {
            Visible = true;
        }
        modify("Lead Time Calculation")
        {
            Visible = false;
        }
        modify("Purch. Unit of Measure")
        {
            Visible = false;
        }
        modify("Purchasing Blocked")
        {
            Visible = false;
        }
        modify("Manufacturing Policy")
        {
            Visible = false;
        }
        modify("Rounding Precision")
        {
            Visible = false;
        }
        modify("Flushing Method")
        {
            Visible = false;
        }
        modify("Purchasing Code")
        {
            Visible = false;
        }
        modify("Overhead Rate")
        {
            Visible = false;
        }
        modify("Scrap %")
        {
            Visible = false;
        }
        modify("Lot Size")
        {
            Visible = false;
        }
        modify(Replenishment_Assembly)
        {
            Visible = false;
        }
        modify("Minimum Order Quantity")
        {
            Visible = true;
            Editable = true;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify("Maximum Order Quantity")
        {
            Visible = true;
            Editable = true;
        }
        modify("Reorder Quantity")
        {
            Visible = true;
            Editable = true;
        }
        modify("Reordering Policy")
        {
            Visible = true;
            Editable = false;
        }
        modify("Order Tracking Policy")
        {
            Visible = false;
        }
        modify("Stockkeeping Unit Exists")
        {
            Visible = false;
        }
        modify(Critical)
        {
            Visible = false;
        }
        modify("Safety Lead Time")
        {
            Visible = false;
        }
        modify("Safety Stock Quantity")
        {
            Visible = false;
        }
        modify("Dampener Period")
        {
            Visible = false;
        }
        modify("Dampener Quantity")
        {
            Visible = false;
        }
        modify("Time Bucket")
        {
            Visible = false;
        }
        modify(ItemTracking)
        {
            Visible = false;
        }
        modify("Overflow Level")
        {
            Visible = false;
        }
        modify("Reorder Point")
        {
            Visible = false;
        }
        modify("Order Multiple")
        {
            Visible = false;
        }
        modify("Maximum Inventory")
        {
            Visible = false;
        }
        addlast(Item)
        {

            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
            }

            field("Stockout Warning"; "Stockout Warning")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Prevent Negative Inventory"; "Prevent Negative Inventory")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Item Type"; "Item Type") { ApplicationArea = All; }
            field(Module; Module) { ApplicationArea = All; }
            field("Date Created"; "Date Created") { ApplicationArea = All; }
            field("Created By"; "Created By") { ApplicationArea = All; }
        }

        moveafter("Prevent Negative Inventory"; "Include Inventory")

        addafter("Vendor No.")
        {
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Item Category Code")
        {
            field("Product Group Code 2"; "Product Group Code 2") { ApplicationArea = All; }
        }
        modify("Item Category Code")
        {
            trigger OnAfterValidate()
            var
                grecItemCategory: Record "Item Category";
            begin
                if grecItemCategory.Get("Item Category Code") then begin
                    "Gen. Prod. Posting Group" := grecItemCategory."Gen. Prod Posting Group";
                    "VAT Prod. Posting Group" := grecItemCategory."VAT Prod Posting Group";
                    "Inventory Posting Group" := grecItemCategory."Inventory Posting Group";
                end else begin
                    "Gen. Prod. Posting Group" := '';
                    "VAT Prod. Posting Group" := '';
                    "Inventory Posting Group" := '';
                end;
            end;
        }
        modify(Reserve)
        {
            Editable = false;
        }
    }

    trigger OnAfterGetRecord()
    var
        grecValueEntry: Record "Value Entry";
        gintItemLedgerEntryNo: Integer;
        gdecUnitCost: Decimal;
        gdecTotalCostPerUnit: Decimal;
    begin
        Clear(gintItemLedgerEntryNo);
        Clear(gdecUnitCost);
        Clear(gdecTotalCostPerUnit);
        grecValueEntry.Reset();
        grecValueEntry.SetCurrentKey("Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code");
        grecValueEntry.SetRange("Document Type", grecValueEntry."Document Type"::"Purchase Receipt");
        grecValueEntry.SetRange("Item Charge No.", '');
        grecValueEntry.SetRange("Item No.", "No.");
        if grecValueEntry.FindLast then begin
            gintItemLedgerEntryNo := grecValueEntry."Item Ledger Entry No.";
            gdecUnitCost := grecValueEntry."Cost per Unit";
        end;

        clear(gdecTotalCostPerUnit);
        grecValueEntry.SetFilter("Item Charge No.", '<>%1', '');
        grecValueEntry.SetRange("Item Ledger Entry No.", gintItemLedgerEntryNo);
        if grecValueEntry.FindSet() then begin
            repeat
                gdecTotalCostPerUnit += grecValueEntry."Cost per Unit";
            until grecValueEntry.Next() = 0;
        end;

        grecValueEntry.SetRange("Item Charge No.", '');
        if grecValueEntry.FindSet() then begin
            repeat
                gdecTotalCostPerUnit += grecValueEntry."Cost per Unit";
            until grecValueEntry.Next() = 0;
        end else
            gdecTotalCostPerUnit += gdecUnitCost;
        "Last Purchase Price" := gdecTotalCostPerUnit;
    end;


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Reordering Policy" := "Reordering Policy"::"Fixed Reorder Qty.";
    end;
}