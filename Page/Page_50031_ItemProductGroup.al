page 50031 "Item Product Groups"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Product Group";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Item Category Code"; "Item Category Code") { ApplicationArea = All; }
                field("Product Group Code"; "Product Group Code") { ApplicationArea = All; }
                field(Description; Description) { ApplicationArea = All; }
            }
        }
    }
}