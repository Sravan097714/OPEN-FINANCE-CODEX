pageextension 50049 PostedPurchInvSubformExt extends "Posted Purch. Invoice Subform"
{
    layout
    {
        modify(FilteredTypeField)
        {
            Visible = false;
        }
        modify("Tax Group Code")
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
            Visible = false;
        }
        modify("Job No.")
        {
            Visible = false;
        }
        modify("Line Discount Amount")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Total Amount Excl. VAT")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Total Amount Incl. VAT")
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
                Editable = false;
                ApplicationArea = All;
            }
        }

        addafter(Quantity)
        {
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
                Editable = false;
                ApplicationArea = All;

            }
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }

        addfirst(Control1)
        {
            field("Line No."; "Line No.") { Editable = false; }
        }

        addlast(Control1)
        {

            field("TDS Code"; "TDS Code")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field(VAT; VAT)
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("Retention Fee"; "Retention Fee")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("G/L Account for Budget"; "G/L Account for Budget")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Earmark ID"; "Earmark ID") { ApplicationArea = All; }
            field("Date Earmarked"; "Date Earmarked") { ApplicationArea = All; }
            field("TDS %"; "TDS %")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field(PAYE; PAYE)
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("VAT Amount Input"; "VAT Amount Input")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Line Amount Excluding VAT"; "Line Amount Excluding VAT")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}