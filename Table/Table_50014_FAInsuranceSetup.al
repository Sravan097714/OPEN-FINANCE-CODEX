table 50014 "FA Insurance Setup"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "FA Posting Group"; Code[20])
        {
            TableRelation = "FA Posting Group";
        }
        field(3; Year; DateFormula) { }
        field(4; "Insurance Amount %"; Decimal) { }
        field(5; "Insurance Type"; Text[50])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Fixed Asset'), "Field Name" = filter('Insurance Type'));
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}