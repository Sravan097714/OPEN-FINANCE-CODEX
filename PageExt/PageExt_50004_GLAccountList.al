pageextension 50004 GLAccountList extends "G/L Account List"
{
    layout
    {
        modify("Account Category")
        {
            Visible = false;
            Editable = false;
        }
        modify("Reconciliation Account")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }

        addlast(Control1)
        {
            field("FA Acquisition"; "FA Acquisition")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("FA Acquisition 2"; "FA Acquisition 2")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Budget Category"; "Budget Category") { ApplicationArea = All; }
        }
    }
}