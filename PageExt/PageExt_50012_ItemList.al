pageextension 50012 ItemListExt extends "Item List"
{
    layout
    {
        addlast(Control1)
        {
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
            }
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
            }
            /* field("Last Purchase Price"; "Last Purchase Price")
            {
                ApplicationArea = All;
                Editable = false;
            } */
            field("Purchasing Code"; "Purchasing Code")
            {
                Visible = false;
            }
            field("Over-Receipt Code"; "Over-Receipt Code")
            {
                Visible = false;
            }
            field("Expiration Calculation"; "Expiration Calculation")
            {
                Visible = false;
            }
            field("Minimum Order Quantity"; "Minimum Order Quantity")
            {
                ApplicationArea = All;
            }
            field("Maximum Order Quantity"; "Maximum Order Quantity")
            {
                ApplicationArea = All;
            }
            field("Reorder Quantity"; "Reorder Quantity")
            {
                ApplicationArea = All;
            }
            field("Reordering Policy"; "Reordering Policy")
            {
                ApplicationArea = All;
            }
            field("Stockout Warning"; "Stockout Warning")
            {
                ApplicationArea = All;
            }
            field("Prevent Negative Inventory"; "Prevent Negative Inventory")
            {
                ApplicationArea = All;
            }
            field("Include Inventory"; "Include Inventory")
            {
                ApplicationArea = All;
            }
            field("Item Type"; "Item Type") { ApplicationArea = All; }
            field("Date Created"; "Date Created") { ApplicationArea = All; }
            field("Created By"; "Created By") { ApplicationArea = All; }
        }

        addbefore(Control1901314507)
        {
            part(ItemPicture; "Item Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "No." = FIELD("No."),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                              "Location Filter" = FIELD("Location Filter"),
                              "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                              "Variant Filter" = FIELD("Variant Filter");
            }
        }

        modify(Type)
        {
            Visible = true;
        }

        modify("Unit Cost")
        {
            Visible = gboolUnitCost;
        }
        modify("Unit Price")
        {
            Visible = gboolUnitPrice;
        }
        modify("Replenishment System")
        {
            Editable = true;
            Visible = false;
        }
        modify("Vendor No.")
        {
            Editable = true;
            Visible = true;
        }
        modify("Production BOM No.")
        {
            Editable = true;
            Visible = false;
            ApplicationArea = ALl;
        }
        modify("Routing No.")
        {
            Editable = true;
            Visible = false;
            ApplicationArea = ALl;
        }
        modify("Cost is Adjusted")
        {
            Editable = true;
            Visible = true;
            ApplicationArea = All;
        }
        modify("Substitutes Exist")
        {
            Editable = false;
            ApplicationArea = All;
            visible = false;
        }
        modify("Assembly BOM")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
            ApplicationArea = All;
        }
    }


    trigger OnOpenPage()
    var
        grecUserSetup: Record "User Setup";

    begin
        FILTERGROUP(2);
        SetRange(Module, false);
        FILTERGROUP(0);

        clear(gboolUnitCost);
        Clear(gboolUnitPrice);
        if grecUserSetup.get(UserId) then begin
            if not grecUserSetup."Hide Unit Cost on Item List" then
                gboolUnitCost := true;
            if not grecUserSetup."Hide Unit Price on Item List" then
                gboolUnitPrice := true;
        end;
    end;

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


    var
        gboolUnitCost: Boolean;
        gboolUnitPrice: Boolean;
}