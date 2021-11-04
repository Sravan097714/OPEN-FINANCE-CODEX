table 50000 "TDS Setup"
{


    fields
    {
        field(1; "TDS Code"; Code[20]) { }
        field(2; "TDS Percentage"; Decimal) { }
        field(3; "TDS Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(PK; "TDS Code")
        {
            Clustered = true;
        }
    }
}