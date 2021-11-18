tableextension 50008 SalesShipHeader extends "Sales Shipment Header"
{
    fields
    {
        field(50000; "BRN"; code[30])
        {
            Editable = false;
        }
        field(50001; "Delivery Date"; Date) { }
        field(50002; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(50003; "From OU Portal"; Boolean)
        {
            Editable = false;
        }
        field(50026; "Amount Tendered"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Amount Returned"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50028; "Contact Title"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Bank Code"; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
    }
}