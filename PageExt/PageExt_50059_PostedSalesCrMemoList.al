pageextension 50059 PostedSalesCrMemoListExt extends "Posted Sales Credit Memos"
{
    layout
    {
        modify("Due Date")
        {
            Visible = true;
            ApplicationArea = All;
        }

        modify("Document Date")
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
            Visible = true;
            ApplicationArea = All;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Remaining Amount")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(Paid)
        {
            Visible = false;
        }
        modify(Corrective)
        {
            Visible = false;
        }
        modify(Cancelled)
        {
            Visible = false;
        }
        modify("No. Printed")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Customer Name")
        {
            field("Posting Description"; Rec."Posting Description")
            {
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
            field("Customer Posting Group"; Rec."Customer Posting Group")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Delivery Date"; Rec."Delivery Date")
            {
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