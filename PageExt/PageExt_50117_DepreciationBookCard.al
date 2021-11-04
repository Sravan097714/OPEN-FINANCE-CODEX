pageextension 50117 DeprBookCardExt extends "Depreciation Book Card"
{
    layout
    {
        addlast(General)
        {
            field("FA Revaluation"; "FA Revaluation") { ApplicationArea = All; }
        }
    }
}