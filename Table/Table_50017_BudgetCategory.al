table 50017 "Budget Category"
{
    fields
    {
        field(1; "Budget Category Code"; Code[20]) { }
        field(2; Description; Text[250]) { }
    }

    keys
    {
        key(Key1; "Budget Category Code")
        {
            Clustered = true;
        }
    }
}