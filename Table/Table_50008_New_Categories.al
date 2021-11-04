table 50008 "New Categories"
{
    LookupPageId = 50017;

    fields
    {
        field(1; "Table Name"; text[30]) { }
        field(2; "Field Name"; Text[100]) { }
        field(3; Code; Code[50]) { }
        field(4; Description; Text[150]) { }
        field(5; "TDS %"; Decimal) { }
        field(6; "TDS Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(7; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
                if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
                    if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group") then
                        Validate("VAT Bus. Posting Group", GenBusPostingGrp."Def. VAT Bus. Posting Group");
            end;
        }
        field(8; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(9; "Vendor Posting Group"; Code[20])
        {
            Caption = 'Vendor Posting Group';
            TableRelation = "Vendor Posting Group";
        }
        field(10; "Customer Posting Group"; Code[20])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
        }

    }

    keys
    {
        key(PK; "Table Name", "Field Name", Code)
        {
            Clustered = true;
        }
    }
    var
        GenBusPostingGrp: Record "Gen. Business Posting Group";
}