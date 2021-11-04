tableextension 50042 SalesInvLineExt extends "Sales Invoice Line"
{
    fields
    {
        field(50000; "Common Module Code"; Code[20]) { }
        field(50001; Instalment; Boolean) { }
        field(50002; "Original Amount"; Decimal) { }
    }
}