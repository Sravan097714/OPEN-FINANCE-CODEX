pageextension 50099 DetCustLedgEntryExt extends "Detailed Cust. Ledg. Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("Initial Document Type"; "Initial Document Type") { ApplicationArea = All; }
            field("Applied Cust. Ledger Entry No."; "Applied Cust. Ledger Entry No.") { ApplicationArea = All; }
        }

        modify(Unapplied)
        {
            Visible = true;
        }
        modify("Cust. Ledger Entry No.")
        {
            Visible = true;
            Editable = false;
        }
        modify("Unapplied by Entry No.")
        {
            Visible = true;
        }
        modify("Initial Entry Global Dim. 1")
        {
            Visible = true;
        }
        modify("Initial Entry Global Dim. 2")
        {
            Visible = true;
        }
        modify("Source Code")
        {
            Visible = true;
        }
    }
}