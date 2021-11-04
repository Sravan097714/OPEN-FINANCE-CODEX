pageextension 50130 GeneralLedgerSetupExt extends "General Ledger Setup"
{
    layout
    {
        addlast(General)
        {
            field("VAT %"; "VAT %") { ApplicationArea = All; }
        }
    }
}