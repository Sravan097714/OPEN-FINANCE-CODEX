pageextension 50082 ItemJnlBatchesPgExt extends "Item Journal Batches"
{
    layout
    {
        addlast(Control1)
        {
            field("Positive Item Batch"; "Positive Item Batch") { }
        }
        addafter("No. Series")
        {
            field("Gen. Prod Posting Group"; "Gen. Prod Posting Group") { }
        }
    }
}