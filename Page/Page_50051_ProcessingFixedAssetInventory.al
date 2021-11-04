page 50051 "Process Fixed Asset Inventory"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Fixed Asset Inventories";
    Caption = 'Processing Fixed Asset Inventory';

    layout
    {
        area(Content)
        {
            repeater("Fixed Asset")
            {
                field("Fixed Asset No."; "Fixed Asset No.") { ApplicationArea = All; }
                field(Description; Description) { ApplicationArea = All; }
                field("FA Class Code"; "FA Class Code") { ApplicationArea = ALl; }
                field("FA Location Code"; "FA Location Code") { ApplicationArea = All; }
                field("Serial No."; "Serial No.") { ApplicationArea = All; }
                field(Make; Make) { ApplicationArea = All; }
                field(Model; Model) { ApplicationArea = All; }
                field("Insurance Type"; "Insurance Type") { ApplicationArea = ALl; }
                field("Scanned By"; "Scanned By") { ApplicationArea = All; }
                field("Scanned On"; "Scanned On") { ApplicationArea = All; }
                field("Scan Here"; "Scan Here")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        "Scanned By" := UserId;
                        "Scanned On" := CurrentDateTime;
                    end;
                }
            }
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