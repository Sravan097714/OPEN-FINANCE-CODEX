pageextension 50080 BankAccReconLine extends "Bank Acc. Reconciliation Lines"
{
    layout
    {
        modify("Check No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Document No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
    }

    procedure gfuncApplyEntries()
    begin
        Rec."Ready for Application" := TRUE;
        //INSERT(true);
        CurrPage.SaveRecord();
        COMMIT;
        ApplyEntries(Rec);
    end;

    local procedure ApplyEntries(BankAccReconLine: Record "Bank Acc. Reconciliation Line")
    var
        BankAccRecon: Record "Bank Acc. Reconciliation";
    begin
        BankAccReconLine2 := BankAccReconLine;
        BankAccReconLine2.TESTFIELD("Ready for Application", TRUE);
        BankAccRecon.GET(BankAccReconLine2."Statement Type", BankAccReconLine2."Bank Account No.", BankAccReconLine2."Statement No.");

        WITH BankAccReconLine2 DO
            CASE Type OF
                Type::"Bank Account Ledger Entry":
                    BEGIN
                        BankAccLedgEntry.RESET;
                        BankAccLedgEntry.SETCURRENTKEY("Bank Account No.", Open);
                        BankAccLedgEntry.SETRANGE("Bank Account No.", "Bank Account No.");
                        BankAccLedgEntry.SETRANGE(Open, TRUE);
                        BankAccLedgEntry.SETFILTER("Statement Status", '%1|%2', BankAccLedgEntry."Statement Status"::Open,
                                                    BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                        BankAccLedgEntry.SETFILTER("Statement No.", '''''|%1', "Statement No.");
                        BankAccLedgEntry.SETFILTER("Statement Line No.", '0|%1', "Statement Line No.");
                        BankAccLedgEntry.SETFILTER(BankAccLedgEntry."Posting Date", '<=%1', BankAccRecon."Statement Date");
                        ApplyBankAccLedgEntry.SetStmtLine(BankAccReconLine);
                        ApplyBankAccLedgEntry.SETRECORD(BankAccLedgEntry);
                        ApplyBankAccLedgEntry.SETTABLEVIEW(BankAccLedgEntry);
                        ApplyBankAccLedgEntry.LOOKUPMODE(TRUE);
                        OK := ApplyBankAccLedgEntry.RUNMODAL = ACTION::LookupOK;
                        CLEAR(ApplyBankAccLedgEntry);
                    END;
                Type::"Check Ledger Entry":
                    BEGIN
                        CheckLedgEntry.RESET;
                        CheckLedgEntry.SETCURRENTKEY("Bank Account No.", Open);
                        CheckLedgEntry.SETRANGE("Bank Account No.", "Bank Account No.");
                        CheckLedgEntry.SETRANGE(Open, TRUE);
                        CheckLedgEntry.SETFILTER("Entry Status", '%1|%2', CheckLedgEntry."Entry Status"::Posted,
                                                CheckLedgEntry."Entry Status"::"Financially Voided");
                        CheckLedgEntry.SETFILTER("Statement Status", '%1|%2', CheckLedgEntry."Statement Status"::Open,
                                                CheckLedgEntry."Statement Status"::"Check Entry Applied");
                        CheckLedgEntry.SETFILTER("Statement No.", '''''|%1', "Statement No.");
                        CheckLedgEntry.SETFILTER("Statement Line No.", '0|%1', "Statement Line No.");
                        ApplyCheckLedgEntry.SetStmtLine(BankAccReconLine);
                        ApplyCheckLedgEntry.SETRECORD(CheckLedgEntry);
                        ApplyCheckLedgEntry.SETTABLEVIEW(CheckLedgEntry);
                        ApplyCheckLedgEntry.LOOKUPMODE(TRUE);
                        OK := ApplyCheckLedgEntry.RUNMODAL = ACTION::LookupOK;
                        CLEAR(ApplyCheckLedgEntry);
                    END;
            END;
    end;

    var
        BankAccReconLine2: Record "Bank Acc. Reconciliation Line";
        CheckLedgEntry: Record "Check Ledger Entry";
        ApplyCheckLedgEntry: Page "Apply Check Ledger Entries";
        OK: Boolean;
        ApplyBankAccLedgEntry: Page "Apply Bank Acc Ledg Entries 2";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
}