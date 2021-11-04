pageextension 50037 SalesOrderSubformExt extends "Sales Order Subform"
{
    layout
    {
        modify(Type)
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Line No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(FilteredTypeField)
        {
            Visible = false;
        }
        modify("Reserved Quantity")
        {
            Visible = false;
            Editable = true;
            ApplicationArea = All;
        }
        modify("Line Discount Amount")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(SalesLineDiscExists)
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Drop Shipment")
        {
            Visible = false;
        }
        modify("Purchasing Code")
        {
            Visible = false;
        }
        modify("Planned Delivery Date")
        {
            Visible = false;
        }
        modify("Planned Shipment Date")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
            ApplicationArea = All;

        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Qty. to Assemble to Order")
        {
            Visible = false;
        }

        addafter(Quantity)
        {
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
            }
        }

        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            field("Common Module Code"; "Common Module Code")
            {
                ApplicationArea = All;
            }
        }

        movefirst(Control1; "Line No.")
        moveafter("Gen. Prod. Posting Group"; "VAT Prod. Posting Group")
        moveafter("Line Discount %"; "Line Discount Amount")
    }
}