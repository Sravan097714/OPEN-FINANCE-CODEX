pageextension 50061 PostedSalesCrMemoSubformExt extends "Posted Sales Cr. Memo Subform"
{
    layout
    {
        // Add changes to page layout here
        modify(FilteredTypeField)
        {
            Visible = false;
        }
        modify("Cross-Reference No.")
        {
            Visible = false;
        }
        modify("Return Reason Code")
        {
            Visible = false;
        }
        modify("Unit Cost (LCY)")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Line Discount Amount")
        {
            Visible = true;
            ApplicationArea = All;
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
        modify("Deferral Code")
        {
            Visible = false;
        }

        modify("Unit of Measure Code")
        {
            Visible = false;
        }

        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }

        addafter(Quantity)
        {
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
            }
            field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = all;
            }
        }

        addlast(Control1)
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
            }
        }

        addfirst(Control1)
        {
            field("Line No."; "Line No.") { Editable = false; }
        }
    }

}