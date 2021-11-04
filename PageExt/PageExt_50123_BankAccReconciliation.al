pageextension 50123 BankAccReconcilaitionList extends "Bank Acc. Reconciliation List"
{
    layout
    {
        modify(BalanceLastStatement)
        {
            Caption = 'Opening Bank Balance';
        }
        modify(StatementEndingBalance)
        {
            Caption = 'Closing Bank Balance';
        }
    }
}