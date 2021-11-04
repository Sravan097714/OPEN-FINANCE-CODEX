pageextension 50087 GLBudgetExt extends "G/L Budget Names"
{
    layout
    {
        addlast(Control1)
        {
            field("Include on Budget Matrix"; "Include on Budget Matrix") { ApplicationArea = All; }
        }
    }



    actions
    {
        addlast(Processing)
        {
            action("Update Budget Name for Budgeted Amount")
            {
                Image = UpdateDescription;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    GLBudgetName: Record "G/L Budget Name";
                    GLBudgetEntry: Record "G/L Budget Entry";
                begin
                    GLBudgetName.Reset();
                    GLBudgetName.SetRange("Include on Budget Matrix", true);
                    if GLBudgetName.FindSet() then begin
                        repeat
                            GLBudgetEntry.Reset();
                            GLBudgetEntry.SetRange("Budget Name", GLBudgetName.Name);
                            if GLBudgetEntry.FindFirst() then begin
                                GLBudgetEntry.Modifyall("Include on Budget Matrix", true);
                            end;
                            Message('Update completed.');
                        until GLBudgetName.Next = 0;
                    end;
                end;
            }

            action("Reset Budget Name for Budgeted Amount")
            {
                Image = Recalculate;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    GLBudgetName: Record "G/L Budget Name";
                    GLBudgetEntry: Record "G/L Budget Entry";
                begin
                    GLBudgetName.Reset();
                    GLBudgetName.SetRange("Include on Budget Matrix", true);
                    if GLBudgetName.FindSet() then begin
                        repeat
                            GLBudgetEntry.Reset();
                            GLBudgetEntry.SetRange("Budget Name", GLBudgetName.Name);
                            if GLBudgetEntry.FindFirst() then begin
                                GLBudgetEntry.Modifyall("Include on Budget Matrix", false);
                            end;
                            Message('Reset completed.');
                        until GLBudgetName.Next = 0;
                    end;
                end;
            }
        }
    }
}
