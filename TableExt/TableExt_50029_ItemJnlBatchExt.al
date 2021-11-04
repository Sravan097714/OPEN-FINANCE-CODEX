tableextension 50029 ItemJnlBatchExt extends "Item Journal Batch"
{
    fields
    {
        field(50000; "Positive Item Batch"; Boolean) { }
        field(50001; "Gen. Prod Posting Group"; code[20])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(50002; "Hash Quantity"; Decimal) { }
    }
}