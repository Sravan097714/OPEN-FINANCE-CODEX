tableextension 50055 FADeprBookExt extends "FA Depreciation Book"
{
    fields
    {
        field(50000; "FA Revaluation"; Boolean) { }
        field(50001; "Monthly Depreciation"; Decimal)
        {
            Editable = false;
        }

        modify("Depreciation Book Code")
        {
            trigger OnAfterValidate()
            var
                grecDeprBook: Record "Depreciation Book";
            begin
                if grecDeprBook.Get("Depreciation Book Code") then begin
                    "FA Revaluation" := grecDeprBook."FA Revaluation";
                    //Modify;
                end;
            end;
        }
    }
}