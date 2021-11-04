pageextension 50050 PostedPurchCrMemoListExt extends "Posted Purchase Credit Memos"
{
    layout
    {
        // Add changes to page layout here
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Posting Date")
        {
            Visible = true;
            ApplicationArea = All;
        }

        modify(Cancelled)
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(Paid)
        {
            Visible = false;
        }

        movelast(Control1; "Shortcut Dimension 1 Code")
        modify(Corrective)
        {
            Visible = false;
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
        addafter("Posting Description")
        {
            field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
            {
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

    trigger OnOpenPage();
    begin
        CurrPage.EDITABLE(FALSE);
    end;

}