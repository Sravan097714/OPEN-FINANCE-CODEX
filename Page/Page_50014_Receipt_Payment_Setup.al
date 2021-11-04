page 50014 Receipt_Payment_Setup
{
    PageType = List;
    SourceTable = 50006;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Row No."; "Row No.")
                {
                    ApplicationArea = All;
                }
                field("Row Name"; "Row Name")
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
                field("G/L Account No. Filter"; "G/L Account No. Filter")
                {
                    ApplicationArea = All;
                }
                field("Dimension Value Type"; "Dimension Value Type")
                {
                    ApplicationArea = All;
                }
                field(Row; Row) { }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}