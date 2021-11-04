table 50009 "Module Fee From OU Portal"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer) { }
        field(2; "Posting Date"; Date) { }
        field(3; "Learner ID"; Code[20]) { }
        field(4; "No. 1"; Code[20]) { }
        field(5; "Module Description 1"; Text[250]) { }
        field(6; "Module Amount 1"; Decimal) { }
        field(7; "Module Credit 1"; Integer) { }
        field(8; "No. 2"; Code[20]) { }
        field(9; "Module Description 2"; Text[250]) { }
        field(10; "Module Amount 2"; Decimal) { }
        field(11; "Module Credit 2"; Integer) { }
        field(12; "No. 3"; Code[20]) { }
        field(13; "Module Description 3"; Text[250]) { }
        field(14; "Module Amount 3"; Decimal) { }
        field(15; "Module Credit 3"; Integer) { }
        field(16; "No. 4"; Code[20]) { }
        field(17; "Module Description 4"; Text[250]) { }
        field(18; "Module Amount 4"; Decimal) { }
        field(19; "Module Credit 4"; Integer) { }
        field(20; "No. 5"; Code[20]) { }
        field(21; "Module Description 5"; Text[250]) { }
        field(22; "Module Amount 5"; Decimal) { }
        field(23; "Module Credit 5"; Integer) { }
        field(24; "No. 6"; Code[20]) { }
        field(25; "Module Description 6"; Text[250]) { }
        field(26; "Module Amount 6"; Decimal) { }
        field(27; "Module Credit 6"; Integer) { }
        field(28; Country; text[50]) { }
        field(29; Error; Text[100]) { Editable = false; }
        field(30; Validated; Boolean) { Editable = false; }
        field(31; "Shortcut Dimension 1 Code"; Code[20]) { }
        field(32; "Shortcut Dimension 2 Code"; Code[20]) { }
        field(33; RDAP; Text[50]) { }
        field(34; RDBL; Text[50]) { }
        field(35; NIC; Text[20]) { }
        field(36; "First Name"; Text[100]) { }
        field(37; "Login Email"; Text[250]) { }
        field(38; "Contact Email"; Text[250]) { }
        field(39; "Last Name"; Text[100]) { }
        field(40; "Maiden Name"; Text[100]) { }

        field(41; "Common Module Code 1"; Code[20]) { }
        field(42; "Common Module Code 2"; Code[20]) { }
        field(43; "Common Module Code 3"; Code[20]) { }
        field(44; "Common Module Code 4"; Code[20]) { }
        field(45; "Common Module Code 5"; Code[20]) { }
        field(46; "Common Module Code 6"; Code[20]) { }

        field(47; "Module 1 Fee Ins"; Decimal) { }
        field(48; "Module 2 Fee Ins"; Decimal) { }
        field(49; "Module 3 Fee Ins"; Decimal) { }
        field(50; "Module 4 Fee Ins"; Decimal) { }
        field(51; "Module 5 Fee Ins"; Decimal) { }
        field(52; "Module 6 Fee Ins"; Decimal) { }

        field(53; "Phone No."; Text[50]) { }
        field(54; "Mobile No."; Text[50]) { }
        field(55; Address; Text[100]) { }
        field(56; Status; Text[50]) { }
        field(57; Currency; Text[50]) { }

        field(58; "Imported By"; Text[100])
        {
            Editable = false;
        }
        field(59; "Imported On"; DateTime)
        {
            Editable = false;
        }
        field(60; "Gov Grant"; Boolean) { }
        field(61; Instalment; Boolean) { }
        field(62; "Payment Amount"; Decimal) { }
        field(63; "Portal Payment Mode"; Code[20]) { }
        field(64; "MyT Money Ref"; Text[20]) { }
        field(65; "Payment Date"; Date) { }
    }

    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }
}