page 50056 "OU Portal App Submission"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "OU Portal App Submission";
    Caption = 'OU Portal Application Submission';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(User_ID; User_ID) { ApplicationArea = All; }
                field(Submission; Submission) { ApplicationArea = All; }
                field(RDAP; RDAP) { ApplicationArea = All; }
                field(RDBL; RDBL) { ApplicationArea = ALl; }
                field(NIC; NIC) { ApplicationArea = All; }
                field("First Name"; "First Name") { ApplicationArea = All; }
                field("Last Name"; "Last Name") { ApplicationArea = ALl; }
                field("Maiden Name"; "Maiden Name") { ApplicationArea = All; }
                field(Intake; Intake) { ApplicationArea = All; }
                field("Intake Formatted"; "Intake Formatted") { ApplicationArea = All; }
                field("Login Email"; "Login Email") { ApplicationArea = ALl; }
                field("Contact Email"; "Contact Email") { ApplicationArea = All; }
                field(Phone; Phone) { ApplicationArea = All; }
                field(Mobile; Mobile) { ApplicationArea = All; }
                field(Address; Address) { ApplicationArea = All; }
                field(Country; Country) { ApplicationArea = All; }
                field("Programme 1"; "Programme 1") { ApplicationArea = All; }
                field("Programme 2"; "Programme 2") { ApplicationArea = All; }
                field("Programme 3"; "Programme 3") { ApplicationArea = All; }
                field("Programme 4"; "Programme 4") { ApplicationArea = All; }
                field(Status; Status) { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Upload Application Submsission")
            {
                ApplicationArea = All;
                Image = ImportExcel;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Report.Run(50092);
                end;
            }
        }
    }
}