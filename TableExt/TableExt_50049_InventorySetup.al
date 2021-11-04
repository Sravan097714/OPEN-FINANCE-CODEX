tableextension 50049 InventorySetup extends "Inventory Setup"
{
    fields
    {
        field(50000; "Module No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
    }
}