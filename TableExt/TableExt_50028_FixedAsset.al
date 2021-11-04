tableextension 50028 FixedAssetExt extends "Fixed Asset"
{
    fields
    {
        field(50000; Revalued; Boolean) { }
        field(50001; "Additional Description"; Text[250]) { }
        field(50002; Warranty; DateFormula) { }
        field(50003; "Warranty Description"; Text[150]) { }
        field(50004; Make; Text[50]) { }
        field(50005; "Acquisition Date"; Date) { }
        field(50006; "Date Created"; DateTime) { Editable = false; }
        field(50007; "Created By"; Text[50]) { Editable = false; }
        field(50008; Model; Text[50]) { }
        field(50009; "Insurance Type"; Text[50])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Fixed Asset'), "Field Name" = filter('Insurance Type'));
        }
        field(50010; "Details of Donation"; Text[250]) { }
        field(50011; "Insurance Details"; Text[250]) { }
    }

    trigger OnInsert()
    begin
        "Date Created" := CurrentDateTime;
        "Created By" := UserId;
    end;
}