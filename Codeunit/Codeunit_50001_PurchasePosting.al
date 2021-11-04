codeunit 50001 "Purchase Posting"
{
    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostLines', '', false, false)]
    Procedure ValidateVATPostingGroup(VAR PurchLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean)
    var
        grecEarmarkClaim: Record "Earmarking Claim Forms Table";
        grecPurchHeader: Record "Purchase Header";
    begin
        if PurchLine.findset() then begin
            repeat
                IF (PurchLine.Type <> PurchLine.Type::" ") and (PurchLine."No." <> '') then
                    PurchLine.TestField("Vat Prod. Posting Group");

                /* if (PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice) or (PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo") then begin
                    if PurchLine."G/L Account for Budget" = '' then
                        Error('Please insert G/L Account for Earmarking on line no. %1.', PurchLine."Line No.");
                end; */

                if grecPurchHeader.get(PurchLine."Document Type", PurchLine."Document No.") then begin
                    if grecPurchHeader.Claim then begin
                        grecEarmarkClaim.Reset();
                        grecEarmarkClaim.SetRange("Earmark ID", PurchLine."Earmark ID");
                        if grecEarmarkClaim.FindFirst() then begin
                            grecEarmarkClaim.Active := false;
                            grecEarmarkClaim.Modify;
                        end;
                    end;
                end;

            until PurchLine.Next() = 0;
        end;
    end;


    procedure OnConfirmPurchPost(Var PurchaseHeader: Record "Purchase Header"): Boolean
    begin
        with PurchaseHeader do begin
            IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order THEN begin
                if PurchaseHeader.Status <> PurchaseHeader.Status::Released then
                    Error('Purchase Order is not released. You cannot proceed.');
                IF UserSetup.GET(USERID) THEN BEGIN
                    CASE UserSetup."Purchase Order Posting" OF
                        UserSetup."Purchase Order Posting"::" ":
                            ERROR('Does not have permission to post. Contact administator to change permission.');

                        UserSetup."Purchase Order Posting"::Receive:
                            BEGIN
                                Selection := STRMENU(TextReceive, 1);
                                IF Selection = 0 THEN
                                    exit(false);
                                Receive := Selection IN [1, 1];
                                Invoice := false;
                            END;

                        UserSetup."Purchase Order Posting"::Invoice:
                            BEGIN
                                Selection := STRMENU(TextInvoice, 1);
                                IF Selection = 0 THEN
                                    exit(false);
                                Invoice := Selection IN [1, 1];
                                Receive := false;
                            END;

                        UserSetup."Purchase Order Posting"::"Receive and Invoice":
                            BEGIN
                                Selection := STRMENU(TextReceiveInvoice, 1);
                                IF Selection = 0 THEN
                                    exit(false);
                                Receive := TRUE;
                                Invoice := TRUE;
                            END;
                        UserSetup."Purchase Order Posting"::All:
                            BEGIN
                                Selection := STRMENU(ReceiveInvoiceQst, 3);
                                IF Selection = 0 THEN
                                    exit(false);
                                Receive := Selection IN [1, 3];
                                Invoice := Selection IN [2, 3];
                            END;
                    END;
                END;
                exit(true);
            End;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, 91, 'OnBeforeConfirmPost', '', false, false)]
    procedure ChangePostSelection(VAR PurchaseHeader: Record "Purchase Header"; VAR HideDialog: Boolean; VAR IsHandled: Boolean; VAR DefaultOption: Integer)
    begin
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            if (PurchaseHeader."PO Category" = '') then
                Error('Please insert PO Category on Purchase Order %1 before posting.', PurchaseHeader."No.");
            if (PurchaseHeader."Procurement Method" = '') then
                Error('Please insert Procurement Method on Purchase Order %1 before posting.', PurchaseHeader."No.");
            if (PurchaseHeader."Category of Successful Bidder" = '') then
                Error('Please insert Category of Successful Bidder on Purchase Order %1 before posting.', PurchaseHeader."No.");
            if (PurchaseHeader.Price = '') then
                Error('Please insert Price on Purchase Order %1 before posting.', PurchaseHeader."No.");
            if (PurchaseHeader.Quality = '') then
                Error('Please insert Quality on Purchase Order %1 before posting.', PurchaseHeader."No.");
            if (PurchaseHeader.Responsiveness = '') then
                Error('Please insert Responsiveness on Purchase Order %1 before posting.', PurchaseHeader."No.");
            if (PurchaseHeader.Delivery = '') then
                Error('Please insert Delivery on Purchase Order %1 before posting.', PurchaseHeader."No.");
            HideDialog := true;
            IF not OnConfirmPurchPost(PurchaseHeader) then
                IsHandled := true;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, 92, 'OnBeforeConfirmPost', '', false, false)]
    procedure ChangePurchPostSeletion(VAR PurchaseHeader: Record "Purchase Header"; VAR HideDialog: Boolean; VAR IsHandled: Boolean)
    begin
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            HideDialog := true;
            IF Not OnConfirmPurchPost(PurchaseHeader) then
                IsHandled := true;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure CheckPostingDesc(VAR Sender: Codeunit "Purch.-Post"; VAR PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean)
    var
        gtextPostingDescError: TextConst ENU = 'Please insert Posting Description.';
    begin
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice then
            CheckTDS(PurchaseHeader);

        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            if (PurchaseHeader."Validated By" = '') or (PurchaseHeader."Validated On" = 0DT) then
                Error('Please validate purchase order to be able to proceed.');
        end;


        IF PurchaseHeader."Posting Description" = '' then
            Error(gtextPostingDescError);
    end;



    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterPostPurchLines', '', false, false)]
    local procedure OnAfterPostPurchLines(VAR PurchHeader: Record "Purchase Header"; VAR PurchRcptHeader: Record "Purch. Rcpt. Header"; VAR PurchInvHeader: Record "Purch. Inv. Header"; VAR PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; VAR ReturnShipmentHeader: Record "Return Shipment Header"; WhseShip: Boolean; WhseReceive: Boolean; VAR PurchLinesProcessed: Boolean; CommitIsSuppressed: Boolean)
    begin
        if PurchHeader.Invoice then;
        //UpdateBudget(PurchHeader);
    end;


    procedure UpdateBudget(Rec: Record "Purchase Header")
    var
        grecPurchaseOrder: Record "Purchase Header";
        grecPurchaseLine: Record "Purchase Line";
        grecGLAccount: Record "G/L Account";
        grecBudgetByDepartment: Record Budget_By_Department;
    begin
        if (rec."Document Type" = Rec."Document Type"::Invoice) then begin
            If grecPurchaseOrder.get(Rec."Document Type", Rec."No.") then begin
                if not grecPurchaseOrder."Budget Updated" then begin
                    grecPurchaseLine.reset;
                    grecPurchaseLine.SetRange("Document No.", grecPurchaseOrder."No.");
                    if grecPurchaseLine.findset then begin
                        repeat
                            grecBudgetByDepartment.Reset();
                            grecBudgetByDepartment.SetRange("G/L Account No.", grecPurchaseLine."G/L Account for Budget");
                            if grecBudgetByDepartment.FindFirst() then begin
                                grecBudgetByDepartment."Remaining Amount" -= grecPurchaseLine.Amount;
                                grecBudgetByDepartment.Modify;
                            end;
                        until grecPurchaseLine.NEXT = 0;
                    end;
                    Rec."Budget Updated" := true;
                end;
            end;
        end;


        if (rec."Document Type" = Rec."Document Type"::"Credit Memo") then begin
            If grecPurchaseOrder.get(Rec."Document Type", Rec."No.") then begin
                if not grecPurchaseOrder."Budget Updated" then begin
                    grecPurchaseLine.reset;
                    grecPurchaseLine.SetRange("Document No.", grecPurchaseOrder."No.");
                    if grecPurchaseLine.findset then begin
                        repeat
                            grecBudgetByDepartment.Reset();
                            grecBudgetByDepartment.SetRange("G/L Account No.", grecPurchaseLine."No.");
                            if grecBudgetByDepartment.FindFirst() then begin
                                grecBudgetByDepartment."Remaining Amount" += grecPurchaseLine.Amount;
                                grecBudgetByDepartment.Modify;
                            end;
                        until grecPurchaseLine.NEXT = 0;
                    end;
                    Rec."Budget Updated" := true;
                end;
            end;
        end;
    end;


    procedure CheckBudget(precPurchaseOrder: Record "Purchase Header"; precPurchaseLine: Record "Purchase Line")
    var
        PurchLineRec: Record "Purchase Line";
        PurchaseLine: Record "Purchase Line";
        grecGLAccount: Record "G/L Account";
        PurchAmount: Decimal;
        PurchAmountDr: Decimal;
        PurchAmountCr: Decimal;
        gtextBudgetError: Label 'Purchase order line with %1 %2 exceeds remaining budgeted amount.';
        grecPurchHdr: Record "Purchase Header";
        gdecRemainingBudget: Decimal;
        grecBudgetByDepartment: Record Budget_By_Department;
    begin
        Clear(PurchAmountDr);
        Clear(PurchAmountCr);
        IF precPurchaseLine.Type = precPurchaseLine.Type::"G/L Account" then begin
            PurchaseLine.RESET;
            PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::"Credit Memo", PurchaseLine."Document Type"::Invoice);
            PurchaseLine.SETRANGE(Type, PurchaseLine.Type::"G/L Account");
            PurchaseLine.SETRANGE("No.", precPurchaseLine."No.");
            IF PurchaseLine.FINDSET THEN BEGIN
                REPEAT
                    if grecPurchHdr.get(PurchaseLine."Document Type", PurchaseLine."Document No.") then begin
                        if (grecPurchHdr."Document Type" = grecPurchHdr."Document Type"::Invoice) then
                            PurchAmountDr += PurchaseLine.Amount;
                        if (grecPurchHdr."Document Type" = grecPurchHdr."Document Type"::"Credit Memo") then
                            PurchAmountCr += PurchaseLine.Amount;
                    end;
                UNTIL PurchaseLine.NEXT = 0;
            END;

            PurchaseLine.RESET;
            PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::"Credit Memo", PurchaseLine."Document Type"::Invoice);
            PurchaseLine.SETRANGE(Type, PurchaseLine.Type::"Fixed Asset");
            PurchaseLine.SETRANGE("FA Aquisition", precPurchaseLine."No.");
            IF PurchaseLine.FINDSET THEN BEGIN
                REPEAT
                    if grecPurchHdr.get(PurchaseLine."Document Type", PurchaseLine."Document No.") then begin
                        if (grecPurchHdr."Document Type" = grecPurchHdr."Document Type"::Invoice) then
                            PurchAmountDr += PurchaseLine.Amount;
                        if (grecPurchHdr."Document Type" = grecPurchHdr."Document Type"::"Credit Memo") then
                            PurchAmountCr += PurchaseLine.Amount;
                    end;
                UNTIL PurchaseLine.NEXT = 0;
            END;

            PurchaseLine.RESET;
            PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::"Credit Memo", PurchaseLine."Document Type"::Invoice);
            PurchaseLine.SETRANGE(Type, PurchaseLine.Type::"Fixed Asset");
            PurchaseLine.SETRANGE("FA Aquisition 2", precPurchaseLine."No.");
            IF PurchaseLine.FINDSET THEN BEGIN
                REPEAT
                    if grecPurchHdr.get(PurchaseLine."Document Type", PurchaseLine."Document No.") then begin
                        if (grecPurchHdr."Document Type" = grecPurchHdr."Document Type"::Invoice) then
                            PurchAmountDr += PurchaseLine.Amount;
                        if (grecPurchHdr."Document Type" = grecPurchHdr."Document Type"::"Credit Memo") then
                            PurchAmountCr += PurchaseLine.Amount;
                    end;
                UNTIL PurchaseLine.NEXT = 0;
            END;
        end;


        IF precPurchaseLine.Type = precPurchaseLine.Type::"Fixed Asset" then begin
            PurchaseLine.RESET;
            PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::"Credit Memo", PurchaseLine."Document Type"::Invoice);
            PurchaseLine.SETRANGE(Type, precPurchaseLine.Type::"G/L Account");
            PurchaseLine.SETFILTER("No.", '%1|%2', precPurchaseLine."FA Aquisition", precPurchaseLine."FA Aquisition 2");
            IF PurchaseLine.FINDSET THEN BEGIN
                REPEAT
                    if grecPurchHdr.get(PurchaseLine."Document Type", PurchaseLine."Document No.") then begin
                        if (grecPurchHdr."Document Type" = grecPurchHdr."Document Type"::Invoice) then
                            PurchAmountDr += PurchaseLine.Amount;
                        if (grecPurchHdr."Document Type" = grecPurchHdr."Document Type"::"Credit Memo") then
                            PurchAmountCr += PurchaseLine.Amount;
                    end;
                UNTIL PurchaseLine.NEXT = 0;
            END;

            PurchaseLine.RESET;
            PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::"Credit Memo", PurchaseLine."Document Type"::Invoice);
            PurchaseLine.SETRANGE(Type, precPurchaseLine.Type::"Fixed Asset");
            PurchaseLine.SETFILTER("FA Aquisition", '%1|%2', precPurchaseLine."FA Aquisition", precPurchaseLine."FA Aquisition 2");
            PurchaseLine.SETFILTER("FA Aquisition 2", '%1|%2', precPurchaseLine."FA Aquisition", precPurchaseLine."FA Aquisition 2");
            IF PurchaseLine.FINDSET THEN BEGIN
                REPEAT
                    if grecPurchHdr.get(PurchaseLine."Document Type", PurchaseLine."Document No.") then begin
                        if (grecPurchHdr."Document Type" = grecPurchHdr."Document Type"::Invoice) then
                            PurchAmountDr += PurchaseLine.Amount;
                        if (grecPurchHdr."Document Type" = grecPurchHdr."Document Type"::"Credit Memo") then
                            PurchAmountCr += PurchaseLine.Amount;
                    end;
                UNTIL PurchaseLine.NEXT = 0;
            END;
        end;

        if PurchAmountDr <> 0 then
            PurchAmountDr := Round(PurchAmountDr, 0.01, '>'); //Invoice

        if PurchAmountCr <> 0 then
            PurchAmountCr := Round(PurchAmountCr, 0.01, '>'); //CreditMemo

        clear(gdecRemainingBudget);
        IF precPurchaseLine.Type = precPurchaseLine.Type::"G/L Account" then begin
            grecBudgetByDepartment.Reset();
            grecBudgetByDepartment.SetRange("G/L Account No.", precPurchaseLine."No.");
            //grecBudgetByDepartment.SetRange(Department, "Shortcut Dimension 1 Code");
            if grecBudgetByDepartment.FindFirst() then begin
                gdecRemainingBudget := grecBudgetByDepartment."Remaining Amount" - PurchAmountDr;
                gdecRemainingBudget += PurchAmountCr;
            end;
        end;

        IF precPurchaseLine.Type = precPurchaseLine.Type::"Fixed Asset" then begin
            grecBudgetByDepartment.Reset();
            grecBudgetByDepartment.SetFilter("G/L Account No.", '%1|%2', precPurchaseLine."FA Aquisition", precPurchaseLine."FA Aquisition 2");
            //grecBudgetByDepartment.SetRange(Department, "Shortcut Dimension 1 Code");
            if grecBudgetByDepartment.FindFirst() then begin
                repeat
                    gdecRemainingBudget += grecBudgetByDepartment."Remaining Amount";
                until grecBudgetByDepartment.Next = 0;
                gdecRemainingBudget -= PurchAmountDr;
                gdecRemainingBudget += PurchAmountCr;
            end;
        end;

        PurchAmount += (precPurchaseLine."Direct Unit Cost" * precPurchaseLine.Quantity);

        IF PurchAmount > gdecRemainingBudget THEN
            Message(gtextBudgetError, precPurchaseLine.Type, precPurchaseLine."No.");
    end;


    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostInvPostBuffer', '', false, false)]
    local procedure OnBeforePostInvPostBuffer(VAR GenJnlLine: Record "Gen. Journal Line"; VAR InvoicePostBuffer: Record "Invoice Post. Buffer"; VAR PurchHeader: Record "Purchase Header"; VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean)
    begin
        GenJnlLine."Earmark ID" := PurchHeader."Earmark ID";
        GenJnlLine.Earmarked := PurchHeader.Earmarked;
        GenJnlLine."Date Earmarked" := PurchHeader."Date Earmarked";
        GenJnlLine."Amount Earmarked" := PurchHeader."Amount Earmarked";
        GenJnlLine."Original PO Number" := PurchHeader."No.";
        GenJnlLine.VAT := InvoicePostBuffer.VAT;
        GenJnlLine."TDS Code" := InvoicePostBuffer."TDS Code";
        GenJnlLine."Retention Fee" := InvoicePostBuffer."Retention Fee";
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostVendorEntry', '', false, false)]
    local procedure OnBeforePostVendorEntry(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
        GenJnlLine."Original PO Number" := PurchHeader."No.";
    end;


    procedure CheckTDS(precPurchHeader: Record "Purchase Header")
    var
        grecPurchLine: Record "Purchase Line";
        grecPurchLine2: Record "Purchase Line";
        grecNewCategories: Record "New Categories";
        gintCount: Integer;
        gintCount2: Integer;
    begin
        grecPurchLine.Reset();
        grecPurchLine.SetRange("Document No.", precPurchHeader."No.");
        grecPurchLine.SetFilter("TDS Code", '<>%1', '');
        gintCount := grecPurchLine.Count;

        grecPurchLine2.Reset();
        grecPurchLine2.SetRange("Document No.", precPurchHeader."No.");
        grecPurchLine2.SetRange(TDS, true);
        gintCount2 := grecPurchLine2.Count;

        if gintCount <> gintCount2 then
            Error('TDS has not been calculated.');
    end;


    var
        Selection: Integer;
        UserSetup: Record "User Setup";
        TextReceive: Label '&Receive';
        TextInvoice: Label '&Invoice';
        TextReceiveInvoice: Label 'Receive &and Invoice';
        ReceiveInvoiceQst: Label '&Receive,&Invoice,Receive &and Invoice';
        ReleasePurchaseDocCU: Codeunit "Release Purchase Document";
        PurchaseLine: Record "Purchase Line";
        GLSetup: Record "General Ledger Setup";
}