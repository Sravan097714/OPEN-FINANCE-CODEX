report 50023 GLRegisterInput
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Input Reverse G/L Register Date';
    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Input Reversal Date")
                {
                    field("Posting Date"; gdateUserPostingDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            gdateUserPostingDate := Today;
        end;

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            gcuReverseRegister.gfuncGetUserRevervePostingDate(gdateUserPostingDate);
        end;
    }

    var
        gdateUserPostingDate: Date;
        gcuReverseRegister: Codeunit ReverseRegister;
}