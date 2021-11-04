pageextension 50116 CustPostingGroupExt extends "Customer Posting Groups"
{
    layout
    {
        addlast(Control1)
        {
            field("Start Date"; "Start Date") { ApplicationArea = All; }
            field("End Date"; "End Date") { ApplicationArea = All; }
        }
    }
}