page 50032 "FA Insurance Setup List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "FA Insurance Setup";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                //field("FA Posting Group"; "FA Posting Group") { ApplicationArea = All; }
                field(Year; Year) { ApplicationArea = All; }
                field("Insurance Amount %"; "Insurance Amount %") { ApplicationArea = All; }
                field("Insurance Type"; "Insurance Type") { ApplicationArea = All; }
            }
        }
    }
}