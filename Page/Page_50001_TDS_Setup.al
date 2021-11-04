page 50001 "TDS Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "TDS Setup";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("TDS Code"; "TDS Code")
                {
                    ApplicationArea = All;
                }
                field("TDS Percentage"; "TDS Percentage")
                {
                    ApplicationArea = All;
                }
                field("TDS Account"; "TDS Account")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}