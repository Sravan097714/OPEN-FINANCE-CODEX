table 50064 "Fixed Asset Inventories"
{

    fields
    {
        field(1; "Fixed Asset No."; Code[20]) { }
        field(2; Description; Text[100]) { }
        field(3; "FA Class Code"; Text[10]) { }
        field(4; "FA Location Code"; Text[10]) { }
        field(5; "Serial No."; Text[50]) { }
        field(6; Make; Text[50]) { }
        field(7; Model; Text[50]) { }
        field(8; "Insurance Type"; Text[50]) { }
        field(9; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(10; "Scanned By"; Code[50]) { Editable = false; }
        field(11; "Scanned On"; DateTime) { Editable = false; }
        field(12; "Scan Here"; Text[50]) { }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
}