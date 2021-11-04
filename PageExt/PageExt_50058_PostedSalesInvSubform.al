pageextension 50058 PostedSalesInvSubform extends "Posted Sales Invoice Subform"
{
    layout
    {
        modify(FilteredTypeField)
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
        modify("Line Discount Amount")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Deferral Code")
        {
            Visible = false;
        }
        modify("Unit of Measure Code")
        {
            Visible = false;
        }

        addfirst(Control1)
        {
            field("Line No."; "Line No.") { Editable = false; }
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
            field("VAT %"; Rec."VAT %")
            {
                ApplicationArea = All;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
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

        addlast(Control1)
        {
            field(Instalment; Instalment) { ApplicationArea = All; }
            field("Original Amount"; "Original Amount") { ApplicationArea = All; }
        }
    }
}