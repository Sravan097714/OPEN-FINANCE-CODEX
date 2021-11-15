table 50022 "Full Prog. Fee From OU Protal"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer) { }
        field(2; "User ID"; Code[50]) { }
        field(3; RDAP; Text[50]) { }
        field(4; RDBL; Text[50]) { }
        field(5; NIC; Text[20]) { }
        field(6; "Learner ID"; Code[20]) { }
        field(7; "First Name"; Text[100]) { }
        field(8; "Last Name"; Text[100]) { }
        field(9; "Maiden Name"; Text[100]) { }
        field(10; Intake; Text[20]) { }
        field(11; "Intake Formatted"; Text[20]) { }
        field(12; "Login Email"; Text[100]) { }
        field(13; "Contact Email"; Text[100]) { }
        field(14; "Prog. Name"; Text[100]) { }
        field(15; "Prog. Code"; code[20]) { }
        field(16; "Phone No."; Text[50]) { }
        field(17; "Mobile No."; Text[50]) { }
        field(18; Address; Text[100]) { }
        field(19; Country; text[50]) { }
        field(20; Status; Text[50]) { }
        field(21; Currency; Text[50]) { }
        field(22; FullFees; Decimal) { }
        field(23; Discount; Decimal) { }
        field(24; "Discount Amount"; Decimal) { }
        field(25; "Payment Amount"; Decimal) { }
        field(26; "Payment Mode"; Code[20]) { }
        field(27; "MyT Money Ref"; Text[20]) { }
        field(28; "Payment Date"; Date) { }
        field(29; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Imported By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Imported DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }
}