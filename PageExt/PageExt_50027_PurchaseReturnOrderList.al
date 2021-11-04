pageextension 50027 PurchReturnOrderListExt extends "Purchase Return Order List"
{
    layout
    {
        modify("Vendor Authorization No.")
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
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(Status)
        {
            Visible = false;
        }
        addlast(Control1)
        {
            field(BRN; Rec.BRN)
            {
                ApplicationArea = All;
            }
            field("Created By"; Rec."Created By")
            {
                ApplicationArea = All;
            }
        }
    }
}