report 50062 "Statement of Income Finance"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Report\Layout\StatementofIncome.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = sorting("Vendor No.", "Posting Date", "Currency Code") where("Document Type" = filter(Payment));
            column(gdateStartDate; format(gdateStartDate)) { }
            column(gdateEndDate; format(gdateEndDate)) { }

            column(CompanyName; grecCompanyInfo.Name) { }
            column(CompanyBRN; grecCompanyInfo.BRN) { }

            column(gtextNID; gtextNID) { }
            column(gtextVendorName; gtextVendorName) { }
            column(gtextVendorAddress; gtextVendorAddress) { }
            column(grecVendor; grecVendor.BRN) { }

            column(gdecEmolument1; gdecEmolument[1]) { }
            column(gdecPAYEAmt1; gdecPAYEAmt[1]) { }

            column(gdecEmolument2; gdecEmolument[2]) { }
            column(gdecPAYEAmt2; gdecPAYEAmt[2]) { }

            column(gdecEmolument3; gdecEmolument[3]) { }
            column(gdecPAYEAmt3; gdecPAYEAmt[3]) { }

            column(gdecEmolument4; gdecEmolument[4]) { }
            column(gdecPAYEAmt4; gdecPAYEAmt[4]) { }

            column(gdecEmolument5; gdecEmolument[5]) { }
            column(gdecPAYEAmt5; gdecPAYEAmt[5]) { }

            column(gdecEmolument6; gdecEmolument[6]) { }
            column(gdecPAYEAmt6; gdecPAYEAmt[6]) { }

            column(gdecEmolument7; gdecEmolument[7]) { }
            column(gdecPAYEAmt7; gdecPAYEAmt[7]) { }

            column(gdecEmolument8; gdecEmolument[8]) { }
            column(gdecPAYEAmt8; gdecPAYEAmt[8]) { }

            column(gdecEmolument9; gdecEmolument[9]) { }
            column(gdecPAYEAmt9; gdecPAYEAmt[9]) { }

            column(gdecEmolument10; gdecEmolument[10]) { }
            column(gdecPAYEAmt10; gdecPAYEAmt[10]) { }

            column(Sign; grecPurchPayableSetup."Sign for Emoluments") { }

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", gdateStartDate, gdateEndDate);
                if gcodeVendor <> '' then
                    SetRange("Vendor No.", gcodeVendor);
            end;

            trigger OnAfterGetRecord()
            begin
                if grecVendor2.get("Vendor No.") then begin
                    if grecVendor2."Vendor Category" <> 'TUTOR' then
                        CurrReport.Skip();
                end;

                if gtextVendor <> "Vendor No." then begin
                    clear(gtextNID);
                    clear(gtextVendorName);
                    Clear(gtextVendorAddress);
                    if grecVendor.get("Vendor No.") then begin
                        gtextNID := grecVendor.NID;
                        gtextVendorName := grecVendor.Name;
                        gtextVendorAddress := grecVendor.Address;
                    end;


                    Clear(gdecEmolument);
                    Clear(gdecPAYEAmt);
                    grecVendLedgerEntry.Reset();
                    grecVendLedgerEntry.SetCurrentKey("Entry No.");
                    grecVendLedgerEntry.SetRange("Document Type", grecVendLedgerEntry."Document Type"::Payment);
                    grecVendLedgerEntry.SetRange("Posting Date", gdateStartDate, gdateEndDate);
                    grecVendLedgerEntry.SetRange("Vendor No.", "Vendor No.");
                    if grecVendLedgerEntry.Findset then begin
                        repeat
                            Case grecVendLedgerEntry."Payment Type" of
                                'PAY0001':
                                    begin
                                        grecVendLedgerEntry.CalcFields("Original Amt. (LCY)");
                                        gdecEmolument[1] += grecVendLedgerEntry."Original Amt. (LCY)";

                                        /* grecGLEntry.Reset();
                                        grecGLEntry.SetCurrentKey("Entry No.");
                                        grecGLEntry.SetRange("Bal. Account Type", grecGLEntry."Bal. Account Type"::"Bank Account");
                                        grecGLEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecGLEntry.SetRange("Payment Journal No.", grecVendLedgerEntry."Payment Journal No.");
                                        grecGLEntry.SetRange("Payment Type", 'PAY0001');
                                        grecGLEntry.SetRange(VAT, true);
                                        if grecGLEntry.FindSet then begin
                                            repeat
                                                gdecPAYEAmt[1] += grecGLEntry.Amount;
                                            until grecGLEntry.Next = 0;
                                        end; */

                                        grecDetailedVendLedgerEntry.Reset();
                                        grecDetailedVendLedgerEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecDetailedVendLedgerEntry.SetRange("Entry Type", grecDetailedVendLedgerEntry."Entry Type"::Application);
                                        grecDetailedVendLedgerEntry.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Payment);
                                        if grecDetailedVendLedgerEntry.FindFirst() then begin
                                            grecDetailedVendLedgerEntry2.Reset();
                                            grecDetailedVendLedgerEntry2.SetRange("Applied Vend. Ledger Entry No.", grecDetailedVendLedgerEntry."Applied Vend. Ledger Entry No.");
                                            grecDetailedVendLedgerEntry2.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Invoice);
                                            if grecDetailedVendLedgerEntry2.FindFirst() then begin
                                                repeat
                                                    grecVendLedgerEntry2.Reset();
                                                    //grecVendLedgerEntry2.SetRange("Payment Type", 'PAY0001');
                                                    grecVendLedgerEntry2.SetRange("Entry No.", grecDetailedVendLedgerEntry2."Vendor Ledger Entry No.");
                                                    if grecVendLedgerEntry2.FindFirst then begin
                                                        repeat
                                                            grecPurchInvLine.Reset();
                                                            grecPurchInvLine.SetRange("Document No.", grecVendLedgerEntry2."Document No.");
                                                            grecPurchInvLine.SetRange(PAYE, true);
                                                            if grecPurchInvLine.FindFirst() then
                                                                gdecPAYEAmt[1] += grecPurchInvLine."Line Amount";
                                                        until grecVendLedgerEntry2.Next = 0;
                                                    end;
                                                until grecDetailedVendLedgerEntry2.Next = 0;
                                            end;
                                        end;

                                    end;

                                'PAY0002':
                                    begin
                                        grecVendLedgerEntry.CalcFields("Original Amt. (LCY)");
                                        gdecEmolument[2] += grecVendLedgerEntry."Original Amt. (LCY)";

                                        /* grecGLEntry.Reset();
                                        grecGLEntry.SetCurrentKey("Entry No.");
                                        grecGLEntry.SetRange("Bal. Account Type", grecGLEntry."Bal. Account Type"::"Bank Account");
                                        grecGLEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecGLEntry.SetRange("Payment Journal No.", grecVendLedgerEntry."Payment Journal No.");
                                        grecGLEntry.SetRange("Payment Type", 'PAY0002');
                                        grecGLEntry.SetRange(VAT, true);
                                        if grecGLEntry.FindSet then begin
                                            repeat
                                                gdecPAYEAmt[2] += grecGLEntry.Amount;
                                            until grecGLEntry.Next = 0;
                                        end; */

                                        grecDetailedVendLedgerEntry.Reset();
                                        grecDetailedVendLedgerEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecDetailedVendLedgerEntry.SetRange("Entry Type", grecDetailedVendLedgerEntry."Entry Type"::Application);
                                        grecDetailedVendLedgerEntry.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Payment);
                                        if grecDetailedVendLedgerEntry.FindFirst() then begin
                                            grecDetailedVendLedgerEntry2.Reset();
                                            grecDetailedVendLedgerEntry2.SetRange("Applied Vend. Ledger Entry No.", grecDetailedVendLedgerEntry."Applied Vend. Ledger Entry No.");
                                            grecDetailedVendLedgerEntry2.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Invoice);
                                            if grecDetailedVendLedgerEntry2.FindFirst() then begin
                                                repeat
                                                    grecVendLedgerEntry2.Reset();
                                                    //grecVendLedgerEntry2.SetRange("Payment Type", 'PAY0002');
                                                    grecVendLedgerEntry2.SetRange("Entry No.", grecDetailedVendLedgerEntry2."Vendor Ledger Entry No.");
                                                    if grecVendLedgerEntry2.FindFirst then begin
                                                        repeat
                                                            grecPurchInvLine.Reset();
                                                            grecPurchInvLine.SetRange("Document No.", grecVendLedgerEntry2."Document No.");
                                                            grecPurchInvLine.SetRange(PAYE, true);
                                                            if grecPurchInvLine.FindFirst() then
                                                                gdecPAYEAmt[2] += grecPurchInvLine."Line Amount";
                                                        until grecVendLedgerEntry2.Next = 0;
                                                    end;
                                                until grecDetailedVendLedgerEntry2.Next = 0;
                                            end;
                                        end;

                                    end;

                                'PAY0003':
                                    begin
                                        grecVendLedgerEntry.CalcFields("Original Amt. (LCY)");
                                        gdecEmolument[3] += grecVendLedgerEntry."Original Amt. (LCY)";

                                        /* grecGLEntry.Reset();
                                        grecGLEntry.SetCurrentKey("Entry No.");
                                        grecGLEntry.SetRange("Bal. Account Type", grecGLEntry."Bal. Account Type"::"Bank Account");
                                        grecGLEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecGLEntry.SetRange("Payment Journal No.", grecVendLedgerEntry."Payment Journal No.");
                                        grecGLEntry.SetRange("Payment Type", 'PAY0003');
                                        grecGLEntry.SetRange(VAT, true);
                                        if grecGLEntry.FindSet then begin
                                            repeat
                                                gdecPAYEAmt[3] += grecGLEntry.Amount;
                                            until grecGLEntry.Next = 0;
                                        end; */

                                        grecDetailedVendLedgerEntry.Reset();
                                        grecDetailedVendLedgerEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecDetailedVendLedgerEntry.SetRange("Entry Type", grecDetailedVendLedgerEntry."Entry Type"::Application);
                                        grecDetailedVendLedgerEntry.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Payment);
                                        if grecDetailedVendLedgerEntry.FindFirst() then begin
                                            grecDetailedVendLedgerEntry2.Reset();
                                            grecDetailedVendLedgerEntry2.SetRange("Applied Vend. Ledger Entry No.", grecDetailedVendLedgerEntry."Applied Vend. Ledger Entry No.");
                                            grecDetailedVendLedgerEntry2.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Invoice);
                                            if grecDetailedVendLedgerEntry2.FindFirst() then begin
                                                repeat
                                                    grecVendLedgerEntry2.Reset();
                                                    //grecVendLedgerEntry2.SetRange("Payment Type", 'PAY0003');
                                                    grecVendLedgerEntry2.SetRange("Entry No.", grecDetailedVendLedgerEntry2."Vendor Ledger Entry No.");
                                                    if grecVendLedgerEntry2.FindFirst then begin
                                                        repeat
                                                            grecPurchInvLine.Reset();
                                                            grecPurchInvLine.SetRange("Document No.", grecVendLedgerEntry2."Document No.");
                                                            grecPurchInvLine.SetRange(PAYE, true);
                                                            if grecPurchInvLine.FindFirst() then
                                                                gdecPAYEAmt[3] += grecPurchInvLine."Line Amount";
                                                        until grecVendLedgerEntry2.Next = 0;
                                                    end;
                                                until grecDetailedVendLedgerEntry2.Next = 0;
                                            end;
                                        end;

                                    end;

                                'PAY0004':
                                    begin
                                        grecVendLedgerEntry.CalcFields("Original Amt. (LCY)");
                                        gdecEmolument[4] += grecVendLedgerEntry."Original Amt. (LCY)";

                                        /* grecGLEntry.Reset();
                                        grecGLEntry.SetCurrentKey("Entry No.");
                                        grecGLEntry.SetRange("Bal. Account Type", grecGLEntry."Bal. Account Type"::"Bank Account");
                                        grecGLEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecGLEntry.SetRange("Payment Journal No.", grecVendLedgerEntry."Payment Journal No.");
                                        grecGLEntry.SetRange("Payment Type", 'PAY0004');
                                        grecGLEntry.SetRange(VAT, true);
                                        if grecGLEntry.FindSet then begin
                                            repeat
                                                gdecPAYEAmt[4] += grecGLEntry.Amount;
                                            until grecGLEntry.Next = 0;
                                        end; */


                                        grecDetailedVendLedgerEntry.Reset();
                                        grecDetailedVendLedgerEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecDetailedVendLedgerEntry.SetRange("Entry Type", grecDetailedVendLedgerEntry."Entry Type"::Application);
                                        grecDetailedVendLedgerEntry.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Payment);
                                        if grecDetailedVendLedgerEntry.FindFirst() then begin
                                            grecDetailedVendLedgerEntry2.Reset();
                                            grecDetailedVendLedgerEntry2.SetRange("Applied Vend. Ledger Entry No.", grecDetailedVendLedgerEntry."Applied Vend. Ledger Entry No.");
                                            grecDetailedVendLedgerEntry2.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Invoice);
                                            if grecDetailedVendLedgerEntry2.FindFirst() then begin
                                                repeat
                                                    grecVendLedgerEntry2.Reset();
                                                    //grecVendLedgerEntry2.SetRange("Payment Type", 'PAY0004');
                                                    grecVendLedgerEntry2.SetRange("Entry No.", grecDetailedVendLedgerEntry2."Vendor Ledger Entry No.");
                                                    if grecVendLedgerEntry2.FindFirst then begin
                                                        repeat
                                                            grecPurchInvLine.Reset();
                                                            grecPurchInvLine.SetRange("Document No.", grecVendLedgerEntry2."Document No.");
                                                            grecPurchInvLine.SetRange(PAYE, true);
                                                            if grecPurchInvLine.FindFirst() then
                                                                gdecPAYEAmt[4] += grecPurchInvLine."Line Amount";
                                                        until grecVendLedgerEntry2.Next = 0;
                                                    end;
                                                until grecDetailedVendLedgerEntry2.Next = 0;
                                            end;
                                        end;

                                    end;

                                'PAY0005':
                                    begin
                                        grecVendLedgerEntry.CalcFields("Original Amt. (LCY)");
                                        gdecEmolument[5] += grecVendLedgerEntry."Original Amt. (LCY)";

                                        /* grecGLEntry.Reset();
                                        grecGLEntry.SetCurrentKey("Entry No.");
                                        grecGLEntry.SetRange("Bal. Account Type", grecGLEntry."Bal. Account Type"::"Bank Account");
                                        grecGLEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecGLEntry.SetRange("Payment Journal No.", grecVendLedgerEntry."Payment Journal No.");
                                        grecGLEntry.SetRange("Payment Type", 'PAY0005');
                                        grecGLEntry.SetRange(VAT, true);
                                        if grecGLEntry.FindSet then begin
                                            repeat
                                                gdecPAYEAmt[5] += grecGLEntry.Amount;
                                            until grecGLEntry.Next = 0;
                                        end; */


                                        grecDetailedVendLedgerEntry.Reset();
                                        grecDetailedVendLedgerEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecDetailedVendLedgerEntry.SetRange("Entry Type", grecDetailedVendLedgerEntry."Entry Type"::Application);
                                        grecDetailedVendLedgerEntry.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Payment);
                                        if grecDetailedVendLedgerEntry.FindFirst() then begin
                                            grecDetailedVendLedgerEntry2.Reset();
                                            grecDetailedVendLedgerEntry2.SetRange("Applied Vend. Ledger Entry No.", grecDetailedVendLedgerEntry."Applied Vend. Ledger Entry No.");
                                            grecDetailedVendLedgerEntry2.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Invoice);
                                            if grecDetailedVendLedgerEntry2.FindFirst() then begin
                                                repeat
                                                    grecVendLedgerEntry2.Reset();
                                                    //grecVendLedgerEntry2.SetRange("Payment Type", 'PAY0005');
                                                    grecVendLedgerEntry2.SetRange("Entry No.", grecDetailedVendLedgerEntry2."Vendor Ledger Entry No.");
                                                    if grecVendLedgerEntry2.FindFirst then begin
                                                        repeat
                                                            grecPurchInvLine.Reset();
                                                            grecPurchInvLine.SetRange("Document No.", grecVendLedgerEntry2."Document No.");
                                                            grecPurchInvLine.SetRange(PAYE, true);
                                                            if grecPurchInvLine.FindFirst() then
                                                                gdecPAYEAmt[5] += grecPurchInvLine."Line Amount";
                                                        until grecVendLedgerEntry2.Next = 0;
                                                    end;
                                                until grecDetailedVendLedgerEntry2.Next = 0;
                                            end;
                                        end;

                                    end;

                                'PAY0006':
                                    begin
                                        grecVendLedgerEntry.CalcFields("Original Amt. (LCY)");
                                        gdecEmolument[6] += grecVendLedgerEntry."Original Amt. (LCY)";

                                        /* grecGLEntry.Reset();
                                        grecGLEntry.SetCurrentKey("Entry No.");
                                        grecGLEntry.SetRange("Bal. Account Type", grecGLEntry."Bal. Account Type"::"Bank Account");
                                        grecGLEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecGLEntry.SetRange("Payment Journal No.", grecVendLedgerEntry."Payment Journal No.");
                                        grecGLEntry.SetRange("Payment Type", 'PAY0006');
                                        grecGLEntry.SetRange(VAT, true);
                                        if grecGLEntry.FindSet then begin
                                            repeat
                                                gdecPAYEAmt[6] += grecGLEntry.Amount;
                                            until grecGLEntry.Next = 0;
                                        end; */


                                        grecDetailedVendLedgerEntry.Reset();
                                        grecDetailedVendLedgerEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecDetailedVendLedgerEntry.SetRange("Entry Type", grecDetailedVendLedgerEntry."Entry Type"::Application);
                                        grecDetailedVendLedgerEntry.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Payment);
                                        if grecDetailedVendLedgerEntry.FindFirst() then begin
                                            grecDetailedVendLedgerEntry2.Reset();
                                            grecDetailedVendLedgerEntry2.SetRange("Applied Vend. Ledger Entry No.", grecDetailedVendLedgerEntry."Applied Vend. Ledger Entry No.");
                                            grecDetailedVendLedgerEntry2.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Invoice);
                                            if grecDetailedVendLedgerEntry2.FindFirst() then begin
                                                repeat
                                                    grecVendLedgerEntry2.Reset();
                                                    //grecVendLedgerEntry2.SetRange("Payment Type", 'PAY0006');
                                                    grecVendLedgerEntry2.SetRange("Entry No.", grecDetailedVendLedgerEntry2."Vendor Ledger Entry No.");
                                                    if grecVendLedgerEntry2.FindFirst then begin
                                                        repeat
                                                            grecPurchInvLine.Reset();
                                                            grecPurchInvLine.SetRange("Document No.", grecVendLedgerEntry2."Document No.");
                                                            grecPurchInvLine.SetRange(PAYE, true);
                                                            if grecPurchInvLine.FindFirst() then
                                                                gdecPAYEAmt[6] += grecPurchInvLine."Line Amount";
                                                        until grecVendLedgerEntry2.Next = 0;
                                                    end;
                                                until grecDetailedVendLedgerEntry2.Next = 0;
                                            end;
                                        end;

                                    end;

                                'PAY0007':
                                    begin
                                        grecVendLedgerEntry.CalcFields("Original Amt. (LCY)");
                                        gdecEmolument[7] += grecVendLedgerEntry."Original Amt. (LCY)";

                                        /* grecGLEntry.Reset();
                                        grecGLEntry.SetCurrentKey("Entry No.");
                                        grecGLEntry.SetRange("Bal. Account Type", grecGLEntry."Bal. Account Type"::"Bank Account");
                                        grecGLEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecGLEntry.SetRange("Payment Journal No.", grecVendLedgerEntry."Payment Journal No.");
                                        grecGLEntry.SetRange("Payment Type", 'PAY0007');
                                        grecGLEntry.SetRange(VAT, true);
                                        if grecGLEntry.FindSet then begin
                                            repeat
                                                gdecPAYEAmt[7] += grecGLEntry.Amount;
                                            until grecGLEntry.Next = 0;
                                        end; */


                                        grecDetailedVendLedgerEntry.Reset();
                                        grecDetailedVendLedgerEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecDetailedVendLedgerEntry.SetRange("Entry Type", grecDetailedVendLedgerEntry."Entry Type"::Application);
                                        grecDetailedVendLedgerEntry.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Payment);
                                        if grecDetailedVendLedgerEntry.FindFirst() then begin
                                            grecDetailedVendLedgerEntry2.Reset();
                                            grecDetailedVendLedgerEntry2.SetRange("Applied Vend. Ledger Entry No.", grecDetailedVendLedgerEntry."Applied Vend. Ledger Entry No.");
                                            grecDetailedVendLedgerEntry2.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Invoice);
                                            if grecDetailedVendLedgerEntry2.FindFirst() then begin
                                                repeat
                                                    grecVendLedgerEntry2.Reset();
                                                    //grecVendLedgerEntry2.SetRange("Payment Type", 'PAY0007');
                                                    grecVendLedgerEntry2.SetRange("Entry No.", grecDetailedVendLedgerEntry2."Vendor Ledger Entry No.");
                                                    if grecVendLedgerEntry2.FindFirst then begin
                                                        repeat
                                                            grecPurchInvLine.Reset();
                                                            grecPurchInvLine.SetRange("Document No.", grecVendLedgerEntry2."Document No.");
                                                            grecPurchInvLine.SetRange(PAYE, true);
                                                            if grecPurchInvLine.FindFirst() then
                                                                gdecPAYEAmt[7] += grecPurchInvLine."Line Amount";
                                                        until grecVendLedgerEntry2.Next = 0;
                                                    end;
                                                until grecDetailedVendLedgerEntry2.Next = 0;
                                            end;
                                        end;

                                    end;

                                'PAY0008':
                                    begin
                                        grecVendLedgerEntry.CalcFields("Original Amt. (LCY)");
                                        gdecEmolument[8] += grecVendLedgerEntry."Original Amt. (LCY)";

                                        /* grecGLEntry.Reset();
                                        grecGLEntry.SetCurrentKey("Entry No.");
                                        grecGLEntry.SetRange("Bal. Account Type", grecGLEntry."Bal. Account Type"::"Bank Account");
                                        grecGLEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecGLEntry.SetRange("Payment Journal No.", grecVendLedgerEntry."Payment Journal No.");
                                        grecGLEntry.SetRange("Payment Type", 'PAY0008');
                                        grecGLEntry.SetRange(VAT, true);
                                        if grecGLEntry.FindSet then begin
                                            repeat
                                                gdecPAYEAmt[8] += grecGLEntry.Amount;
                                            until grecGLEntry.Next = 0;
                                        end; */


                                        grecDetailedVendLedgerEntry.Reset();
                                        grecDetailedVendLedgerEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecDetailedVendLedgerEntry.SetRange("Entry Type", grecDetailedVendLedgerEntry."Entry Type"::Application);
                                        grecDetailedVendLedgerEntry.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Payment);
                                        if grecDetailedVendLedgerEntry.FindFirst() then begin
                                            grecDetailedVendLedgerEntry2.Reset();
                                            grecDetailedVendLedgerEntry2.SetRange("Applied Vend. Ledger Entry No.", grecDetailedVendLedgerEntry."Applied Vend. Ledger Entry No.");
                                            grecDetailedVendLedgerEntry2.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Invoice);
                                            if grecDetailedVendLedgerEntry2.FindFirst() then begin
                                                repeat
                                                    grecVendLedgerEntry2.Reset();
                                                    //grecVendLedgerEntry2.SetRange("Payment Type", 'PAY0008');
                                                    grecVendLedgerEntry2.SetRange("Entry No.", grecDetailedVendLedgerEntry2."Vendor Ledger Entry No.");
                                                    if grecVendLedgerEntry2.FindFirst then begin
                                                        repeat
                                                            grecPurchInvLine.Reset();
                                                            grecPurchInvLine.SetRange("Document No.", grecVendLedgerEntry2."Document No.");
                                                            grecPurchInvLine.SetRange(PAYE, true);
                                                            if grecPurchInvLine.FindFirst() then
                                                                gdecPAYEAmt[8] += grecPurchInvLine."Line Amount";
                                                        until grecVendLedgerEntry2.Next = 0;
                                                    end;
                                                until grecDetailedVendLedgerEntry2.Next = 0;
                                            end;
                                        end;

                                    end;

                                'PAY0009':
                                    begin
                                        grecVendLedgerEntry.CalcFields("Original Amt. (LCY)");
                                        gdecEmolument[9] += grecVendLedgerEntry."Original Amt. (LCY)";

                                        /* grecGLEntry.Reset();
                                        grecGLEntry.SetCurrentKey("Entry No.");
                                        grecGLEntry.SetRange("Bal. Account Type", grecGLEntry."Bal. Account Type"::"Bank Account");
                                        grecGLEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecGLEntry.SetRange("Payment Journal No.", grecVendLedgerEntry."Payment Journal No.");
                                        grecGLEntry.SetRange("Payment Type", 'PAY0009');
                                        grecGLEntry.SetRange(VAT, true);
                                        if grecGLEntry.FindSet then begin
                                            repeat
                                                gdecPAYEAmt[9] += grecGLEntry.Amount;
                                            until grecGLEntry.Next = 0;
                                        end; */


                                        grecDetailedVendLedgerEntry.Reset();
                                        grecDetailedVendLedgerEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecDetailedVendLedgerEntry.SetRange("Entry Type", grecDetailedVendLedgerEntry."Entry Type"::Application);
                                        grecDetailedVendLedgerEntry.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Payment);
                                        if grecDetailedVendLedgerEntry.FindFirst() then begin
                                            grecDetailedVendLedgerEntry2.Reset();
                                            grecDetailedVendLedgerEntry2.SetRange("Applied Vend. Ledger Entry No.", grecDetailedVendLedgerEntry."Applied Vend. Ledger Entry No.");
                                            grecDetailedVendLedgerEntry2.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Invoice);
                                            if grecDetailedVendLedgerEntry2.FindFirst() then begin
                                                repeat
                                                    grecVendLedgerEntry2.Reset();
                                                    //grecVendLedgerEntry2.SetRange("Payment Type", 'PAY0009');
                                                    grecVendLedgerEntry2.SetRange("Entry No.", grecDetailedVendLedgerEntry2."Vendor Ledger Entry No.");
                                                    if grecVendLedgerEntry2.FindFirst then begin
                                                        repeat
                                                            grecPurchInvLine.Reset();
                                                            grecPurchInvLine.SetRange("Document No.", grecVendLedgerEntry2."Document No.");
                                                            grecPurchInvLine.SetRange(PAYE, true);
                                                            if grecPurchInvLine.FindFirst() then
                                                                gdecPAYEAmt[9] += grecPurchInvLine."Line Amount";
                                                        until grecVendLedgerEntry2.Next = 0;
                                                    end;
                                                until grecDetailedVendLedgerEntry2.Next = 0;
                                            end;
                                        end;

                                    end;

                                'PAY0010':
                                    begin
                                        grecVendLedgerEntry.CalcFields("Original Amt. (LCY)");
                                        gdecEmolument[10] += grecVendLedgerEntry."Original Amt. (LCY)";

                                        /* grecGLEntry.Reset();
                                        grecGLEntry.SetCurrentKey("Entry No.");
                                        grecGLEntry.SetRange("Bal. Account Type", grecGLEntry."Bal. Account Type"::"Bank Account");
                                        grecGLEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecGLEntry.SetRange("Payment Journal No.", grecVendLedgerEntry."Payment Journal No.");
                                        grecGLEntry.SetRange("Payment Type", 'PAY0010');
                                        grecGLEntry.SetRange(VAT, true);
                                        if grecGLEntry.FindSet then begin
                                            repeat
                                                gdecPAYEAmt[10] += grecGLEntry.Amount;
                                            until grecGLEntry.Next = 0;
                                        end; */


                                        grecDetailedVendLedgerEntry.Reset();
                                        grecDetailedVendLedgerEntry.SetRange("Document No.", grecVendLedgerEntry."Document No.");
                                        grecDetailedVendLedgerEntry.SetRange("Entry Type", grecDetailedVendLedgerEntry."Entry Type"::Application);
                                        grecDetailedVendLedgerEntry.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Payment);
                                        if grecDetailedVendLedgerEntry.FindFirst() then begin
                                            grecDetailedVendLedgerEntry2.Reset();
                                            grecDetailedVendLedgerEntry2.SetRange("Applied Vend. Ledger Entry No.", grecDetailedVendLedgerEntry."Applied Vend. Ledger Entry No.");
                                            grecDetailedVendLedgerEntry2.SetRange("Initial Document Type", grecDetailedVendLedgerEntry."Initial Document Type"::Invoice);
                                            if grecDetailedVendLedgerEntry2.FindFirst() then begin
                                                repeat
                                                    grecVendLedgerEntry2.Reset();
                                                    //grecVendLedgerEntry2.SetRange("Payment Type", 'PAY0010');
                                                    grecVendLedgerEntry2.SetRange("Entry No.", grecDetailedVendLedgerEntry2."Vendor Ledger Entry No.");
                                                    if grecVendLedgerEntry2.FindFirst then begin
                                                        repeat
                                                            grecPurchInvLine.Reset();
                                                            grecPurchInvLine.SetRange("Document No.", grecVendLedgerEntry2."Document No.");
                                                            grecPurchInvLine.SetRange(PAYE, true);
                                                            if grecPurchInvLine.FindFirst() then
                                                                gdecPAYEAmt[10] += grecPurchInvLine."Line Amount";
                                                        until grecVendLedgerEntry2.Next = 0;
                                                    end;
                                                until grecDetailedVendLedgerEntry2.Next = 0;
                                            end;
                                        end;

                                    end;
                            End;
                        until grecVendLedgerEntry.Next = 0;
                    end;

                    gtextVendor := "Vendor No.";
                end else
                    CurrReport.Skip();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Date Filter")
                {
                    field("Start Date"; gdateStartDate) { ApplicationArea = All; }
                    field("End Date"; gdateEndDate) { ApplicationArea = All; }
                    field("Vendor No."; gcodeVendor)
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            Clear(gpageVendor);
                            grecVendor3.Reset();
                            grecVendor3.SetRange("Vendor Category", 'TUTOR');
                            if grecVendor3.FindFirst() then begin
                                gpageVendor.SetRecord(grecVendor3);
                                gpageVendor.SetTableView(grecVendor3);
                                gpageVendor.LookupMode(true);
                                if gpageVendor.RunModal() = Action::LookupOK then begin
                                    gpageVendor.GetRecord(grecVendor3);
                                    gcodeVendor := grecVendor3."No.";
                                end;
                            end;
                        end;
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if (gdateStartDate = 0D) or (gdateEndDate = 0D) then
            Error('Both dates should be filled in.');

        if gdateStartDate > gdateEndDate then
            Error('Start Date cannot be greater than End Date.');

        grecCompanyInfo.get;
        grecPurchPayableSetup.get;
    end;

    var
        gtextVendor: Text;
        gtextVendorAddress: Text;
        gtextNID: text;
        grecCompanyInfo: Record "Company Information";
        gdateStartDate: Date;
        gdateEndDate: Date;
        grecVendor: Record Vendor;
        gtextVendorName: Text;
        gtextVendor2: Text;
        grecVendLedgerEntry: Record "Vendor Ledger Entry";
        gdecEmolument: array[10] of Decimal;
        grecGLEntry: Record "G/L Entry";
        gdecPAYEAmt: array[10] of Decimal;
        grecPurchPayableSetup: Record "Purchases & Payables Setup";
        grecVendLedgerEntry2: Record "Vendor Ledger Entry";
        grecDetailedVendLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        grecDetailedVendLedgerEntry2: Record "Detailed Vendor Ledg. Entry";
        grecPurchInvLine: Record 123;
        grecVendor2: Record Vendor;
        gcodeVendor: Code[20];
        grecVendor3: Record Vendor;
        gpageVendor: Page "Vendor List";
}