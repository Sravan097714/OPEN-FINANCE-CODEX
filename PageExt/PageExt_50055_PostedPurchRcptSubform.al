pageextension 50055 PostedPurchRcptSubformExt extends "Posted Purchase Rcpt. Subform"
{
    layout
    {

        modify("Expected Receipt Date")
        {
            Visible = false;
        }
        modify("Planned Receipt Date")
        {
            Visible = false;
        }
        modify("Qty. Rcd. Not Invoiced")
        {
            Visible = false;
        }
        modify("Order Date")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }

        addfirst(Control1)
        {
            field("Line No."; "Line No.") { Editable = false; }
        }

        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = all;
            }
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