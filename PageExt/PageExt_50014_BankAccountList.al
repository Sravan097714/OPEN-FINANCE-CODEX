pageextension 50014 BankAccountList extends "Bank Account List"
{
    layout
    {
        modify("Fax No.")
        {
            Visible = true;
            ApplicationArea = All;
        }

        modify("Post Code")
        {
            Visible = false;
        }
        modify("Country/Region Code")
        {
            Visible = false;
        }
        modify("Bank Account No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("SWIFT Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Bank Acc. Posting Group")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Currency Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        addlast(Control1)
        {
            field(Balance; Rec.Balance)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Balance (LCY)"; Rec."Balance (LCY)")
            {
                Editable = false;
                ApplicationArea = All;
            }
            /* field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                Editable = false;
                ApplicationArea = All;
            } */
        }
    }
}