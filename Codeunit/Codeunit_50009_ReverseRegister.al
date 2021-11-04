codeunit 50009 ReverseRegister
{
    SingleInstance = true;

    var
        UserPostingDate: Date;
        Text001: Text;
        GLRegisterInput: Report GLRegisterInput;
        gtextCertificateNo: Text[250];
        gtextReason: Text[250];

    procedure gfuncGetUserRevervePostingDate(UserInputDate: Date)
    begin
        UserPostingDate := UserInputDate;
    end;

    procedure gfuncSetCertificateNo(CertificateNo: Text[250])
    begin
        gtextCertificateNo := CertificateNo;
    end;

    procedure gfuncGetCertificateNo() Certificate: Text[250]
    begin
        exit(gtextCertificateNo);
    end;

    procedure gfuncClearCertificateNo() Certificate: Text[250]
    begin
        gtextCertificateNo := '';
    end;


    procedure gfuncSetReason(Reason: Text[250])
    begin
        gtextReason := Reason;
    end;

    procedure gfuncGetReason() Reason: Text[250]
    begin
        exit(gtextReason);
    end;

    procedure gfuncClearReason() Reason: Text[250]
    begin
        gtextReason := '';
    end;

    [EventSubscriber(ObjectType::Codeunit, 17, 'OnReverseGLEntryOnBeforeInsertGLEntry', '', false, false)]
    local procedure UpdatePostingDate(VAR GLEntry: Record "G/L Entry"; GenJnlLine: Record "Gen. Journal Line"; GLEntry2: Record "G/L Entry")
    begin
        GLEntry."Posting Date" := UserPostingDate;
    end;


    [EventSubscriber(ObjectType::Codeunit, 17, 'OnReverseCustLedgEntryOnBeforeInsertCustLedgEntry', '', false, false)]
    local procedure UpdatePostingDate1(VAR NewCustLedgerEntry: Record "Cust. Ledger Entry"; CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        NewCustLedgerEntry."Posting Date" := UserPostingDate;
    end;


    [EventSubscriber(ObjectType::Codeunit, 17, 'OnReverseVendLedgEntryOnBeforeInsertVendLedgEntry', '', false, false)]
    local procedure UpdatePostingDate2(VAR NewVendLedgEntry: Record "Vendor Ledger Entry"; VendLedgEntry: Record "Vendor Ledger Entry")
    begin
        NewVendLedgEntry."Posting Date" := UserPostingDate;
    end;


    [EventSubscriber(ObjectType::Codeunit, 17, 'OnReverseEmplLedgEntryOnBeforeInsertEmplLedgEntry', '', false, false)]
    local procedure UpdatePostingDate3(VAR NewEmployeeLedgerEntry: Record "Employee Ledger Entry"; EmployeeLedgerEntry: Record "Employee Ledger Entry")
    begin
        NewEmployeeLedgerEntry."Posting Date" := UserPostingDate;
    end;


    [EventSubscriber(ObjectType::Codeunit, 17, 'OnReverseBankAccLedgEntryOnBeforeInsert', '', false, false)]
    local procedure UpdatePostingDate4(VAR NewBankAccLedgEntry: Record "Bank Account Ledger Entry"; BankAccLedgEntry: Record "Bank Account Ledger Entry")
    begin
        NewBankAccLedgEntry."Posting Date" := UserPostingDate;
    end;


    [EventSubscriber(ObjectType::Codeunit, 17, 'OnReverseCustLedgEntryOnBeforeInsertDtldCustLedgEntry', '', false, false)]
    local procedure UpdatePostingDate5(VAR NewDtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    begin
        NewDtldCustLedgEntry."Posting Date" := UserPostingDate;
    end;


    [EventSubscriber(ObjectType::Codeunit, 17, 'OnReverseVendLedgEntryOnBeforeInsertDtldVendLedgEntry', '', false, false)]
    local procedure UpdatePostingDate6(VAR NewDtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry")
    begin
        NewDtldVendLedgEntry."Posting Date" := UserPostingDate;
    end;


    [EventSubscriber(ObjectType::Codeunit, 17, 'OnReverseEmplLedgEntryOnBeforeInsertDtldEmplLedgEntry', '', false, false)]
    local procedure UpdatePostingDate7(VAR NewDetailedEmployeeLedgerEntry: Record "Detailed Employee Ledger Entry"; DetailedEmployeeLedgerEntry: Record "Detailed Employee Ledger Entry")
    begin
        NewDetailedEmployeeLedgerEntry."Posting Date" := UserPostingDate;
    end;


    [EventSubscriber(ObjectType::Codeunit, 17, 'OnReverseVATEntryOnBeforeInsert', '', false, false)]
    local procedure UpdatePostingDate8(VAR NewVATEntry: Record "VAT Entry"; VATEntry: Record "VAT Entry")
    begin
        NewVATEntry."Posting Date" := UserPostingDate;
    end;


    [EventSubscriber(ObjectType::Codeunit, 17, 'OnApplyCustLedgEntryByReversalOnBeforeInsertDtldCustLedgEntry', '', false, false)]
    local procedure UpdatePostingDate9(VAR NewDtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    begin
        NewDtldCustLedgEntry."Posting Date" := UserPostingDate;
    end;


    [EventSubscriber(ObjectType::Codeunit, 17, 'OnApplyVendLedgEntryByReversalOnBeforeInsertDtldVendLedgEntry', '', false, false)]
    local procedure UpdatePostingDate10(VAR NewDtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry")
    begin
        NewDtldVendLedgEntry."Posting Date" := UserPostingDate;
    end;


    [EventSubscriber(ObjectType::Codeunit, 17, 'OnApplyEmplLedgEntryByReversalOnBeforeInsertDtldEmplLedgEntry', '', false, false)]
    local procedure UpdatePostingDate11(VAR NewDetailedEmployeeLedgerEntry: Record "Detailed Employee Ledger Entry"; DetailedEmployeeLedgerEntry: Record "Detailed Employee Ledger Entry")
    begin
        NewDetailedEmployeeLedgerEntry."Posting Date" := UserPostingDate;
    end;

    [EventSubscriber(ObjectType::Table, 179, 'OnBeforeCheckEntries', '', false, false)]
    local procedure SkipDateCheckforReversal(ReversalEntry: Record "Reversal Entry"; TableID: Integer; VAR SkipCheck: Boolean)
    begin
        SkipCheck := true;
    end;
}