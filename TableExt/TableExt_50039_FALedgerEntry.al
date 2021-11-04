tableextension 50039 FALedgerEntryExt extends "FA Ledger Entry"
{
    fields
    {
        field(50000; "Created By"; Text[50]) { }
        field(50001; "FA Revaluation"; Boolean) { }
        field(50002; "Description 2"; Text[250]) { }
    }

    trigger OnInsert()
    var
        grecDeprBook: Record "Depreciation Book";
    begin
        if grecDeprBook.Get("Depreciation Book Code") then
            "FA Revaluation" := grecDeprBook."FA Revaluation";
    end;
}