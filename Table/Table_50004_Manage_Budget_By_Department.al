table 50004 Budget_By_Department
{
    Caption = 'Manage Budget by Department';

    fields
    {
        field(1; "G/L Account No."; code[20])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            var
                grecGLAccount: Record "G/L Account";
            begin
                if grecGLAccount.Get("G/L Account No.") then
                    "G/L Description" := grecGLAccount.Name;
            end;
        }
        field(2; "G/L Description"; Text[50]) { }
        field(3; Department; Text[50])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('DEPARTMENT'));
        }
        field(4; "Budgeted Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE("G/L Account No." = FIELD("G/L Account No."), "Global Dimension 1 Code" = FIELD(Department), "Include on Budget Matrix" = filter(true)));
        }
        field(5; "Budgeted Amt for Current Year"; Decimal) { }
        field(6; "Remaining Amount"; Decimal) { }
        field(7; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(8; "R. Amt for Last Year (Closing)"; Decimal)
        {
            Caption = 'Remaining Amount for Last Year (Closing)';
        }
        field(9; "Additions for Current Year"; Decimal) { }
    }

    keys
    {
        key(PK; "Entry No.", "G/L Account No.", Department)
        {
            Clustered = true;
        }
    }

    var
        gdateStartDate: Date;
}