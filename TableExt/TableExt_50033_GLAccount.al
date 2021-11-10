tableextension 50033 GLAccountExt extends "G/L Account"
{
    fields
    {
        field(50000; "Remaining Budget"; Decimal) { }

        field(50001; "Budgeted Amount for Current Yr"; Decimal)
        {
            Caption = 'Budgeted Amount for Current Year';
            FieldClass = flowfield;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE("G/L Account No." = FIELD("No."), "G/L Account No." = FIELD(FILTER(Totaling)), "Business Unit Code" = FIELD("Business Unit Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), Date = FILTER(010121 .. 311221), "Budget Name" = FIELD("Budget Filter"), "Dimension Set ID" = FIELD("Dimension Set ID Filter")));
        }
        field(50002; "FA Acquisition"; Code[20]) { }
        field(50003; "FA Acquisition 2"; Code[20]) { }
        field(50004; DateFilterCustomize; Text[20]) { }
        field(50005; "Created By"; Text[100]) { Editable = false; }
        field(50006; "Date Created"; DateTime) { Editable = false; }
        field(50007; "Budget Category"; Code[20])
        {
            TableRelation = "Budget Category"."Budget Category Code";
        }
        field(50008; Income; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}