table 50019 "OU Portal App Submission"
{
    DataClassification = ToBeClassified;
    Caption = 'OU Portal Application Submission';
    LookupPageId = 50056;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; User_ID; Text[10]) { }
        field(3; Submission; Integer) { }
        field(4; RDAP; Text[25]) { }
        field(5; RDBL; Text[25]) { }
        field(6; NIC; Text[20]) { }
        field(7; "First Name"; Text[100]) { }
        field(8; "Last Name"; Text[100]) { }
        field(9; "Maiden Name"; Text[50]) { }
        field(10; Intake; Text[20]) { }
        field(11; "Intake Formatted"; Text[20]) { }
        field(12; "Login Email"; Text[100]) { }
        field(13; "Contact Email"; Text[100]) { }
        field(14; "Phone"; Text[20]) { }
        field(15; "Mobile"; Text[20]) { }
        field(16; Address; Text[100]) { }
        field(17; Country; Text[50]) { }
        field(18; Status; Text[20]) { }
        field(19; "Programme 1"; Text[250]) { }
        field(20; "Programme 2"; Text[250]) { }
        field(21; "Programme 3"; Text[250]) { }
        field(22; "Programme 4"; Text[250]) { }
        field(23; "Imported By"; Text[50]) { }
        field(24; "Imported On"; DateTime) { }
    }


    keys
    {
        key(Key1; "Entry No.", User_ID, NIC, "First Name", "Last Name", Intake, "Login Email")
        {
            Clustered = true;
        }
    }
}