table 50011 "ReRegistration Fee OU Portal"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer) { }

        field(2; PTN; Text[50]) { }
        field(3; RDAP; Text[50]) { }
        field(4; "Student ID"; Code[20]) { }
        field(5; "First Name"; Text[100]) { }
        field(6; "Last Name"; Text[100]) { }
        field(7; "Maiden Name"; Text[100]) { }

        field(8; "Shortcut Dimension 1 Code"; Code[20]) { }
        field(9; "Payment Semester"; Code[20]) { }
        field(10; "Shortcut Dimension 2 Code"; Code[20]) { }

        field(11; "Module Description"; Text[250]) { }
        field(12; "No."; Code[20]) { }
        field(13; "Common Module Code"; Code[20]) { }
        field(14; "Module Credit"; Integer) { }
        field(15; "Module Amount"; Decimal) { }
        field(16; "Module Fee Ins"; Decimal) { }

        field(17; Currency; Text[50]) { }
        field(18; Total; Decimal) { }
        field(19; "Penalty Fee"; Decimal) { }
        field(20; "Net Total"; Decimal) { }
        field(21; "Payment For"; Text[50]) { }
        field(22; "Payment Type"; Text[50]) { }
        field(23; "Date Paid On"; Date) { }
        field(24; "Date Processed"; Date) { }

        field(25; "MyT Money Ref"; Text[100]) { }
        field(26; "MyT Money Ref Staff"; Text[100]) { }
        field(27; Remarks; Text[100]) { }

        field(28; Error; Text[100]) { Editable = false; }
        field(29; Validated; Boolean) { Editable = false; }
        field(30; Status; Text[50]) { }

        field(58; "Imported By"; Text[100]) { Editable = false; }
        field(59; "Imported On"; DateTime) { Editable = false; }

        field(60; "Gov Grant"; Boolean) { }
        field(61; Instalment; Boolean) { }
    }

    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }
}