pageextension 50085 BankAccReconciliation extends "Bank Acc. Reconciliation"
{

    layout
    {
        modify(BalanceLastStatement)
        {
            Caption = 'Opening Bank Balance';
        }
        modify(StatementEndingBalance)
        {
            Caption = 'Closing Bank Balance';
        }

        addlast(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(273),
                            "No." = FIELD("Statement No."),
                            "Bank Account No." = field("Bank Account No.");
            }
        }
    }
    actions
    {
        addlast(Processing)
        {
            group(Line)
            {
                action("Apply Entries")
                {
                    ApplicationArea = All;
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    trigger OnAction()
                    begin
                        CurrPage.StmtLine.PAGE.gfuncApplyEntries();
                    end;
                }
            }
        }

        modify(Post)
        {
            trigger OnAfterAction()
            var
                grecDocAttach: Record "Document Attachment";
            begin
                grecDocAttach.Reset();
                grecDocAttach.SetRange("Table ID", 273);
                grecDocAttach.SetRange("Bank Account No.", "Bank Account No.");
                grecDocAttach.SetRange("No.", "Statement No.");
                if grecDocAttach.Findset then
                    grecDocAttach.Modifyall("Table ID", 275)
            end;
        }
    }

    trigger OnAfterGetRecord()
    begin
        gCUMiscellaneous.SetMainRecValue("Bank Account No.", "Statement No.");
    end;

    var
        gCUMiscellaneous: Codeunit Miscellaneous;
}