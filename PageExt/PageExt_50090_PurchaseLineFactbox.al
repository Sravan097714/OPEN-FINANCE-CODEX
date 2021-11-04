pageextension 50090 PurchaseLineFactExt extends "Purchase Line FactBox"
{
    layout
    {
        addlast(Content)
        {
            field("Remaining Budget (G/L Account)"; gdecRemainingBudget) { }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Clear(PurchAmountDr);
        Clear(PurchAmountCr);
        IF Type = Type::"G/L Account" then begin
            PurchaseLine.RESET;
            PurchaseLine.SETFILTER("Document Type", '%1|%2|%3', PurchaseLine."Document Type"::"Credit Memo", PurchaseLine."Document Type"::Invoice, PurchaseLine."Document Type"::Order);
            PurchaseLine.SETRANGE(Type, PurchaseLine.Type::"G/L Account");
            PurchaseLine.SETRANGE("No.", Rec."No.");
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
            PurchaseLine.SETFILTER("Document Type", '%1|%2|%3', PurchaseLine."Document Type"::"Credit Memo", PurchaseLine."Document Type"::Invoice, PurchaseLine."Document Type"::Order);
            PurchaseLine.SETRANGE(Type, PurchaseLine.Type::"Fixed Asset");
            PurchaseLine.SETRANGE("FA Aquisition", Rec."No.");
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
            PurchaseLine.SETFILTER("Document Type", '%1|%2|%3', PurchaseLine."Document Type"::"Credit Memo", PurchaseLine."Document Type"::Invoice, PurchaseLine."Document Type"::Order);
            PurchaseLine.SETRANGE(Type, PurchaseLine.Type::"Fixed Asset");
            PurchaseLine.SETRANGE("FA Aquisition 2", Rec."No.");
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


        IF Type = Type::"Fixed Asset" then begin
            PurchaseLine.RESET;
            PurchaseLine.SETFILTER("Document Type", '%1|%2|%3', PurchaseLine."Document Type"::"Credit Memo", PurchaseLine."Document Type"::Invoice, PurchaseLine."Document Type"::Order);
            PurchaseLine.SETRANGE(Type, Type::"G/L Account");
            PurchaseLine.SETFILTER("No.", '%1|%2', "FA Aquisition", "FA Aquisition 2");
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
            PurchaseLine.SETFILTER("Document Type", '%1|%2|%3', PurchaseLine."Document Type"::"Credit Memo", PurchaseLine."Document Type"::Invoice, PurchaseLine."Document Type"::Order);
            PurchaseLine.SETRANGE(Type, Type::"Fixed Asset");
            PurchaseLine.SETFILTER("FA Aquisition", '%1|%2', Rec."FA Aquisition", Rec."FA Aquisition 2");
            PurchaseLine.SETFILTER("FA Aquisition 2", '%1|%2', Rec."FA Aquisition", Rec."FA Aquisition 2");
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
        IF Type = Type::"G/L Account" then begin
            grecBudgetByDepartment.Reset();
            grecBudgetByDepartment.SetRange("G/L Account No.", "No.");
            //grecBudgetByDepartment.SetRange(Department, "Shortcut Dimension 1 Code");
            if grecBudgetByDepartment.FindFirst() then begin
                gdecRemainingBudget := grecBudgetByDepartment."Remaining Amount" - PurchAmountDr;
                gdecRemainingBudget += PurchAmountCr;
            end;
        end;

        IF Type = Type::"Fixed Asset" then begin
            grecBudgetByDepartment.Reset();
            grecBudgetByDepartment.SetFilter("G/L Account No.", '%1|%2', "FA Aquisition", "FA Aquisition 2");
            //grecBudgetByDepartment.SetRange(Department, "Shortcut Dimension 1 Code");
            if grecBudgetByDepartment.FindFirst() then begin
                repeat
                    gdecRemainingBudget += grecBudgetByDepartment."Remaining Amount";
                until grecBudgetByDepartment.Next = 0;
                gdecRemainingBudget -= PurchAmountDr;
                gdecRemainingBudget += PurchAmountCr;
            end;
        end;
    end;



    trigger OnAfterGetCurrRecord()
    begin
        Clear(PurchAmountDr);
        Clear(PurchAmountCr);
        IF Type = Type::"G/L Account" then begin
            PurchaseLine.RESET;
            PurchaseLine.SETFILTER("Document Type", '%1|%2|%3', PurchaseLine."Document Type"::"Credit Memo", PurchaseLine."Document Type"::Invoice, PurchaseLine."Document Type"::Order);
            PurchaseLine.SETRANGE(Type, PurchaseLine.Type::"G/L Account");
            PurchaseLine.SETRANGE("No.", Rec."No.");
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
            PurchaseLine.SETFILTER("Document Type", '%1|%2|%3', PurchaseLine."Document Type"::"Credit Memo", PurchaseLine."Document Type"::Invoice, PurchaseLine."Document Type"::Order);
            PurchaseLine.SETRANGE(Type, PurchaseLine.Type::"Fixed Asset");
            PurchaseLine.SETRANGE("FA Aquisition", Rec."No.");
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
            PurchaseLine.SETFILTER("Document Type", '%1|%2|%3', PurchaseLine."Document Type"::"Credit Memo", PurchaseLine."Document Type"::Invoice, PurchaseLine."Document Type"::Order);
            PurchaseLine.SETRANGE(Type, PurchaseLine.Type::"Fixed Asset");
            PurchaseLine.SETRANGE("FA Aquisition 2", Rec."No.");
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


        IF Type = Type::"Fixed Asset" then begin
            PurchaseLine.RESET;
            PurchaseLine.SETFILTER("Document Type", '%1|%2|%3', PurchaseLine."Document Type"::"Credit Memo", PurchaseLine."Document Type"::Invoice, PurchaseLine."Document Type"::Order);
            PurchaseLine.SETRANGE(Type, Type::"G/L Account");
            PurchaseLine.SETFILTER("No.", '%1|%2', Rec."FA Aquisition", Rec."FA Aquisition 2");
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
            PurchaseLine.SETFILTER("Document Type", '%1|%2|%3', PurchaseLine."Document Type"::"Credit Memo", PurchaseLine."Document Type"::Invoice, PurchaseLine."Document Type"::Order);
            PurchaseLine.SETRANGE(Type, Type::"Fixed Asset");
            PurchaseLine.SETFILTER("FA Aquisition", '%1|%2', Rec."FA Aquisition", Rec."FA Aquisition 2");
            PurchaseLine.SETFILTER("FA Aquisition 2", '%1|%2', Rec."FA Aquisition", Rec."FA Aquisition 2");
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
        IF Type = Type::"G/L Account" then begin
            grecBudgetByDepartment.Reset();
            grecBudgetByDepartment.SetRange("G/L Account No.", "No.");
            //grecBudgetByDepartment.SetRange(Department, "Shortcut Dimension 1 Code");
            if grecBudgetByDepartment.FindFirst() then begin
                gdecRemainingBudget := grecBudgetByDepartment."Remaining Amount" - PurchAmountDr;
                gdecRemainingBudget += PurchAmountCr;
            end;
        end;

        IF Type = Type::"Fixed Asset" then begin
            grecBudgetByDepartment.Reset();
            grecBudgetByDepartment.SetFilter("G/L Account No.", '%1|%2', "FA Aquisition", "FA Aquisition 2");
            //grecBudgetByDepartment.SetRange(Department, "Shortcut Dimension 1 Code");
            if grecBudgetByDepartment.FindFirst() then begin
                repeat
                    gdecRemainingBudget += grecBudgetByDepartment."Remaining Amount";
                until grecBudgetByDepartment.Next = 0;
                gdecRemainingBudget -= PurchAmountDr;
                gdecRemainingBudget += PurchAmountCr;
            end;
        end;
    end;



    var
        PurchaseLine: Record 39;
        grecGLAccount: Record 15;
        PurchAmountDr: Decimal;
        PurchAmountCr: Decimal;
        gdecRemainingBudget: Decimal;
        grecPurchHdr: Record "Purchase Header";
        grecBudgetByDepartment: Record 50004;
}
