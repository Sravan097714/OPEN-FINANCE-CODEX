pageextension 50084 FADepBookExt extends "FA Depreciation Books"
{
    layout
    {
        modify("FA No.")
        {
            Visible = false;
        }
        modify("No. of Depreciation Months")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Straight-Line %")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Ending Book Value")
        {
            Visible = true;
            ApplicationArea = All;
        }

        addlast(Control1)
        {
            field("Acquisition Cost"; Rec."Acquisition Cost")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(Depreciation; Rec.Depreciation)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Book Value"; Rec."Book Value")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Disposal Date"; Rec."Disposal Date")
            {
                editable = false;
                ApplicationArea = All;
            }
        }
    }
}