codeunit 50003 GenJnlPosting
{
    SingleInstance = true;

    [EventSubscriber(ObjectType::Codeunit, 13, 'OnBeforePostGenJnlLine', '', false, false)]
    local procedure MyProcedureSavePVNumber(VAR GenJournalLine: Record "Gen. Journal Line"; CommitIsSuppressed: Boolean; VAR Posted: Boolean)
    var
        grecGenJnlBatchName: Record "Gen. Journal Batch";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        grecPaymentMtd: Record "Payment Method";
        grecGLEntry: Record "G/L Entry";
        grecSalesReceivableSetup: Record "Sales & Receivables Setup";
        gtextPostingDateErr: Label 'Posting date should be todays date on line %1.';
    begin
        grecSalesReceivableSetup.Get();
        if (GenJournalLine."Journal Template Name" = 'CASH RCPT') OR (GenJournalLine."Journal Template Name" = 'CASH RECE') then begin
            if grecSalesReceivableSetup."Post Cash Receipts today" then begin
                with GenJournalLine do begin
                    if GenJournalLine."Posting Date" <> Today then
                        Error(gtextPostingDateErr, GenJournalLine."Line No.");
                end;
            end;
        end;


        grecGenJnlBatchName.Reset;
        grecGenJnlBatchName.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        grecGenJnlBatchName.SetRange(Name, GenJournalLine."Journal Batch Name");
        grecGenJnlBatchName.Setfilter(grecGenJnlBatchName."PV No. Series", '<>%1', '');
        if grecGenJnlBatchName.FindFirst then begin
            grecGLEntry.Reset();
            //grecGLEntry.SetRange("Payment Journal No.", GenJournalLine."Payment Journal No.");
            grecGLEntry.SetRange("Document No.", GenJournalLine."Document No.");
            if not grecGLEntry.FindFirst() then
                gcodePVNumber := NoSeriesMgt.GetNextNo(grecGenJnlBatchName."PV No. Series", Today, TRUE)
            else
                gcodePVNumber := grecGLEntry."PV Number";
        end else
            Clear(gcodePVNumber);

        with GenJournalLine do begin
            if GenJournalLine."Payment Method Code" <> '' then begin
                if grecPaymentMtd.Get(GenJournalLine."Payment Method Code") then
                    GenJournalLine.ReceiptPaymentRep := grecPaymentMtd.RecPayRep;
            end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitGLEntry', '', false, false)]
    local procedure InsertinGLEntry(VAR GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry."PV Number" := gcodePVNumber;
        GLEntry."Creation Date" := Today;
        GLEntry."Payment Type" := GenJournalLine."Payment Type";
        GLEntry."Created By" := GenJournalLine."Created By";
        GLEntry.RDAP := GenJournalLine.RDAP;
        GLEntry.RDBL := GenJournalLine.RDBL;
        GLEntry.NIC := GenJournalLine.NIC;
        GLEntry."Student Name" := GenJournalLine."Student Name";
        GLEntry."Login Email" := GenJournalLine."Login Email";
        GLEntry."Contact Email" := GenJournalLine."Contact Email";
        GLEntry.Phone := GenJournalLine.Phone;
        GLEntry.Mobile := GenJournalLine.Mobile;
        GLEntry.Address := GenJournalLine.Address;
        GLEntry.Country := GenJournalLine.Country;
        GLEntry."Payee Name" := GenJournalLine."Payee Name";
        GLEntry."Vendor Type" := GenJournalLine."Vendor Type";
        GLEntry."Vendor Category" := GenJournalLine."Vendor Category";
        GLEntry."Earmark ID" := GenJournalLine."Earmark ID";
        GLEntry.Earmarked := GenJournalLine.Earmarked;
        GLEntry."Date Earmarked" := GenJournalLine."Date Earmarked";
        GLEntry."Amount Earmarked" := GenJournalLine."Amount Earmarked";
        GLEntry."TDS Code" := GenJournalLine."TDS Code";
        GLEntry.VAT := GenJournalLine.VAT;
        GLEntry."Retention Fee" := GenJournalLine."Retention Fee";
        GLEntry.ReceiptPaymentRep := GenJournalLine.ReceiptPaymentRep;
        GLEntry."Payment Journal No." := GenJournalLine."Payment Journal No.";
        GLEntry."From OU Portal" := GenJournalLine."From OU Portal";
        GLEntry."Description 2" := GenJournalLine."Description 2";
        GLEntry."Student ID" := GenJournalLine."Student ID";
    end;


    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitBankAccLedgEntry', '', false, false)]
    local procedure InsertinBankAccLedgerEntry(VAR BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        BankAccountLedgerEntry."PV Number" := gcodePVNumber;
        BankAccountLedgerEntry."Payment Type" := GenJournalLine."Payment Type";
        BankAccountLedgerEntry.RDAP := GenJournalLine.RDAP;
        BankAccountLedgerEntry.RDBL := GenJournalLine.RDBL;
        BankAccountLedgerEntry.NIC := GenJournalLine.NIC;
        BankAccountLedgerEntry."Student Name" := GenJournalLine."Student Name";
        BankAccountLedgerEntry."Login Email" := GenJournalLine."Login Email";
        BankAccountLedgerEntry."Contact Email" := GenJournalLine."Contact Email";
        BankAccountLedgerEntry.Phone := GenJournalLine.Phone;
        BankAccountLedgerEntry.Mobile := GenJournalLine.Mobile;
        BankAccountLedgerEntry.Address := GenJournalLine.Address;
        BankAccountLedgerEntry.Country := GenJournalLine.Country;
        BankAccountLedgerEntry."Payee Name" := GenJournalLine."Payee Name"; //LS061021
        BankAccountLedgerEntry."Vendor Type" := GenJournalLine."Vendor Type";
        BankAccountLedgerEntry."Vendor Category" := GenJournalLine."Vendor Category";
        BankAccountLedgerEntry."Payment Method Code" := GenJournalLine."Payment Method Code";
        BankAccountLedgerEntry.ReceiptPaymentRep := GenJournalLine.ReceiptPaymentRep;
        BankAccountLedgerEntry."Payment Journal No." := GenJournalLine."Payment Journal No.";
    end;


    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitVendLedgEntry', '', false, false)]
    local procedure InsertinVendLedgerEntry(VAR VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VendorLedgerEntry."PV Number" := gcodePVNumber;
        VendorLedgerEntry."Payment Type" := GenJournalLine."Payment Type";
        VendorLedgerEntry."Created By" := GenJournalLine."Created By";
        VendorLedgerEntry.Payee := GenJournalLine.Payee;
        VendorLedgerEntry."Vendor Type" := GenJournalLine."Vendor Type";
        VendorLedgerEntry."TDS Code" := GenJournalLine."TDS Code";
        VendorLedgerEntry.VAT := GenJournalLine.VAT;
        VendorLedgerEntry."Retention Fee" := GenJournalLine."Retention Fee";
        VendorLedgerEntry."Vendor Category" := GenJournalLine."Vendor Category";
        VendorLedgerEntry."Payment Journal No." := GenJournalLine."Payment Journal No.";
    end;


    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitCustLedgEntry', '', false, false)]
    local procedure InsertinCustLedgerEntry(VAR CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."Voucher No." := GenJournalLine."Voucher No.";
        CustLedgerEntry."Created By" := GenJournalLine."Created By";
        CustLedgerEntry."From OU Portal" := GenJournalLine."From OU Portal";
    end;


    [EventSubscriber(ObjectType::Codeunit, 232, 'OnAfterPostJournalBatch', '', false, false)]
    local procedure OnAfterPostJournalBatch(var GenJournalLine: Record "Gen. Journal Line");
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        GLReg2: Record "G/L Register";
        GLReg: Record "G/L Register";
        grecPurchPayableSetup: Record "Purchases & Payables Setup";
    begin
        grecPurchPayableSetup.Get();
        if gtextAccountType = 'Bank Account' then begin
            with GenJournalLine do begin
                IF GLReg.GET("Line No.") THEN BEGIN
                    IF GLReg."Source Code" = 'GENJNL' THEN begin
                        BankAccountLedgerEntry.RESET;
                        //BankAccountLedgerEntry.SETRANGE(BankAccountLedgerEntry."Bal. Account Type", BankAccountLedgerEntry."Bal. Account Type"::"Bank Account");
                        BankAccountLedgerEntry.SETRANGE("Entry No.", GLReg."From Entry No.", GLReg."To Entry No.");
                        IF BankAccountLedgerEntry.FINDSET THEN begin
                            REPORT.Run(grecPurchPayableSetup."Bank Transfer Report ID", false, false, BankAccountLedgerEntry);
                        end;
                    end;
                end;
            end;
            gtextAccountType := '';
            Message('The journal lines were successfully posted.');
            Error('');
        end;

        if (gtextAccountType = 'Vendor') and (gtextPaymentMethod = 'CHECK') then begin
            with GenJournalLine do begin
                IF GLReg.GET("Line No.") THEN BEGIN
                    IF GLReg."Source Code" = 'PAYMENTJNL' THEN begin
                        GLReg2.RESET;
                        GLReg2.SETRANGE("From Entry No.", GLReg."From Entry No.");
                        GLReg2.SetRange("To Entry No.", GLReg."To Entry No.");
                        IF GLReg2.FINDSET THEN begin
                            REPORT.Run(grecPurchPayableSetup."Vendor Cheque Trans. Report ID", false, false, GLReg2);
                        end;
                    end;
                end;
                gtextAccountType := '';
                gtextPaymentMethod := '';
                Message('The journal lines were successfully posted.');
                Error('');
            end;
        end;

        if (gtextAccountType = 'Vendor') and (gtextPaymentMethod = 'BANKTRANS') then begin
            with GenJournalLine do begin
                IF GLReg.GET("Line No.") THEN BEGIN
                    IF GLReg."Source Code" = 'PAYMENTJNL' THEN begin
                        VendorLedgerEntry.RESET;
                        //VendorLedgerEntry.SETRANGE(VendorLedgerEntry2."Bal. Account Type", VendorLedgerEntry2."Bal. Account Type"::Vendor);
                        VendorLedgerEntry.SETRANGE("Entry No.", GLReg."From Entry No.", GLReg."To Entry No.");
                        IF VendorLedgerEntry.FINDSET THEN begin
                            REPORT.Run(grecPurchPayableSetup."Vendor Bank Trans. Report ID", false, false, VendorLedgerEntry);
                        end;
                    end;
                end;
            end;
            gtextAccountType := '';
            gtextPaymentMethod := '';
            Message('The journal lines were successfully posted.');
            Error('');
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 232, 'OnBeforePostJournalBatch', '', false, false)]
    local procedure OnBeforePostJournalBatch(var GenJournalLine: Record "Gen. Journal Line"; var HideDialog: Boolean)
    begin
        gtextAccountType := Format(GenJournalLine."Account Type");
        gtextPaymentMethod := GenJournalLine."Payment Method Code";
    end;


    [EventSubscriber(ObjectType::Table, 81, 'OnAfterAccountNoOnValidateGetVendorAccount', '', false, false)]
    local procedure AddVendorNametoPayee(var GenJournalLine: Record "Gen. Journal Line"; var Vendor: Record Vendor; CallingFieldNo: Integer)
    var
        grecVendor: Record Vendor;
    begin
        GenJournalLine.Payee := GenJournalLine.Description;
        if grecVendor.Get(GenJournalLine."Account No.") then begin
            GenJournalLine."Vendor Type" := grecVendor."Vendor Type";
            GenJournalLine."Vendor Category" := grecVendor."Vendor Category";
        end;
    end;


    var
        gcodePVNumber: Code[20];
        gtextAccountType: Text;
        gtextPaymentMethod: Text;
}