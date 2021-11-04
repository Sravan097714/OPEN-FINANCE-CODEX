tableextension 50025 GenJnlBatchExt extends "Gen. Journal Batch"
{
    fields
    {
        field(50000; "PV No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50001; "Vendor Type"; Code[50])
        {
            Caption = 'Vendor Category';
            TableRelation = "New Categories".Code where("Table Name" = filter('Vendor'), "Field Name" = filter('Vendor Category'));
            ;
        }
    }
}