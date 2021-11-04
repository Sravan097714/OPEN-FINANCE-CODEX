page 50043 "Budget Category"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Budget Category";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Budget Category Code"; "Budget Category Code") { ApplicationArea = All; }
                field(Description; Description) { ApplicationArea = All; }
            }
        }
    }
}