tableextension 50062 MyExtension extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50000; "FA Aquisition"; code[20])
        {
            Editable = true;
        }
        field(50001; "FA Aquisition 2"; Code[20])
        {
            Editable = true;
        }
        field(50002; "TDS Code"; Text[30])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Payment Journal'), "Field Name" = filter('TDS Code'));
        }
        field(50003; VAT; Boolean) { }
        field(50004; "Retention Fee"; Boolean) { }
        field(50005; "G/L Account for Budget"; code[20]) { }
        field(50006; "TDS %"; Decimal) { }
        field(50007; PAYE; Boolean) { }
        field(50008; "VAT Amount Input"; Decimal) { }
        field(50009; "Account Category"; Enum "G/L Account Category") { }
        field(50010; "Budget Category"; Code[20])
        {
            TableRelation = "Budget Category"."Budget Category Code";
        }
        field(50011; TDS; Boolean) { }
        field(50012; "Line Amount Excluding VAT"; Decimal) { }
        field(50013; "TDS Account No."; Code[20]) { }
        field(50014; "Earmark ID"; Text[25]) { }
        field(50015; "Date Earmarked"; Date) { }
    }
}