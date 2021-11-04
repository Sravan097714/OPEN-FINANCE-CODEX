report 50029 "Receipt & Payment"
{
    DefaultLayout = RDLC;
    Caption = 'MCCI Receipt and Payment Report';
    RDLCLayout = 'Report\Layout\ReceiptPayment.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = sorting("Entry No.");

            column(gdateStartDate; format(gdateStartDate)) { }
            column(gdateEndDate; format(gdateEndDate)) { }
            column(OpeningBalance; gdecOpeningBalance) { }
            column(NetChange; gdecNetChange) { }
            column(gdecClosingBalance; gdecClosingBalance) { }

            column(gdecReceiptAmtB; gdecOpeningAmt[1]) { }
            column(gdecReceiptAmtBB; gdecNetChangeAmt[1]) { }
            column(gdecReceiptAmtC; gdecOpeningAmt[2]) { }
            column(gdecReceiptAmtCC; gdecNetChangeAmt[2]) { }
            column(gdecReceiptAmtD; gdecOpeningAmt[3]) { }
            column(gdecReceiptAmtDD; gdecNetChangeAmt[3]) { }

            column(gdecReceiptAmtE1; gdecOpeningAmt[4]) { }
            column(gdecReceiptAmtEE1; gdecNetChangeAmt[4]) { }
            column(gdecReceiptAmtE2; gdecOpeningAmt[5]) { }
            column(gdecReceiptAmtEE2; gdecNetChangeAmt[5]) { }
            column(gdecReceiptAmtE3; gdecOpeningAmt[6]) { }
            column(gdecReceiptAmtEE3; gdecNetChangeAmt[6]) { }

            column(gdecReceiptAmtE4; gdecOpeningAmt[7]) { }
            column(gdecReceiptAmtEE4; gdecNetChangeAmt[7]) { }
            column(gdecReceiptAmtE5; gdecOpeningAmt[8]) { }
            column(gdecReceiptAmtEE5; gdecNetChangeAmt[8]) { }
            column(gdecReceiptAmtE6; gdecOpeningAmt[9]) { }
            column(gdecReceiptAmtEE6; gdecNetChangeAmt[9]) { }

            column(gdecReceiptAmtE7; gdecOpeningAmt[10]) { }
            column(gdecReceiptAmtEE7; gdecNetChangeAmt[10]) { }
            column(gdecReceiptAmtE8; gdecOpeningAmt[11]) { }
            column(gdecReceiptAmtEE8; gdecNetChangeAmt[11]) { }
            column(gdecReceiptAmtE9; gdecOpeningAmt[12]) { }
            column(gdecReceiptAmtEE9; gdecNetChangeAmt[12]) { }

            column(gdecReceiptAmtE10; gdecOpeningAmt[13]) { }
            column(gdecReceiptAmtEE10; gdecNetChangeAmt[13]) { }
            column(gdecReceiptAmtE11; gdecOpeningAmt[14]) { }
            column(gdecReceiptAmtEE11; gdecNetChangeAmt[14]) { }
            column(gdecReceiptAmtE12; gdecOpeningAmt[15]) { }
            column(gdecReceiptAmtEE12; gdecNetChangeAmt[15]) { }

            column(gdecReceiptAmtE13; gdecOpeningAmt[16]) { }
            column(gdecReceiptAmtEE13; gdecNetChangeAmt[16]) { }
            column(gdecReceiptAmtE14; gdecOpeningAmt[17]) { }
            column(gdecReceiptAmtEE14; gdecNetChangeAmt[17]) { }
            column(gdecReceiptAmtE15; gdecOpeningAmt[18]) { }
            column(gdecReceiptAmtEE15; gdecNetChangeAmt[18]) { }

            column(gdecReceiptAmtE16; gdecOpeningAmt[19]) { }
            column(gdecReceiptAmtEE16; gdecNetChangeAmt[19]) { }
            column(gdecReceiptAmtE17; gdecOpeningAmt[20]) { }
            column(gdecReceiptAmtEE17; gdecNetChangeAmt[20]) { }
            column(gdecReceiptAmtE18; gdecOpeningAmt[21]) { }
            column(gdecReceiptAmtEE18; gdecNetChangeAmt[21]) { }

            column(gdecReceiptAmtE19; gdecOpeningAmt[22]) { }
            column(gdecReceiptAmtEE19; gdecNetChangeAmt[22]) { }
            column(gdecReceiptAmtE20; gdecOpeningAmt[23]) { }
            column(gdecReceiptAmtEE20; gdecNetChangeAmt[23]) { }

            column(gdecReceiptAmtE21; gdecOpeningAmt[24]) { }
            column(gdecReceiptAmtEE21; gdecNetChangeAmt[24]) { }
            column(gdecReceiptAmtE22; gdecOpeningAmt[25]) { }
            column(gdecReceiptAmtEE22; gdecNetChangeAmt[25]) { }
            column(gdecReceiptAmtE23; gdecOpeningAmt[26]) { }
            column(gdecReceiptAmtEE23; gdecNetChangeAmt[26]) { }


            //Payemnt
            column(gdecPaymentAmtG; gdecOpeningAmt[27]) { }
            column(gdecPaymentAmtGG; gdecNetChangeAmt[27]) { }
            column(gdecPaymentAmtH; gdecOpeningAmt[28]) { }
            column(gdecPaymentAmtHH; gdecNetChangeAmt[28]) { }
            column(gdecPaymentAmtI; gdecOpeningAmt[29]) { }
            column(gdecPaymentAmtII; gdecNetChangeAmt[29]) { }
            column(gdecPaymentAmtJ; gdecOpeningAmt[30]) { }
            column(gdecPaymentAmtJJ; gdecNetChangeAmt[30]) { }

            column(gdecPaymentAmtK1; gdecOpeningAmt[31]) { }
            column(gdecPaymentAmtKK1; gdecNetChangeAmt[31]) { }
            column(gdecPaymentAmtK2; gdecOpeningAmt[32]) { }
            column(gdecPaymentAmtKK2; gdecNetChangeAmt[32]) { }
            column(gdecPaymentAmtK3; gdecOpeningAmt[33]) { }
            column(gdecPaymentAmtKK3; gdecNetChangeAmt[33]) { }

            column(gdecPaymentAmtK4; gdecOpeningAmt[34]) { }
            column(gdecPaymentAmtKK4; gdecNetChangeAmt[34]) { }
            column(gdecPaymentAmtK5; gdecOpeningAmt[35]) { }
            column(gdecPaymentAmtKK5; gdecNetChangeAmt[35]) { }
            column(gdecPaymentAmtK6; gdecOpeningAmt[36]) { }
            column(gdecPaymentAmtKK6; gdecNetChangeAmt[36]) { }

            column(gdecPaymentAmtK7; gdecOpeningAmt[37]) { }
            column(gdecPaymentAmtKK7; gdecNetChangeAmt[37]) { }
            column(gdecPaymentAmtK8; gdecOpeningAmt[38]) { }
            column(gdecPaymentAmtKK8; gdecNetChangeAmt[38]) { }
            column(gdecPaymentAmtK9; gdecOpeningAmt[39]) { }
            column(gdecPaymentAmtKK9; gdecNetChangeAmt[39]) { }

            column(gdecPaymentAmtK10; gdecOpeningAmt[40]) { }
            column(gdecPaymentAmtKK10; gdecNetChangeAmt[40]) { }
            column(gdecPaymentAmtK11; gdecOpeningAmt[41]) { }
            column(gdecPaymentAmtKK11; gdecNetChangeAmt[41]) { }
            column(gdecPaymentAmtK12; gdecOpeningAmt[42]) { }
            column(gdecPaymentAmtKK12; gdecNetChangeAmt[42]) { }

            column(gdecPaymentAmtK13; gdecOpeningAmt[43]) { }
            column(gdecPaymentAmtKK13; gdecNetChangeAmt[43]) { }
            column(gdecPaymentAmtK14; gdecOpeningAmt[44]) { }
            column(gdecPaymentAmtKK14; gdecNetChangeAmt[44]) { }
            column(gdecPaymentAmtK15; gdecOpeningAmt[45]) { }
            column(gdecPaymentAmtKK15; gdecNetChangeAmt[45]) { }

            column(gdecPaymentAmtK16; gdecOpeningAmt[46]) { }
            column(gdecPaymentAmtKK16; gdecNetChangeAmt[46]) { }
            column(gdecPaymentAmtK17; gdecOpeningAmt[47]) { }
            column(gdecPaymentAmtKK17; gdecNetChangeAmt[47]) { }
            column(gdecPaymentAmtK18; gdecOpeningAmt[48]) { }
            column(gdecPaymentAmtKK18; gdecNetChangeAmt[48]) { }

            column(gdecPaymentAmtK19; gdecOpeningAmt[49]) { }
            column(gdecPaymentAmtKK19; gdecNetChangeAmt[49]) { }
            column(gdecPaymentAmtK20; gdecOpeningAmt[50]) { }
            column(gdecPaymentAmtKK20; gdecNetChangeAmt[50]) { }
            column(gdecPaymentAmtK21; gdecOpeningAmt[51]) { }
            column(gdecPaymentAmtKK21; gdecNetChangeAmt[51]) { }

            column(gdecPaymentAmtK22; gdecOpeningAmt[52]) { }
            column(gdecPaymentAmtKK22; gdecNetChangeAmt[52]) { }
            column(gdecPaymentAmtK23; gdecOpeningAmt[53]) { }
            column(gdecPaymentAmtKK23; gdecNetChangeAmt[53]) { }
            column(gdecPaymentAmtK24; gdecOpeningAmt[54]) { }
            column(gdecPaymentAmtKK24; gdecNetChangeAmt[54]) { }

            column(gdecTotalOpening1; gdecTotalOpening[1]) { }
            column(gdecTotalOpening2; gdecTotalOpening[2]) { }

            column(gdecTotalNetChange1; gdecTotalNetChange[1]) { }
            column(gdecTotalNetChange2; gdecTotalNetChange[2]) { }

            column(gdecBalance1; gdecBalance[1]) { }
            column(gdecBalance2; gdecBalance[2]) { }


            trigger OnPreDataItem()
            begin
                Clear(gdecOpeningBalance);
                grecGLEntry.Reset();
                grecGLEntry.SetFilter("Posting Date", '<%1', gdateStartDate);
                grecGLEntry.SetFilter("G/L Account No.", '43150..44100');
                if grecGLEntry.FindSet() then begin
                    repeat
                        grecGLAccount.Reset();
                        grecGLAccount.SetRange("No.", grecGLEntry."G/L Account No.");
                        grecGLAccount.SetRange("Account Type", grecGLAccount."Account Type"::Posting);
                        if grecGLAccount.FindFirst() then
                            gdecOpeningBalance += grecGLEntry.Amount;
                    until grecGLEntry.Next() = 0;
                end;


                Clear(gdecNetChange);
                grecGLEntry.Reset();
                //grecGLEntry.SetRange("Posting Date", gdateStartDate, gdateEndDate);
                grecGLEntry.SetFilter("Posting Date", '<%1', gdateStartDate);
                grecGLEntry.SetFilter("G/L Account No.", '43155|43156|43160|43165|43200..44099');
                if grecGLEntry.FindSet() then begin
                    repeat
                        grecGLAccount.Reset();
                        grecGLAccount.SetRange("No.", grecGLEntry."G/L Account No.");
                        grecGLAccount.SetRange("Account Type", grecGLAccount."Account Type"::Posting);
                        if grecGLAccount.FindFirst() then
                            gdecNetChange += grecGLEntry.Amount;
                    until grecGLEntry.Next() = 0;
                end;



                grecGLEntryBuffer.Reset();
                grecGLEntryBuffer.DeleteAll();

                grecGLEntry.Reset();
                //grecGLEntry.SetRange("Posting Date", gdateStartDate, gdateEndDate);
                if grecGLEntry.FindSet() then begin
                    repeat
                        grecGLEntryBuffer.Init();
                        grecGLEntryBuffer.Copy(grecGLEntry);
                        grecGLEntryBuffer.Insert();
                    until grecGLEntry.Next = 0;
                end;
                gintGLEntryCount := grecGLEntry.Count();


                Clear(gdecClosingBalance);
                grecGLEntry.Reset();
                grecGLEntry.SetFilter("Posting Date", '<=%1', gdateEndDate);
                grecGLEntry.SetFilter("G/L Account No.", '43155|43156|43160|43165|43200..44099');
                if grecGLEntry.FindSet() then begin
                    repeat
                        grecGLAccount.Reset();
                        grecGLAccount.SetRange("No.", grecGLEntry."G/L Account No.");
                        grecGLAccount.SetRange("Account Type", grecGLAccount."Account Type"::Posting);
                        if grecGLAccount.FindFirst() then
                            gdecClosingBalance += grecGLEntry.Amount;
                    until grecGLEntry.Next() = 0;
                end;


                gintOpeningRowCount := 1;
                gintNetChangeRowCount := 1;
                grecReceiptPaymentSetup.Reset();
                grecReceiptPaymentSetup.SetCurrentKey(Row);
                if grecReceiptPaymentSetup.FindSet() then begin
                    repeat
                        //Opening Balance
                        grecGLEntryBuffer.Reset();
                        grecGLEntryBuffer.SetFilter("G/L Account No.", grecReceiptPaymentSetup."G/L Account No. Filter");
                        grecGLEntryBuffer.SetRange("Posting Date", 0D, gdateStartDate - 1);
                        if grecGLEntryBuffer.FindSet then begin
                            repeat
                                if grecDimSetEntry.Get(grecGLEntryBuffer."Dimension Set ID", 'TYPE') then begin
                                    if grecDimSetEntry."Dimension Value Code" = grecReceiptPaymentSetup."Dimension Value Type" then
                                        gdecOpeningAmt[gintOpeningRowCount] += grecGLEntryBuffer.Amount;
                                end;
                            until grecGLEntryBuffer.Next = 0;
                        end;

                        //Net Change
                        grecGLEntryBuffer.SetRange("Posting Date", gdateStartDate, gdateEndDate);
                        if grecGLEntryBuffer.FindSet then begin
                            repeat
                                if grecDimSetEntry.Get(grecGLEntryBuffer."Dimension Set ID", 'TYPE') then begin
                                    if grecDimSetEntry."Dimension Value Code" = grecReceiptPaymentSetup."Dimension Value Type" then
                                        gdecNetChangeAmt[gintNetChangeRowCount] += grecGLEntryBuffer.Amount;
                                end;
                            until grecGLEntryBuffer.Next = 0;
                        end;

                        //Add Initial Entries
                        /* if gdateStartDate < 20200107D then begin
                            grecRecPayInitialEntry.Reset();
                            grecRecPayInitialEntry.SetRange(Type, grecReceiptPaymentSetup."Dimension Value Type");
                            if grecRecPayInitialEntry.FindSet() then begin
                                repeat
                                    if gboolInitialOpeningBal then
                                        gdecOpeningAmt[gintOpeningRowCount] += grecRecPayInitialEntry.Amount;
                                    if gboolInitialNetChange then
                                        gdecNetChangeAmt[gintNetChangeRowCount] += grecRecPayInitialEntry.Amount;
                                until grecRecPayInitialEntry.Next = 0;
                            end;
                        end; */

                        gintOpeningRowCount += 1;
                        gintNetChangeRowCount += 1;
                    until grecReceiptPaymentSetup.Next() = 0;
                end;


                Clear(gdecTotalOpening);
                Clear(gdecTotalNetChange);
                //Opening Balance total for Receipt
                for gintOpeningCount := 1 to 26 do begin
                    gdecTotalOpening[1] += gdecOpeningAmt[gintOpeningCount];
                end;

                //Opening Balance total for Payment
                for gintOpeningCount := 27 to 54 do begin
                    gdecTotalOpening[2] += gdecOpeningAmt[gintOpeningCount];
                end;

                //Net Change total for Receipt
                for gintNetChangeCount := 1 to 26 do begin
                    gdecTotalNetChange[1] += gdecNetChangeAmt[gintNetChangeCount];
                end;

                //Net Change total for Payment
                for gintNetChangeCount := 27 to 54 do begin
                    gdecTotalNetChange[2] += gdecNetChangeAmt[gintNetChangeCount];
                end;


                Clear(gdecBalance);
                gdecBalance[1] := gdecTotalOpening[1] + gdecTotalOpening[2];
                gdecBalance[2] := gdecTotalNetChange[1] + gdecTotalNetChange[2];
            end;
        }
    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("Start Date"; gdateStartDate)
                    {
                        ApplicationArea = All;
                    }
                    field("End Date"; gdateEndDate)
                    {
                        ApplicationArea = All;
                    }
                    /* field("Add Initial Entries in Opening Balance"; gboolInitialOpeningBal)
                    {
                        trigger OnValidate()
                        begin
                            if gboolInitialNetChange then
                                Error('You can choose only one option.');
                        end;
                    }
                    field("Add Initial Entries in Net Change"; gboolInitialNetChange)
                    {
                        trigger OnValidate()
                        begin
                            if gboolInitialOpeningBal then
                                Error('You can choose only one option.');
                        end;
                    } */
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if (gdateStartDate = 0D) or (gdateEndDate = 0D) then
            Error('Please insert both Start Date and End Date.');

        if gdateEndDate < gdateStartDate then
            Error('End Date can not be greater than Start Date.');

        /* if (not gboolInitialNetChange) and (not gboolInitialOpeningBal) then
            Error('Add Initial Entries option should be choosen before running the report.'); */
    end;

    var
        gdateStartDate: Date;
        gdateEndDate: Date;
        gintGLEntryCount: Integer;
        grecGLEntry: Record "G/L Entry";
        grecGLEntryBuffer: Record "G/L Entry" temporary;
        grecReceiptPaymentSetup: Record Receipt_Payment_Setup;

        gdecOpeningBalance: Decimal;
        gdecNetChange: Decimal;

        gdecOpeningAmt: array[54] of decimal;
        gdecNetChangeAmt: array[54] of decimal;

        grecGLAccount: Record "G/L Account";
        grecDimSetEntry: Record "Dimension Set Entry";

        gintOpeningRowCount: Integer;
        gintNetChangeRowCount: Integer;

        gdecTotalOpening: array[2] of Decimal;
        gdecTotalNetChange: array[2] of Decimal;
        gdecBalance: array[2] of Decimal;

        gintOpeningCount: Integer;
        gintNetChangeCount: Integer;


        gdecClosingBalance: Decimal;

        gboolInitialOpeningBal: Boolean;
        gboolInitialNetChange: Boolean;

    //grecRecPayInitialEntry: Record ReceiptsPaymentsInitialEntries;
}