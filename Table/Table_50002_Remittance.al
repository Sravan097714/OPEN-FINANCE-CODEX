table 50002 "Remittance"
{

    fields
    {
        field(1; EntryNo; Integer)
        {
        }
        field(2; "Vendor Details1"; Text[100])
        {
        }
        field(3; "Vendor Details2"; Text[100])
        {
        }
        field(4; "Vendor Details3"; Text[100])
        {
        }
        field(5; "Vendor Details4"; Text[100])
        {
        }
        field(6; "Vendor Details5"; Text[100])
        {
        }
        field(7; "Vendor Details6"; Text[100])
        {
        }
        field(8; "Vendor Details7"; Text[100])
        {
        }
        field(9; "Your Reference"; Code[20])
        {
        }
        field(10; "Rem Date"; Date)
        {
        }
        field(11; Details; Text[50])
        {
        }
        field(12; Amount; Decimal)
        {
        }
        field(13; ChequeNoText; Text[30])
        {
        }
        field(14; ChequeDateText; Text[30])
        {
        }
        field(15; ChequeAmountText; Text[80])
        {
        }
        field(16; NAVUserID; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; EntryNo)
        {
        }
    }

    fieldgroups
    {
    }
}

