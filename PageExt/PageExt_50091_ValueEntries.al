pageextension 50091 ValueEntriesExt extends "Value Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("Requested By"; "Requested By")
            {
                ApplicationArea = All;
            }
            field("Created By"; "Created By")
            {
                ApplicationArea = All;
            }
            field(Module; Module) { ApplicationArea = All; }
            field("Original PO Number"; "Original PO Number") { ApplicationArea = All; }
            field("Vendor No."; "Vendor No.") { ApplicationArea = All; }
            field("Creation Date"; "Creation Date") { ApplicationArea = All; }
        }
        modify("Cost Amount (Non-Invtbl.)")
        {
            Visible = false;
        }
        modify("Cost Posted to G/L")
        {
            Visible = false;
        }
        modify("Valued Quantity")
        {
            Visible = false;
        }
        modify("Cost per Unit (ACY)")
        {
            Visible = false;
        }
        modify("Valued By Average Cost")
        {
            Visible = false;
        }
        modify("Capacity Ledger Entry No.")
        {
            Visible = false;
        }
    }
}