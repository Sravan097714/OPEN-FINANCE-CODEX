pageextension 50015 BankAccountCard extends "Bank Account Card"
{
    layout
    {
        modify("Our Contact Code")
        {
            Visible = false;
        }
        modify("SEPA Direct Debit Exp. Format")
        {
            Visible = false;
        }
        modify("Credit Transfer Msg. Nos.")
        {
            Visible = false;
        }
        modify("Direct Debit Msg. Nos.")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("Bank Clearing Code")
        {
            Visible = false;
        }
        modify("Bank Clearing Standard")
        {
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Visible = false;
        }
        modify("Transit No.")
        {
            Visible = false;
        }
        modify("Last Payment Statement No.")
        {
            Visible = false;
        }
        modify("Transit No.2")
        {
            Visible = false;
        }
        modify("Bank Statement Import Format")
        {
            Visible = false;
        }
        modify("Payment Export Format")
        {
            Visible = false;
        }
        modify("Bank Branch No.2")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Bank Account No.2")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Payment Match Tolerance")
        {
            Visible = false;
        }

        addafter("Bank Acc. Posting Group")
        {
            /* field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                Visible = false;
                ApplicationArea = All;
            } */
        }
        addlast(General)
        {
            field("Receipts Only"; "Receipts Only") { ApplicationArea = All; }
            field("Name Of the Account"; Rec."Name Of the Account") { ApplicationArea = all; }
        }
    }
}