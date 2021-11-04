tableextension 50063 ItemCategoryExt extends "Item Category"
{
    fields
    {
        field(50000; "Gen. Prod Posting Group"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(50001; "VAT Prod Posting Group"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(50002; "Inventory Posting Group"; Code[20])
        {
            TableRelation = "Inventory Posting Group";
        }
    }
}