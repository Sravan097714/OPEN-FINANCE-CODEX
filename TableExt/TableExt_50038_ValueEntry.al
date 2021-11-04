tableextension 50038 ValueEntryExt extends "Value Entry"
{
    fields
    {
        field(50000; "Requested By"; Code[50]) { }
        field(50001; "Created By"; Text[50]) { }
        field(50002; Module; Boolean) { }
        field(50003; "Original PO Number"; Code[20])
        {
            Caption = 'Original Purchase Order Number';
        }
        field(50004; "Vendor No."; Code[20]) { }
        field(50005; "Creation Date"; DateTime) { Editable = false; }
    }

    trigger OnInsert()
    var
        grecItem: Record Item;
    begin
        if grecItem.get("Item No.") then begin
            Module := grecItem.Module;
        end;

        "Creation Date" := CurrentDateTime;

    end;
}