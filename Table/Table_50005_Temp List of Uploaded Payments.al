table 50005 "List of Uploaded Payments"
{
    Caption = 'Temp List of Uploaded Payments';

    fields
    {
        field(1; "Entry No."; Integer) { }
        field(2; "Posting Date"; Date) { }
        field(3; "Student Code"; Text[50]) { }
        field(4; Amount; Decimal) { }
        field(5; "Posted Invoice No."; Code[20]) { }
        field(6; Error; Boolean)
        {
            Editable = false;
        }
        field(7; "Error Message"; Text[250])
        {
            Editable = false;
        }
        field(8; Validated; Boolean)
        {
            Editable = false;
        }
        field(9; "Imported by"; Text[50])
        {
            Editable = false;
        }
        field(10; "Imported On"; Date)
        {
            Editable = false;
        }
        field(11; "First Name"; Text[100])
        {
            Editable = false;
        }
        field(12; "Last Name"; Text[100])
        {
            Editable = false;
        }
        field(13; Name; Text[100])
        {
            Editable = false;
        }
        field(14; "Updated to NAV"; Boolean)
        {
            Editable = false;
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