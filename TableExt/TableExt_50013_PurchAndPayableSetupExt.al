tableextension 50013 PurchAndPayableSetupExt extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Doc. Posting Date as WORKDATE"; Code[20]) { }
        field(50001; "Threshold Goods & Services Rpt"; Decimal)
        {
            Caption = 'Threshold for Goods and Services Report';
        }
        field(50002; "Bank Transfer Report ID"; Integer) { }
        field(50003; "Vendor Cheque Trans. Report ID"; Integer) { }
        field(50004; "Vendor Bank Trans. Report ID"; Integer) { }
        field(50005; "Signature 1"; text[50]) { }
        field(50006; "Signature 2"; text[50]) { }
        field(50007; "Requisition No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50008; "Sign for Emoluments"; Text[50]) { }
        field(50009; "Claim No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50010; "Retention Fee"; Text[20])
        {
            TableRelation = "G/L Account";
        }
        field(50011; "EarmarkID Counter"; Integer) { }
        field(50012; "EarmarkID Counter Date"; Date) { }

        field(50013; "Bulk Bank Transfer – Chaiman"; Text[50]) { }
        field(50014; "Bank Trans – Director General"; Text[50])
        {
            Caption = 'Bulk Bank Transfer – Director General’ ';
        }
        field(50015; "Bulk Bank Transfer – enc."; Text[50]) { }
        field(50016; "PAYE Claims"; Code[20])
        {
            Caption = 'PAYE Claims';
            TableRelation = "G/L Account"."No.";
        }

        field(50017; "PAYE Payroll"; Code[20])
        {
            Caption = 'PAYE Payroll';
            TableRelation = "G/L Account"."No.";
        }
    }
}