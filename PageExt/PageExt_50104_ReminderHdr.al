pageextension 50105 ReminderExt extends Reminder
{
    layout
    {
        addlast(General)
        {
            field("Deadline for Payment"; "Deadline for Payment")
            {
                ApplicationArea = All;
            }
            field("Reminder Ref"; "Reminder Ref")
            {
                ApplicationArea = All;
            }
            field("Created By"; "Created By") { ApplicationArea = All; }
            field("Created On"; "Created On") { ApplicationArea = All; }
        }

        modify("Fin. Charge Terms Code")
        {
            Visible = false;
        }
    }

    actions
    {
        modify(CreateReminders)
        {
            trigger OnBeforeAction()
            begin
                REPORT.RunModal(REPORT::"Create Reminders - Normal");
                Error('');
            end;
        }
    }
}