pageextension 50047 PostedPurchInvListExt extends "Posted Purchase Invoices"
{
    layout
    {
        modify("Posting Date")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify(Closed)
        {
            Visible = false;
        }
        modify(Corrective)
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Order No.")
        {
            Visible = true;
            Enabled = false;
            ApplicationArea = All;
        }
        modify("Order Address Code")
        {
            Visible = false;
        }
        modify(Cancelled)
        {
            Visible = false;
        }

        moveafter("Buy-from Vendor Name"; "Order Address Code")

        addafter("Buy-from Vendor Name")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                Visible = true;
                Editable = false;
                ApplicationArea = All;
            }
        }
        addlast(Control1)
        {
            field("Pre-Assigned No."; Rec."Pre-Assigned No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("User ID"; Rec."User ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Vendor Posting Group"; Rec."Vendor Posting Group")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Created By"; Rec."Created By")
            {
                ApplicationArea = All;
            }
            field("Released By"; Rec."Released By")
            {
                ApplicationArea = All;
            }
            field("Date Time Released"; Rec."Date Time Released")
            {
                ApplicationArea = All;
            }
            field("Reopened By"; Rec."Reopened By")
            {
                ApplicationArea = All;
            }
            field("Date Time Reopened"; Rec."Date Time Reopened")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage();
    begin
        CurrPage.EDITABLE(FALSE);
    end;
}