pageextension 50041 S41alesCrMemoListExt extends "Sales Credit Memos"
{
    layout
    {
        modify("External Document No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Sell-to Post Code")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Sell-to Contact")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Posting Date")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Due Date")
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
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Posting Description")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Currency Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Sell-to Country/Region Code")
        {
            Visible = false;
        }
        addafter("Posting Date")
        {
            field("Order Date"; Rec."Order Date")
            {
                Editable = false;
                ApplicationArea = All;
            }

        }
        movelast(Control1; Amount)
        addlast(Control1)
        {
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Customer Posting Group"; "Customer Posting Group") { ApplicationArea = All; }

            field("Created By"; Rec."Created By")
            {
                ApplicationArea = All;
            }
        }

    }
}