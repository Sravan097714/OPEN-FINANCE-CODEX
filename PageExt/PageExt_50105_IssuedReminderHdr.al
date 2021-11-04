pageextension 50104 IssuedReminderExt extends "Issued Reminder"
{
    layout
    {
        addlast(General)
        {
            field("Deadline for Payment"; "Deadline for Payment") { ApplicationArea = All; }
            field("Reminder Ref"; "Reminder Ref")
            {
                ApplicationArea = All;
            }
            field("Customer Posting Group"; "Customer Posting Group")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Posting Description"; "Posting Description")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Created By"; "Created By") { ApplicationArea = All; }
            field("Created On"; "Created On") { ApplicationArea = All; }
        }
        modify(Canceled)
        {
            Visible = false;
        }
        modify("Fin. Charge Terms Code")
        {
            Visible = false;
        }
    }

    actions
    {
        modify("&Print")
        {
            trigger OnBeforeAction()
            begin
                if "Shortcut Dimension 1 Code" = '' then
                    error('');
            end;
        }
    }
}