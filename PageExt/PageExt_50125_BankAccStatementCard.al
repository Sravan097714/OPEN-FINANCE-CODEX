pageextension 50125 BankAccStatementCard extends "Bank Account Statement"
{
    layout
    {
        modify("Balance Last Statement")
        {
            Caption = 'Opening Bank Balance';
        }
        modify("Statement Ending Balance")
        {
            Caption = 'Closing Bank Balance';
        }

        addlast(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(275),
                            "No." = FIELD("Statement No."),
                            "Bank Account No." = field("Bank Account No.");
            }
        }
    }
}