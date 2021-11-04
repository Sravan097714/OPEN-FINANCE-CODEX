pageextension 50102 ReminderListExt extends "Reminder List"
{
    layout
    {
        addlast(Control1)
        {
            field("Reminder Level"; "Reminder Level") { ApplicationArea = All; }
            field("Document Date"; "Document Date") { ApplicationArea = All; }
            field("Posting Date"; "Posting Date") { ApplicationArea = All; }
            field("Posting Description"; "Posting Description")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("Created By"; "Created By") { ApplicationArea = All; }
            field("Created On"; "Created On") { ApplicationArea = All; }
        }

        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
        }
        modify("Assigned User ID")
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
    trigger OnOpenPage()
    begin
        SetRange("Course Reminder", false);
    end;
}