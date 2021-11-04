table 50013 "Item Product Group"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item Category Code"; Code[20])
        {
            TableRelation = "Item Category".Code;
        }
        field(2; "Product Group Code"; Code[20]) { }
        field(3; Description; Text[250]) { }
    }

    keys
    {
        key(PK; "Item Category Code", "Product Group Code")
        {
            Clustered = true;
        }
    }
}