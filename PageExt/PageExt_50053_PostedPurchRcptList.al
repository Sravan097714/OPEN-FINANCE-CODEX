pageextension 50053 PostedPurchRcptListExt extends "Posted Purchase Receipts"
{
    layout
    {
        modify("No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Posting Date")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("No. Printed")
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
            ApplicationArea = All;
        }
        modify("Location Code")
        {
            Visible = false;
        }

        addlast(Control1)
        {
            field("User ID"; Rec."User ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Order No."; Rec."Order No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Created By"; Rec."Created By")
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