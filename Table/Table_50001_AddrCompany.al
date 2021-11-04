table 50001 AddrCompany
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Currency; Text[30])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Bank Name"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Bank Address"; Text[250])
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Account No."; Text[30])
        {
            DataClassification = ToBeClassified;

        }
        field(5; IBAN; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(6; "SWIFT Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Department; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = filter('DEPARTMENT'));
        }
    }

    keys
    {
        key(PK; Currency, Department)
        {
            Clustered = true;
        }
    }
}