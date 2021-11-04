page 50015 "Users for Cash Receipt Journal"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 50007;
    Caption = 'Users for Journals';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(UserID; UserID)
                {
                    ApplicationArea = All;
                }
                field("Jnl Template Name"; "Jnl Template Name")
                {
                    ApplicationArea = All;
                }
                field("Jnl Batch Name"; "Jnl Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Vendor Type"; "Vendor Type")
                {
                    Caption = 'Vendor Category';
                    ApplicationArea = All;
                }
            }
        }
    }
}