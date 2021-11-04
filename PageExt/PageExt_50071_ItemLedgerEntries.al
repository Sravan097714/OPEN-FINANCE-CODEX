pageextension 50071 ItemLedgerEntries extends "Item Ledger Entries"
{
    layout
    {
        modify("Cost Amount (Non-Invtbl.)")
        {
            Visible = false;
        }
        modify("Global Dimension 1 Code")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Global Dimension 2 Code")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Location Code") { Visible = false; }

        addlast(Control1)
        {
            field("Requested By"; "Requested By")
            {
                ApplicationArea = ALl;
            }
            field(Module; Module) { ApplicationArea = All; }
            field("Vendor No."; "Vendor No.") { ApplicationArea = All; }
        }
    }
}