tableextension 50022 BankAccLedgerEntryExt extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50000; "PV Number"; Code[20]) { }
        field(50001; "Payment Type"; Code[50])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Payment Journal'), "Field Name" = filter('Payment Type'));
        }
        field(50004; RDAP; Text[25])
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
        field(50002; Address; Text[100])
        {
            Editable = false;
        }
        field(50003; Country; Text[50])
        {
            Editable = false;
        }
        field(50012; "TDS Code"; Text[30]) { }
        field(50013; VAT; Boolean) { }
        field(50014; "Retention Fee"; Boolean) { }
        field(50015; Payee; Text[100]) { }
        field(50016; "Vendor Type"; Text[50]) { }
        field(50017; "Payment Method Code"; Text[10]) { }
        field(50018; "OR No. Printed"; Integer) { }
        field(50019; "Payment Journal No."; Text[20]) { }
        field(50020; ReceiptPaymentRep; Boolean) { }
        field(50021; "Vendor Category"; Text[50]) { }
        field(50034; "Payee Name"; Text[50])
        {
            Caption = 'Payee Name';
        }
        field(50035; "Amount Tendered"; Decimal)
        {
            Caption = 'Amount Tendered';
        }
        field(50036; "Amount to Remit"; Decimal)
        {
            Caption = 'Amount to Remit';
        }
    }
}