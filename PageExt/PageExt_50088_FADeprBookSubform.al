pageextension 50088 FADeprBookSubform extends "FA Depreciation Books Subform"
{
    layout
    {
        modify("Declining-Balance %")
        {
            Visible = false;
        }
        addlast(Control1)
        {
            field("Acquisition Cost"; "Acquisition Cost")
            {
                ApplicationArea = All;
            }
            field("Disposal Date"; "Disposal Date")
            {
                ApplicationArea = All;
            }
            field(Depreciation; Depreciation)
            {
                ApplicationArea = all;
            }
            field("Monthly Depreciation"; "Monthly Depreciation")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        FALedgerEntry: Record "FA Ledger Entry";
    begin
        FALedgerEntry.Reset();
        FALedgerEntry.SetCurrentKey("Entry No.");
        FALedgerEntry.SetRange("FA No.", "FA No.");
        FALedgerEntry.SetRange("FA Posting Type", FALedgerEntry."FA Posting Type"::Depreciation);
        FALedgerEntry.SetRange(Reversed, false);
        if FALedgerEntry.FindLast() then
            "Monthly Depreciation" := FALedgerEntry.Amount;
    end;


    trigger OnAfterGetCurrRecord()
    var
        FALedgerEntry: Record "FA Ledger Entry";
    begin
        FALedgerEntry.Reset();
        FALedgerEntry.SetCurrentKey("Entry No.");
        FALedgerEntry.SetRange("FA No.", "FA No.");
        FALedgerEntry.SetRange("FA Posting Type", FALedgerEntry."FA Posting Type"::Depreciation);
        FALedgerEntry.SetRange(Reversed, false);
        if FALedgerEntry.FindLast() then
            "Monthly Depreciation" := FALedgerEntry.Amount;
    end;
}