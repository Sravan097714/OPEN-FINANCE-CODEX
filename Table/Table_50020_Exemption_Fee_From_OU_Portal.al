table 50020 "Exemption/Resit Fee OU Portal"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer) { }
        field(2; "User ID"; Code[20]) { }
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
        field(15; "Date Processed"; date) { }
        field(16; "Payment Mode"; Text[50]) { }
        field(17; "Remarks"; Text[250]) { }

        field(18; Error; Text[100]) { Editable = false; }
        field(19; Validated; Boolean) { Editable = false; }

        field(20; "Imported By"; Text[100]) { Editable = false; }
        field(21; "Imported On"; DateTime) { Editable = false; }
        field(22; Exemption; Boolean) { }
        field(23; Resit; Boolean) { }
        field(24; "Date Time Processed"; DateTime) { }
    }

    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }
}