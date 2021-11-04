tableextension 50027 BankAccReconLineExt extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(50000; "Statement Date"; Date) { }
        field(50001; "Debit Amount"; Decimal) { }
        field(50002; "Credit Amount"; Decimal) { }
        field(50003; "Debit Amount (LCY)"; Decimal) { }
        field(50004; "Credit Amount (LCY)"; Decimal) { }
    }
}