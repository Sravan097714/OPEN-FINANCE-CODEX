
pageextension 50072 AppliedVendorEntries extends "Applied Vendor Entries"
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
        modify("Closed by Currency Amount")
        {
            Visible = false;
        }
        modify("Closed by Currency Code")
        {
            Visible = false;
        }
        modify("Source Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("User ID")
        {
            Visible = true;
            ApplicationArea = All;
        }

        movebefore("External Document No."; "Global Dimension 1 Code")

        addlast(Control1)
        {
            field("Vendor Posting Group"; Rec."Vendor Posting Group")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Amount to Apply"; "Amount to Apply")
            {
                ApplicationArea = All;
            }
        }
    }
}