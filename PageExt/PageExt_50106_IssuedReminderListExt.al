pageextension 50106 IssuedReminderListExt extends "Issued Reminder List"
{
    layout
    {
        addlast(Control1)
        {
            field("Reminder Level"; "Reminder Level") { ApplicationArea = All; }
            field("Document Date"; "Document Date") { ApplicationArea = All; }
            field("Posting Date"; "Posting Date") { ApplicationArea = All; }
            field("Due Date"; "Due Date") { ApplicationArea = All; }
            field("Posting Description"; "Posting Description") { ApplicationArea = All; }
            field("Customer Posting Group"; "Customer Posting Group") { ApplicationArea = All; }
            field("Created By"; "Created By") { ApplicationArea = All; }
            field("Created On"; "Created On") { ApplicationArea = All; }
        }
        modify(Canceled)
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