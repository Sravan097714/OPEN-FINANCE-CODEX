pageextension 50081 AccScheduleExt extends "Account Schedule"
{
    layout
    {
        modify("Dimension 1 Totaling")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Dimension 2 Totaling")
        {
            Visible = true;
            ApplicationArea = All;
        }
        addfirst(Control1)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
    }
}