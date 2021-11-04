report 50003 "Bank Reconciliation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\Bank Reconciliation.rdl';
    ProcessingOnly = false;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(HeaderSection; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column(CompInfo_Name; CompanyInfoGREc.Name) { }
            column(CompInfo_Address; CompanyInfoGREc.Address) { }
            column(CompInfo_Address2; CompanyInfoGREc."Address 2") { }
            column(CompInfo_PhoneNo; CompanyInfoGREc."Phone No.") { }
            column(CompInfo_FaxNo; CompanyInfoGREc."Fax No.") { }
            column(CompInfo_Email; CompanyInfoGREc."E-Mail") { }
            column(CompInfo_HomePage; CompanyInfoGREc."Home Page") { }
            column(CompInfo_VATRegNo; CompanyInfoGREc."VAT Registration No.") { }
            column(CompInfo_BRN; CompanyInfoGREc.BRN) { }
            column(BalAsPerBankStatement_; BankAcctLedEntryOpeningBal."Amount (LCY)") { }
            column(BankAccNo_; "BankAccNo.") { }
            column(BankAccountName_; BankAccountGRec.Name) { }
            column(BankAcc_No_; BankAccountGRec."Bank Account No.") { }
            column(BalAsPerBankStatementDate_; FORMAT(DateG, 10, '<Day,2>/<Month,2>/<Year4>')) { }

            trigger OnAfterGetRecord()
            begin
                IF BankAccountGRec.GET("BankAccNo.") THEN;
                IF PrintToExcel THEN
                    MakeExcelDataHeader;
            end;
        }
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = SORTING("Posting Date", "Document No.");
            column(DisplayTxt_; DisplayTxt) { }
            column(BankAccount_; "Bank Account Ledger Entry"."Bank Account No.") { }
            column(GLAccountNo_; "G/LNo.") { }
            column(PostingDate_; "Bank Account Ledger Entry"."Posting Date") { }
            column(DocumentType_; "Bank Account Ledger Entry"."Document Type") { }
            column(DocumentNo_; "Bank Account Ledger Entry"."Document No.") { }
            column(Payee_; '') { }//"Bank Account Ledger Entry".Payee)
            column(Particulars_; '') { }// "Bank Account Ledger Entry"."Description 2")
            column(Description_; "Bank Account Ledger Entry".Description) { }
            column(Amount; "Bank Account Ledger Entry".Amount) { }
            column(AmountLCY_; "Bank Account Ledger Entry"."Amount (LCY)") { }
            column(BalAccountType_; "Bank Account Ledger Entry"."Bal. Account Type") { }
            column(BalAccountNo_; "Bank Account Ledger Entry"."Bal. Account No.") { }
            column(ExtDocNo_; "Bank Account Ledger Entry"."External Document No.") { }
            column(ClientBank_; "Bank Account Ledger Entry"."Currency Code") { }//"Bank Account Ledger Entry"."Client Bank")
            column(TotalLessAmt_; TotalLessAmt) { }
            column(VarLess_; VarLess) { }

            trigger OnAfterGetRecord()
            var
                grecCheckLedgerEntry: Record "Check Ledger Entry";
            begin
                VarLess := 1;
                VarAdd := 0;

                IF ("Bank Account Ledger Entry".Amount = 0) AND ("Bank Account Ledger Entry"."Amount (LCY)" = 0) THEN
                    CurrReport.SKIP;

                grecCheckLedgerEntry.Reset();
                grecCheckLedgerEntry.SetRange("Document No.", "Bank Account Ledger Entry"."Document No.");
                grecCheckLedgerEntry.SetRange("Entry Status", grecCheckLedgerEntry."Entry Status"::"Financially Voided");
                if grecCheckLedgerEntry.FindFirst() then
                    CurrReport.Skip();


                SumAmountCR := SumAmountCR + "Bank Account Ledger Entry"."Amount (LCY)";
                SumAmountCR2 := SumAmountCR2 + "Bank Account Ledger Entry".Amount;

                Counter += 1;
                IF Counter = 1 THEN
                    DisplayTxt := 'Less Outstanding Transactions'
                ELSE
                    DisplayTxt := '';


                IF LessOutCount = Counter THEN BEGIN
                    TotalLessAmt := BankAcctLedEntryLessTran."Amount (LCY)";
                    TotalLessAmt2 := BankAcctLedEntryLessTran.Amount;
                END ELSE BEGIN
                    TotalLessAmt := 0;
                    TotalLessAmt2 := 0;
                END;

                IF PrintToExcel THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn(DisplayTxt, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Bank Account Ledger Entry"."Bank Account No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(FORMAT("G/LNo."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(FORMAT("Bank Account Ledger Entry"."Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(FORMAT("Bank Account Ledger Entry"."Document Type"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Bank Account Ledger Entry"."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    //ExcelBuf.AddColumn("Bank Account Ledger Entry".Payee, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    //ExcelBuf.AddColumn("Bank Account Ledger Entry"."Description 2", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Bank Account Ledger Entry".Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Bank Account Ledger Entry"."Amount (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn("Bank Account Ledger Entry".Amount, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(FORMAT("Bank Account Ledger Entry"."Bal. Account Type"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Bank Account Ledger Entry"."Bal. Account No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Bank Account Ledger Entry"."External Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(FORMAT("Bank Account Ledger Entry"."Currency Code"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    IF TotalLessAmt <> 0 THEN BEGIN
                        ExcelBuf.AddColumn(FORMAT(TotalLessAmt), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(FORMAT(TotalLessAmt2), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    END;

                END;
            end;

            trigger OnPostDataItem()
            begin
                IF PrintToExcel THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('Closing Balance - Outstanding Transactions', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(SumAmountCR, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(SumAmountCR2, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                END;
            end;

            trigger OnPreDataItem()
            begin
                CLEAR(Counter);
                CLEAR(LessOutCount);

                BankAcctLedEntryLessTran.RESET;
                BankAcctLedEntryLessTran.SETCURRENTKEY("Statement Status", "Posting Date", "Bank Account No.");
                BankAcctLedEntryLessTran.SETRANGE("Bank Account No.", "BankAccNo.");
                BankAcctLedEntryLessTran.SETFILTER("Posting Date", '<=%1', DateG);
                //BankAcctLedEntryLessTran.SETRANGE("Statement Status", BankAcctLedEntryLessTran."Statement Status"::Closed);
                BankAcctLedEntryLessTran.SETRANGE(Positive, FALSE);
                BankAcctLedEntryLessTran.CALCSUMS("Amount (LCY)");
                BankAcctLedEntryLessTran.CALCSUMS(Amount);


                BankAcctLedEntryAddTran.RESET;
                BankAcctLedEntryAddTran.SETCURRENTKEY("Statement Status", "Posting Date", "Bank Account No.");
                BankAcctLedEntryAddTran.SETRANGE("Bank Account No.", "BankAccNo.");
                BankAcctLedEntryAddTran.SETFILTER("Posting Date", '<=%1', DateG);
                //BankAcctLedEntryAddTran.SETRANGE("Statement Status", BankAcctLedEntryAddTran."Statement Status"::Closed);
                BankAcctLedEntryAddTran.Setfilter("Source Code", '<>%1', 'FINVOIDCHK');
                BankAcctLedEntryAddTran.SETRANGE(Positive, TRUE);
                BankAcctLedEntryAddTran.CALCSUMS("Amount (LCY)");
                BankAcctLedEntryAddTran.CALCSUMS(Amount);
                CountADD := BankAcctLedEntryAddTran.COUNT;

                "Bank Account Ledger Entry".COPYFILTERS(BankAcctLedEntryLessTran);

                //RCTS 19/05/2020
                Clear(gtextStatements2);
                grecBankAccStatement.Reset();
                grecBankAccStatement.SetRange("Bank Account No.", "BankAccNo.");
                grecBankAccStatement.SetFilter("Statement Date", '<=%1', DateG);
                if grecBankAccStatement.FindFirst then begin
                    repeat
                        if gtextStatements2 = '' then
                            gtextStatements2 := '<>' + grecBankAccStatement."Statement No."
                        else
                            gtextStatements2 += '&<>' + grecBankAccStatement."Statement No.";
                    until grecBankAccStatement.Next = 0;
                end;
                "Bank Account Ledger Entry".SetFilter("Statement No.", gtextStatements2);
                //RCTS 19/05/2020

                LessOutCount := "Bank Account Ledger Entry".COUNT;

                BankAccountGRec.GET("BankAccNo.");
                BankAccountPostingGRec.GET(BankAccountGRec."Bank Acc. Posting Group");
                "G/LNo." := BankAccountPostingGRec."G/L Bank Account No.";
            end;
        }
        dataitem(BankAccountLedgerEntryAddTran; "Bank Account Ledger Entry")
        {
            DataItemTableView = SORTING("Posting Date", "Document No.");
            column(DisplayTxtAdd_; DisplayTxt) { }
            column(BankAccountAdd_; BankAccountLedgerEntryAddTran."Bank Account No.") { }
            column(GLAccountNoAdd_; "G/LNo.") { }
            column(PostingDateAdd_; BankAccountLedgerEntryAddTran."Posting Date") { }
            column(DocumentTypeAdd_; BankAccountLedgerEntryAddTran."Document Type") { }
            column(DocumentNoAdd_; BankAccountLedgerEntryAddTran."Document No.") { }
            column(PayeeAdd_; '') { }//BankAccountLedgerEntryAddTran.Payee)
            column(ParticularsAdd_; '') { }//BankAccountLedgerEntryAddTran."Description 2")
            column(DescriptionAdd_; BankAccountLedgerEntryAddTran.Description) { }
            column(AmountLCYAdd_; BankAccountLedgerEntryAddTran."Amount (LCY)") { }
            column(Amount2; BankAccountLedgerEntryAddTran.Amount) { }
            column(BalAccountTypeAdd_; BankAccountLedgerEntryAddTran."Bal. Account Type") { }
            column(BalAccountNoAdd_; BankAccountLedgerEntryAddTran."Bal. Account No.") { }
            column(ExtDocNoAdd_; BankAccountLedgerEntryAddTran."External Document No.") { }
            column(ClientBankAdd_; BankAccountLedgerEntryAddTran."Currency Code") { }//BankAccountLedgerEntryAddTran."Client Bank")
            column(VarAdd_; VarAdd) { }

            trigger OnAfterGetRecord()
            begin
                Counter += 1;
                IF Counter = 1 THEN
                    DisplayTxt := 'Add Outstanding Lodgements'
                ELSE
                    DisplayTxt := '';

                VarLess := 0;
                VarAdd := 1;


                IF AddOutCount = Counter THEN BEGIN
                    TotalAddAmt := BankAcctLedEntryAddTran."Amount (LCY)";
                END ELSE BEGIN
                    TotalAddAmt := 0;
                END;


                IF PrintToExcel THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn(DisplayTxt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(BankAccountLedgerEntryAddTran."Bank Account No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(FORMAT("G/LNo."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(BankAccountLedgerEntryAddTran."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(FORMAT(BankAccountLedgerEntryAddTran."Document Type"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(BankAccountLedgerEntryAddTran."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    //ExcelBuf.AddColumn(BankAccountLedgerEntryAddTran.Payee, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    //ExcelBuf.AddColumn(BankAccountLedgerEntryAddTran."Description 2", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(BankAccountLedgerEntryAddTran.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(BankAccountLedgerEntryAddTran."Amount (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(BankAccountLedgerEntryAddTran.Amount, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(FORMAT(BankAccountLedgerEntryAddTran."Bal. Account Type"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(BankAccountLedgerEntryAddTran."Bal. Account No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(BankAccountLedgerEntryAddTran."External Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(FORMAT(BankAccountLedgerEntryAddTran."Currency Code"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                END;
            end;

            trigger OnPostDataItem()
            begin
                IF PrintToExcel THEN BEGIN
                    IF TotalAddAmt <> 0 THEN BEGIN
                        ExcelBuf.NewRow;
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('Closing Balance - Outstanding Lodgements', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(TotalAddAmt, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn(TotalAddAmt2, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                CLEAR(Counter);
                BankAccountLedgerEntryAddTran.RESET;
                BankAccountLedgerEntryAddTran.COPYFILTERS(BankAcctLedEntryAddTran);
                //RCTS 19/05/2020
                Clear(gtextStatements2);
                grecBankAccStatement.Reset();
                grecBankAccStatement.SetRange("Bank Account No.", "BankAccNo.");
                grecBankAccStatement.SetFilter("Statement Date", '<=%1', DateG);
                if grecBankAccStatement.FindFirst then begin
                    repeat
                        if gtextStatements2 = '' then
                            gtextStatements2 := '<>' + grecBankAccStatement."Statement No."
                        else
                            gtextStatements2 += '&<>' + grecBankAccStatement."Statement No.";
                    until grecBankAccStatement.Next = 0;
                end;
                BankAccountLedgerEntryAddTran.SetFilter("Statement No.", gtextStatements2);
                //RCTS 19/05/2020
                AddOutCount := BankAccountLedgerEntryAddTran.COUNT;
            end;
        }
        dataitem(DataItem1000000047; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column(VarCashBook_; VarCashBook) { }

            trigger OnAfterGetRecord()
            begin
                IF PrintToExcel THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('BALANCE AS PER CASH BOOK - ' + FORMAT(DateG), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                    ExcelBuf.AddColumn(BankAcctLedEntryOpeningBal."Amount (LCY)" + SumAmountCR + TotalAddAmt, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(BankAcctLedEntryOpeningBal.Amount + SumAmountCR2 + TotalAddAmt2, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("BankAccountNo."; "BankAccNo.")
                {
                    Caption = 'Bank Account No.';
                    TableRelation = "Bank Account";
                    ApplicationArea = All;
                }
                field(Date; DateG)
                {
                    ApplicationArea = All;
                }
                field(PrintToExcel; PrintToExcel)
                {
                    Caption = 'Print To Excel';
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN
            CreateExcelBook;
    end;

    trigger OnPreReport()
    begin

        //RCTS 19/05/2020
        Clear(gtextStatements);
        grecBankAccStatement.Reset();
        grecBankAccStatement.SetRange("Bank Account No.", "BankAccNo.");
        grecBankAccStatement.SetRange("Statement Date", DateG);
        if grecBankAccStatement.IsEmpty() then
            Error('No bank reconciliation has been processed for this bank account on this date.')
        else begin
            grecBankAccStatement.SetFilter("Statement Date", '<=%1', DateG);
            if grecBankAccStatement.FindFirst then begin
                repeat
                    if gtextStatements = '' then
                        gtextStatements := grecBankAccStatement."Statement No."
                    else
                        gtextStatements += '|' + grecBankAccStatement."Statement No.";
                until grecBankAccStatement.Next = 0;
            end;
        end;
        //RCTS 19/05/2020


        IF CompanyInfoGREc.GET THEN;
        BankAcctLedEntryOpeningBal.RESET;
        BankAcctLedEntryOpeningBal.SETCURRENTKEY("Statement Status", "Posting Date", "Bank Account No.");
        BankAcctLedEntryOpeningBal.SETRANGE("Bank Account No.", "BankAccNo.");
        BankAcctLedEntryOpeningBal.SETFILTER("Posting Date", '<=%1', DateG);
        //RCTS 19/05/2020
        if gtextStatements <> '' then
            BankAcctLedEntryOpeningBal.SetFilter("Statement No.", gtextStatements);
        //RCTS 19/05/2020
        BankAcctLedEntryOpeningBal.SETRANGE("Statement Status", BankAcctLedEntryOpeningBal."Statement Status"::Closed);
        BankAcctLedEntryOpeningBal.CALCSUMS("Amount (LCY)");
        BankAcctLedEntryOpeningBal.CALCSUMS(Amount); //YH
    end;

    var
        "BankAccNo.": Code[20];
        DateG: Date;
        LessOutCount: Integer;
        OpeningBalance: Integer;
        BankAcctLedEntryOpeningBal: Record "Bank Account Ledger Entry";
        Counter: Integer;
        TotalLessAmt: Decimal;
        BankAcctLedEntryLessTran: Record "Bank Account Ledger Entry";
        BankAcctLedEntryAddTran: Record "Bank Account Ledger Entry";
        AddOutCount: Integer;
        TotalAddAmt: Decimal;
        CompanyInfoGREc: Record "Company Information";
        DisplayTxt: Text[30];
        BankAccountGRec: Record "Bank Account";
        BankAccountPostingGRec: Record "Bank Account Posting Group";
        "G/LNo.": Code[20];
        CountADD: Integer;
        SumAmountCR: Decimal;
        SumAmountDB: Decimal;
        VarAdd: Integer;
        VarLess: Integer;
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        VarCashBook: Boolean;
        SumAmountCR2: Decimal;
        SumAmountDB2: Decimal;
        TotalLessAmt2: Decimal;
        grecBankAccStatement: Record "Bank Account Statement";
        TotalAddAmt2: Decimal;
        gtextStatements: Text[250];
        gtextStatements2: Text[250];


    local procedure MakeExcelDataHeader()
    begin

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Bank Account', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("BankAccNo." + ' - ' + BankAccountGRec.Name, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Bank Account No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(BankAccountGRec."Bank Account No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);



        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Balance as per bank statement - ' + FORMAT(DateG), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(BankAcctLedEntryOpeningBal."Amount (LCY)", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(BankAcctLedEntryOpeningBal.Amount, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Bank Account', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('G/L Account No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Document Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Document No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('Payee', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('Particulars', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Description', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Amount USD', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Balance Account Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Balance Account No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('External Doc No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Client Bank', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
    end;

    local procedure CreateExcelBook()
    begin
        ExcelBuf.CreateBookAndOpenExcel('', 'Bank Account Reconciliation', 'Test3', COMPANYNAME, USERID);
    end;
}

