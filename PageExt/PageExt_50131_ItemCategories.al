pageextension 50131 ItemCategoriesExt extends "Item Categories"
{
    layout
    {
        addlast(Control1)
        {
            field("Gen. Prod Posting Group"; "Gen. Prod Posting Group") { ApplicationArea = All; }
            field("VAT Prod Posting Group"; "VAT Prod Posting Group") { ApplicationArea = All; }
            field("Inventory Posting Group"; "Inventory Posting Group") { ApplicationArea = All; }
        }
    }
}