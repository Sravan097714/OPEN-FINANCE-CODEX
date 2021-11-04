page 50061 "Earmarking for Claim Forms"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Earmarking Claim Forms Table";

    layout
    {
        area(Content)
        {
            repeater(" ")
            {
                field("G/L Account Earmarked"; "G/L Account Earmarked")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Active := true;
                    end;
                }
                field("G/L Description"; "G/L Description") { ApplicationArea = All; }
                field("Earmark ID"; "Earmark ID") { ApplicationArea = ALl; }
                field("Date Earmarked"; "Date Earmarked") { ApplicationArea = All; }
                field("Earmarked By"; "Earmarked By") { ApplicationArea = All; }
                field("Amount Earmarked"; "Amount Earmarked") { ApplicationArea = All; }
                field(Description; Description) { ApplicationArea = All; }
                field(Active; Active) { ApplicationArea = All; }
            }
        }
    }
}