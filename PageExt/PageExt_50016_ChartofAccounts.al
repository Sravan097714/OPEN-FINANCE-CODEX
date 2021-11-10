pageextension 50016 ChartofAccounts extends "Chart of Accounts"
{
    layout
    {
        modify("Cost Type No.")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Account Category")
        {
            Visible = false;
            Editable = true;
        }
        modify("Account Subcategory Descript.")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Direct Posting")
        {
            Visible = true;
            ApplicationArea = All;
        }
        addafter("No.")
        {
            field("No. 2"; "No. 2")
            {
                ApplicationArea = All;
                Editable = false;
            }
            /* field("Budgeted Amount"; "Budgeted Amount")
            {
                ApplicationArea = All;
            }
            field("Remaining Budget"; "Remaining Budget")
            {
                ApplicationArea = All;
            } */
        }

        addlast(Control1)
        {
            field("Budget Category"; "Budget Category")
            {
                ApplicationArea = All;
            }
        }
        addafter("Direct Posting")
        {
            field(Income; Rec.Income)
            {
                ApplicationArea = All;
            }
        }
    }
}