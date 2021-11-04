pageextension 50100 DetVendLedgEntryExt extends "Detailed Vendor Ledg. Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("Initial Document Type"; "Initial Document Type") { ApplicationArea = All; }
            field("Applied Cust. Ledger Entry No."; "Applied Vend. Ledger Entry No.") { ApplicationArea = All; }
        }

        modify(Unapplied)
        {
            Visible = true;
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
        modify("Vendor Ledger Entry No.")
        {
            Visible = true;
        }
    }
}