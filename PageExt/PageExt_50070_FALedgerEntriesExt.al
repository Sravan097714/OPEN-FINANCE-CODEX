pageextension 50070 FALedgerEntriesExt extends "FA Ledger Entries"
{
    layout
    {
        modify("Global Dimension 1 Code")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Global Dimension 2 Code")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Debit Amount")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Credit Amount")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Reclassification Entry")
        {
            Visible = false;
        }
        modify("Reason Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("User ID")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("No. of Depreciation Days")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Source Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        addlast(Control1)
        {
            field("Straight-Line %"; Rec."Straight-Line %")
            {
                ApplicationArea = all;
            }
            field("Depreciation Starting Date"; Rec."Depreciation Starting Date")
            {
                ApplicationArea = all;
            }
            field("Depreciation Ending Date"; Rec."Depreciation Ending Date")
            {
                ApplicationArea = all;
            }
            field("Depreciation Method"; Rec."Depreciation Method")
            {
                ApplicationArea = all;
            }
            field("FA Class Code"; Rec."FA Class Code")
            {
                ApplicationArea = all;
            }
            field("FA Subclass Code"; Rec."FA Subclass Code")
            {
                ApplicationArea = all;
            }
            field("FA Posting Group"; Rec."FA Posting Group")
            {
                ApplicationArea = all;
            }
            field("Created By"; "Created By")
            {
                ApplicationArea = All;
            }
            field("FA Revaluation"; "FA Revaluation") { ApplicationArea = all; }
            field("FA Supplier No."; "FA Supplier No.") { ApplicationArea = all; }
        }
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
            }
        }
    }
}