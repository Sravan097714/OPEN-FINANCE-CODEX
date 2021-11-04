pageextension 50025 PurchCrMemoListExt extends "Purchase Credit Memos"
{
    layout
    {
        modify("Vendor Authorization No.")
        {
            Visible = false;
        }
        modify("Vendor Cr. Memo No.")
        {
            Visible = true;
            ApplicationArea = All;
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
        modify("Currency Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(Amount)
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        addafter("Buy-from Vendor Name")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }

        addafter("Vendor Cr. Memo No.")
        {
            field("Vendor Posting Group"; Rec."Vendor Posting Group")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
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
            field("Created By"; Rec."Created By")
            {
                ApplicationArea = All;
            }
        }
    }
}