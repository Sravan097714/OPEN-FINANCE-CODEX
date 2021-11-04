codeunit 50017 CheckReleaseReopenOnPurchase
{

    [EventSubscriber(ObjectType::Codeunit, 415, 'OnBeforeManualReleasePurchaseDoc', '', false, false)]
    local procedure OnBeforeManualReleasePurchaseDoc(VAR PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean)
    var
        grecUserSetup: Record "User Setup";
        grecPurchaseLine: Record "Purchase Line";
        grecPurchLineCheckGL: Record "Purchase Line";
    begin
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin

            grecPurchLineCheckGL.Reset();
            grecPurchLineCheckGL.SetRange("Document No.", PurchaseHeader."No.");
            grecPurchLineCheckGL.SetFilter("Account Category", '<>%1', grecPurchLineCheckGL."Account Category"::" ");
            if grecPurchLineCheckGL.FindFirst() then begin
                repeat
                    if grecPurchLineCheckGL."G/L Account for Budget" = '' then
                        Error('Please earmark line no. %1.', grecPurchLineCheckGL."Line No.");
                until grecPurchLineCheckGL.Next = 0;
            end;


            /* grecPurchLineCheckGL.Reset();
            grecPurchLineCheckGL.SetRange("Document No.", PurchaseHeader."No.");
            if grecPurchLineCheckGL.FindSet then begin
                repeat
                    if grecPurchLineCheckGL."G/L Account for Budget" = '' then
                        Error('Please insert G/L Account for Earmarking on line no. %1.', grecPurchLineCheckGL."Line No.");
                until grecPurchLineCheckGL.Next = 0;
            end; */

            //grecUserSetup.Reset();
            //grecUserSetup.SetRange("User ID", UserId);
            //if grecUserSetup.FindFirst then begin
            //if grecUserSetup."Can released Purchase Order" then begin
            PurchaseHeader."Date Time Released" := CurrentDateTime();
            PurchaseHeader."Released By" := UserId();
            PurchaseHeader."Date Time Reopened" := 0DT;
            PurchaseHeader."Reopened By" := '';

            /* grecPurchaseLine.Reset();
            grecPurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
            //grecPurchaseLine.SetFilter(Type, '%1|%2', grecPurchaseLine.Type::"G/L Account", grecPurchaseLine.Type::"Fixed Asset");
            if grecPurchaseLine.FindFirst() then begin
                repeat
                    CheckBudget(PurchaseHeader, grecPurchaseLine);
                until grecPurchaseLine.Next() = 0;
            end; */

            //UpdateBudgetMinus(PurchaseHeader);
            //end else
            //error('You do not have access to release purchase orders.')
            //end else
            //error('You do not have access to release purchase orders.');
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, 415, 'OnBeforeManualReopenPurchaseDoc', '', false, false)]
    local procedure OnBeforeManualReopenPurchaseDoc(VAR PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean)
    var
        grecUserSetup: Record "User Setup";
    begin
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            //grecUserSetup.Reset();
            //grecUserSetup.SetRange("User ID", UserId);
            //if grecUserSetup.FindFirst then begin
            //if grecUserSetup."Can reopen Purchase Order" then begin
            if PurchaseHeader.Status = PurchaseHeader.Status::Released then begin
                PurchaseHeader."Date Time Released" := 0DT;
                PurchaseHeader."Released By" := '';
                PurchaseHeader."Date Time Reopened" := CurrentDateTime();
                PurchaseHeader."Reopened By" := UserId();
                //UpdateBudgetPlus(PurchaseHeader);
            end;
            //end else
            //error('You do not have access to reopen purchase orders.');
            //end else
            //error('You do not have access to reopen purchase orders.');
        end;
    end;


    procedure UpdateBudgetMinus(Rec: Record "Purchase Header")
    var
        grecPurchaseOrder: Record "Purchase Header";
        grecPurchaseLine: Record "Purchase Line";
        grecGLAccount: Record "G/L Account";
        grecBudgetByDepartment: Record Budget_By_Department;
    begin
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


    procedure UpdateBudgetPlus(Rec: Record "Purchase Header")
    var
        grecPurchaseOrder: Record "Purchase Header";
        grecPurchaseLine: Record "Purchase Line";
        grecGLAccount: Record "G/L Account";
        grecBudgetByDepartment: Record Budget_By_Department;
    begin
        If grecPurchaseOrder.get(Rec."Document Type", Rec."No.") then begin
            if not grecPurchaseOrder."Budget Updated" then begin
                grecPurchaseLine.reset;
                grecPurchaseLine.SetRange("Document No.", grecPurchaseOrder."No.");
                if grecPurchaseLine.findset then begin
                    repeat
                        grecBudgetByDepartment.Reset();
                        grecBudgetByDepartment.SetRange("G/L Account No.", grecPurchaseLine."G/L Account for Budget");
                        if grecBudgetByDepartment.FindFirst() then begin
                            grecBudgetByDepartment."Remaining Amount" += grecPurchaseLine.Amount;
                            grecBudgetByDepartment.Modify;
                        end;
                    until grecPurchaseLine.NEXT = 0;
                end;
                Rec."Budget Updated" := false;
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
        Clear(PurchAmount);
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::"Credit Memo", PurchaseLine."Document Type"::Invoice);
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


            if PurchAmountDr <> 0 then
                PurchAmountDr := Round(PurchAmountDr, 0.01, '>'); //Invoice

            if PurchAmountCr <> 0 then
                PurchAmountCr := Round(PurchAmountCr, 0.01, '>'); //CreditMemo

            clear(gdecRemainingBudget);
            grecBudgetByDepartment.Reset();
            grecBudgetByDepartment.SetRange("G/L Account No.", precPurchaseLine."G/L Account for Budget");
            //grecBudgetByDepartment.SetRange(Department, "Shortcut Dimension 1 Code");
            if grecBudgetByDepartment.FindFirst() then begin
                gdecRemainingBudget := grecBudgetByDepartment."Remaining Amount" - PurchAmountDr;
                gdecRemainingBudget += PurchAmountCr;
            end;

            PurchAmount := precPurchaseLine.Amount;

            IF PurchAmount > gdecRemainingBudget THEN
                Message(gtextBudgetError, precPurchaseLine.Type, precPurchaseLine."No.");
        END;
    end;


    var
        gCUPurchasePosting: Codeunit "Purchase Posting";

}