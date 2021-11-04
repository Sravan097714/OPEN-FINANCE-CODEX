tableextension 50043 DimensionValueExt extends "Dimension Value"
{
    fields
    {
        field(50000; "Name 2"; Text[250]) { }
        field(50001; "Starting Date"; Date) { }
        field(50002; "Ending Date"; Date) { }
        field(50003; "Gen. Prod. Posting Group"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group";
        }
    }
}