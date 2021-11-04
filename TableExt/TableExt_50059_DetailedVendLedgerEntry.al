tableextension 50059 DetVendLedgerEntry extends "Detailed Vendor Ledg. Entry"
{
    fields
    {
        field(50000; "Payment Type"; Code[50])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Payment Journal'), "Field Name" = filter('Payment Type'));
        }
    }
}