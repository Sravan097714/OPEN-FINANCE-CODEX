pageextension 50068 RecurringGeneralJournal extends "Recurring General Journal"
{
    layout
    {
        modify("Allocated Amt. (LCY)")
        {
            Visible = false;
        }
        modify("Expiration Date")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        addfirst(Control1)
        {
            field("Line No."; Rec."Line No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Created By"; "Created By") { ApplicationArea = All; }
        }
    }
}