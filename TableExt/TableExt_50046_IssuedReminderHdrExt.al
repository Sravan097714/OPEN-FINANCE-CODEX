tableextension 50046 IssuedReminderHdrExt extends "Issued Reminder Header"
{
    fields
    {
        field(50000; "Deadline for Payment"; Date) { }
        field(50001; "Reminder Ref"; Text[100])
        {
            Editable = false;
        }
        field(50002; "Created By"; Text[50])
        {
            Editable = false;
        }
        field(50003; "Created On"; DateTime)
        {
            Editable = false;
        }
        field(50004; "Course Reminder"; Boolean) { }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created On" := CurrentDateTime;
    end;

}