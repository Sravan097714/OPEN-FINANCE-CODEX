codeunit 50006 BankAccEntrySetReconNo
{
    trigger OnRun()
    begin

    end;

    procedure ToggleReconNo(VAR BankAccLedgEntry: Record "Bank Account Ledger Entry"; VAR BankAccReconLine: Record "Bank Acc. Reconciliation Line"; ChangeAmount: Boolean)
    var
        CheckLedgEntry: Record "Check Ledger Entry";
        BankAccSetStmtNo: Codeunit "Bank Acc. Entry Set Recon.-No.";

    begin
        BankAccLedgEntry.LOCKTABLE;
        CheckLedgEntry.LOCKTABLE;
        BankAccReconLine.LOCKTABLE;
        BankAccReconLine.FIND;
        IF BankAccLedgEntry."Statement No." = '' THEN BEGIN
            BankAccSetStmtNo.SetReconNo(BankAccLedgEntry, BankAccReconLine);
            BankAccReconLine."Applied Amount" := BankAccReconLine."Applied Amount" + BankAccLedgEntry."Remaining Amount";
            BankAccReconLine."Applied Entries" := BankAccReconLine."Applied Entries" + 1;

            BankAccReconLine."Debit Amount" := BankAccReconLine."Debit Amount" + BankAccLedgEntry."Debit Amount";
            BankAccReconLine."Credit Amount" := BankAccReconLine."Credit Amount" + BankAccLedgEntry."Credit Amount";
            BankAccReconLine."Debit Amount (LCY)" := BankAccReconLine."Debit Amount (LCY)" + BankAccLedgEntry."Debit Amount (LCY)";
            BankAccReconLine."Credit Amount (LCY)" := BankAccReconLine."Credit Amount (LCY)" + BankAccLedgEntry."Credit Amount (LCY)";

        END ELSE BEGIN
            BankAccSetStmtNo.RemoveReconNo(BankAccLedgEntry, BankAccReconLine, TRUE);
            BankAccReconLine."Applied Amount" := BankAccReconLine."Applied Amount" - BankAccLedgEntry."Remaining Amount";
            BankAccReconLine."Applied Entries" := BankAccReconLine."Applied Entries" - 1;
        END;

        IF ChangeAmount THEN
            BankAccReconLine.VALIDATE("Statement Amount", BankAccReconLine."Applied Amount")
        ELSE
            BankAccReconLine.VALIDATE("Statement Amount");
        BankAccReconLine.MODIFY;
    end;
}
