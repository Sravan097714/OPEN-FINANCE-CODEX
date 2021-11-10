pageextension 50005 GLAccountCard extends "G/L Account Card"
{
    layout
    {
        modify("Account Category")
        {
            Visible = false;
        }
        modify("No. of Blank Lines")
        {
            Visible = false;
        }
        addafter("No.")
        {
            field("No. 2"; "No. 2")
            {
                ApplicationArea = All;
            }
        }
        modify("New Page")
        {
            Visible = false;
        }
        modify("Search Name")
        {
            Visible = false;
        }
        modify("Reconciliation Account")
        {
            Visible = false;
        }
        modify("Automatic Ext. Texts")
        {
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Visible = false;
        }
        modify("Omit Default Descr. in Jnl.")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify("Default IC Partner G/L Acc. No")
        {
            Visible = false;
        }
        modify("Consol. Translation Method")
        {
            Visible = false;
        }
        modify("Cost Accounting")
        {
            Visible = false;
        }
        modify("Exchange Rate Adjustment")
        {
            Visible = false;
        }
        modify(Consolidation)
        {
            Visible = false;
        }
        modify(Reporting)
        {
            Visible = false;
        }
        addlast(General)
        {
            /* field("Budgeted Amount"; Rec."Budgeted Amount")
            {
                ApplicationArea = All;
            }
            field("Remaining Budget"; "Remaining Budget")
            {
                ApplicationArea = All;
            }
            field("Budgeted Amount for Current Year"; "Budgeted Amount for Current Yr")
            {
                ApplicationArea = All;
            } */
            field("FA Acquisition"; "FA Acquisition")
            {
                ApplicationArea = All;
            }
            field("FA Acquisition 2"; "FA Acquisition 2")
            {
                ApplicationArea = All;
            }
            field("Created By"; "Created By") { ApplicationArea = All; }
            field("Date Created"; "Date Created") { ApplicationArea = All; }
            field("Budget Category"; "Budget Category") { ApplicationArea = all; }
            field(Income; Rec.Income) { }
        }

    }
}