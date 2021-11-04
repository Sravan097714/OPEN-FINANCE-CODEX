tableextension 50037 ItemLedgerEntryExt extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Requested By"; Code[50]) { }
        field(50001; "Created By"; Text[50]) { }
        field(50002; Module; Boolean) { }
        field(50003; "Vendor No."; Code[20]) { }
    }

    trigger OnInsert()
    var
        grecItem: Record Item;
    begin
        if grecItem.get("Item No.") then begin
            Module := grecItem.Module;
        end;
    end;

}