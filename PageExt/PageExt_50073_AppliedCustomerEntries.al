pageextension 50073 AppliedCustomerEntries extends "Applied Customer Entries"
{
    layout
    {
        modify("Global Dimension 1 Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Global Dimension 2 Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Closed by Amount")
        {
            Visible = false;
        }
        modify("User ID")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Entry No.")
        {
            Visible = false;
        }
        modify("Source Code")
        {
            Visible = false;
        }
        modify(Amount)
        {
            Visible = false;
        }
        addlast(Control1)
        {
            field("Due Date"; Rec."Due Date")
            {
                ApplicationArea = All;
            }
            field("Original Amt. (LCY)"; Rec."Original Amt. (LCY)")
            {
                ApplicationArea = All;
            }
            field("Remaining Amount"; Rec."Remaining Amount")
            {
                ApplicationArea = All;
            }
            field("Remaining Amt. (LCY)"; Rec."Remaining Amt. (LCY)")
            {
                ApplicationArea = All;
            }
            field("Customer Posting Group"; Rec."Customer Posting Group")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Amount to Apply"; "Amount to Apply")
            {
                ApplicationArea = All;
                Editable = true;
                Visible = true;
            }
        }

        movebefore("Document No."; "Global Dimension 1 Code")
    }
}