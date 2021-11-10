tableextension 50003 SalesHeaderExt extends "Sales Header"
{
    fields
    {
        field(50000; "BRN"; Code[30])
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
        field(50004; "First Name"; Text[100])
        {
            Editable = false;
        }
        field(50005; "Last Name"; Text[100])
        {
            Editable = false;
        }
        field(50006; "Maiden Name"; Text[100])
        {
            Editable = false;
        }
        field(50007; RDAP; Text[50])
        {
            Editable = false;
        }
        field(50008; RDBL; Text[50])
        {
            Editable = false;
        }
        field(50009; PTN; Text[25]) { Editable = false; }
        field(50010; "Payment Semester"; Text[25]) { Editable = false; }
        field(50011; NIC; Text[20]) { Editable = false; }
        field(50012; "Login Email"; Text[50]) { Editable = false; }
        field(50013; "Contact Email"; Text[50]) { Editable = false; }
        field(50014; "Our Ref"; Text[50]) { }
        field(50015; "Your Ref"; Text[100]) { }
        field(50016; "Invoice Discount %"; Decimal)
        {
            trigger OnValidate()
            begin

            end;
        }
        field(50017; "Load G/L Entry"; Boolean) { }
        field(50018; "Gov Grant"; Boolean) { }
        field(50019; Instalment; Boolean) { }
        field(50020; "Payment Amount"; Decimal) { }
        field(50021; "Portal Payment Mode"; Code[20]) { }
        field(50022; "MyT Money Ref"; Text[20]) { }
        field(50023; "Payment Date"; Date) { }
        field(50024; "MyT Merchant Trade No."; Text[20]) { }
        field(50025; Remark; Text[250]) { }
        field(50026; "Amount Tendered"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CalcFields(Amount);
                if "Amount Tendered" < Amount then
                    Error('Amount Tendered cannot be less than total amount');
                "Amount Returned" := "Amount Tendered" - Amount;
            end;
        }
        field(50027; "Amount Returned"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId();
    end;
}