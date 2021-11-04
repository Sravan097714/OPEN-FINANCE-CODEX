pageextension 50107 IssuedReminderLinesExt extends "Issued Reminder Lines"
{
    layout
    {
        modify("No. of Reminders")
        {
            Visible = true;
        }
        modify("Original Amount")
        {
            Visible = true;
        }
        modify("Posting Date")
        {
            Visible = true;
        }
        modify(Amount)
        {
            Visible = false;
        }

        addlast(Control1)
        {
            field("Global Dimension 1"; "Global Dimension 1") { ApplicationArea = All; }
            field("Global Dimension 2"; "Global Dimension 2") { ApplicationArea = All; }
        }
    }
}