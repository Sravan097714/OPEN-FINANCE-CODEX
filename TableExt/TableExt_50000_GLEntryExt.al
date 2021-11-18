tableextension 50000 GLEntryExt extends "G/L Entry"
{
    fields
    {
        field(50000; "Creation Date"; Date) { }
        field(50001; "PV Number"; Code[20]) { }
        field(50002; "Payment Type"; Code[50])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Payment Journal'), "Field Name" = filter('Payment Type'));
        }
        field(50003; "Requested By"; Code[50]) { }
        field(50004; "Created By"; Text[50]) { }
        field(50014; RDAP; Text[25])
        {
            Editable = false;
        }
        field(50005; RDBL; Text[25])
        {
            Editable = false;
        }
        field(50006; NIC; Text[20])
        {
            Editable = false;
        }
        field(50007; "Student Name"; Text[250])
        {
            Editable = false;
        }
        field(50008; "Login Email"; Text[100])
        {
            Editable = false;
        }
        field(50009; "Contact Email"; Text[100])
        {
            Editable = false;
        }
        field(50010; "Phone"; Text[20])
        {
            Editable = false;
        }
        field(50011; "Mobile"; Text[20])
        {
            Editable = false;
        }
        field(50012; Address; Text[100])
        {
            Editable = false;
        }
        field(50013; Country; Text[50])
        {
            Editable = false;
        }
        field(50015; "TDS Code"; Text[30]) { }
        field(50016; VAT; Boolean) { }
        field(50017; "Retention Fee"; Boolean) { }
        field(50018; Payee; Text[100]) { }
        field(50019; "Vendor Type"; Text[50]) { }
        field(50020; "Date Earmarked"; Date) { }
        field(50021; "Amount Earmarked"; Decimal) { }
        field(50022; "Earmark ID"; Text[25]) { }
        field(50023; Earmarked; Text[150]) { }
        field(50024; "Original PO Number"; Code[20])
        {
            Caption = 'Original Purchase Order Number';
        }
        field(50025; "Payment Journal No."; Text[20]) { }
        field(50026; ReceiptPaymentRep; Boolean) { }
        field(50027; "Vendor Category"; Text[50]) { }
        field(50028; "From OU Portal"; Boolean) { Editable = false; }
        field(50029; "FA Revaluation"; Boolean) { }
        field(50030; "Account Category"; Enum "G/L Account Category") { }
        field(50031; "Budget Category"; Code[20]) { }
        field(50032; "Description 2"; Text[250]) { }
        field(50033; "Student ID"; Text[10]) { }
        field(50034; "Payee Name"; Text[50])
        {
            Caption = 'Payee Name';
        }
        field(50035; "FA Supplier No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Supplier No.';
            TableRelation = Vendor."No.";
        }
        field(50036; "Amount Tendered"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50037; "Amount To Remit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
    }

    trigger OnInsert()
    var
        grecGLAccount: Record "G/L Account";
    begin
        if grecGLAccount.Get("G/L Account No.") then
            "Budget Category" := grecGLAccount."Budget Category";
    end;
}