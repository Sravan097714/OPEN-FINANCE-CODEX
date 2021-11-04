table 50006 Receipt_Payment_Setup
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Row No."; Code[20]) { }
        field(2; "G/L Account No. Filter"; Text[250]) { }
        field(3; "Dimension Value Type"; Text[50]) { }
        field(4; "Row Name"; Text[100]) { }
        field(5; Row; Integer) { }
    }

    keys
    {
        key(PK; "Row No.")
        {
            Clustered = true;
        }
        key(SK; Row) { }
    }
}