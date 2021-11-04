tableextension 50052 InvoicePostBuffer extends "Invoice Post. Buffer"
{
    fields
    {
        field(50000; "TDS Code"; Text[30]) { }
        field(50001; VAT; Boolean) { }
        field(50002; "Retention Fee"; Boolean) { }
        field(50003; "From Ou Portal"; Boolean) { }
    }
}