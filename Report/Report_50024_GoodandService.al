report 50024 "Goods and Services"
{
    DefaultLayout = RDLC;

    Caption = 'Goods and Services';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = SORTING("Primary Key");

            trigger OnAfterGetRecord()
            begin
                Window.OPEN(Text000);
                MakeExcelDataHeader;
            end;
        }
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Vendor No.", "Posting Date", "Currency Code");
                RequestFilterFields = "Document No.", "Amount (LCY)";
                dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Applied Vend. Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Applied Vend. Ledger Entry No.", "Entry Type")
                                        WHERE("Entry Type" = CONST(Application),
                                              "Document Type" = FILTER(<> Refund),
                                              Unapplied = CONST(false));

                    trigger OnAfterGetRecord()
                    var
                        DetailedVendorLedgEntry: Record 380;
                        ApplicationEntryNo: Integer;
                        SkipRecord: Boolean;
                        DetailedVendorLedgEntry2: Record 380;
                    begin
                        //      VoidVLE.RESET;
                        //      VoidVLE.SETRANGE("Closed by Entry No.","Detailed Vendor Ledg. Entry"."Applied Vend. Ledger Entry No.");
                        //      VoidVLE.SETRANGE(VoidVLE."Source Code",'FINVOIDCHK');
                        //      IF VoidVLE.FINDFIRST THEN
                        //        CurrReport.SKIP;
                        //
                        //      VoidVLE.RESET;
                        //      VoidVLE.SETRANGE("Closed by Entry No.","Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.");
                        //      VoidVLE.SETRANGE(VoidVLE."Source Code",'FINVOIDCHK');
                        //      IF VoidVLE.FINDFIRST THEN
                        //        CurrReport.SKIP;

                        VoidVLE.RESET;
                        VoidVLE.SETRANGE("Entry No.", "Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.");
                        VoidVLE.SETRANGE(VoidVLE."Source Code", 'FINVOIDCHK');
                        IF VoidVLE.FINDFIRST THEN
                            CurrReport.SKIP;

                        VoidVLE.RESET;
                        VoidVLE.SETRANGE("Entry No.", "Detailed Vendor Ledg. Entry"."Applied Vend. Ledger Entry No.");
                        VoidVLE.SETRANGE(VoidVLE."Source Code", 'FINVOIDCHK');
                        IF VoidVLE.FINDFIRST THEN
                            CurrReport.SKIP;


                        IF "Detailed Vendor Ledg. Entry"."Document Type" = "Detailed Vendor Ledg. Entry"."Document Type"::" " THEN
                            IF "Detailed Vendor Ledg. Entry"."Source Code" = 'FINVOIDCHK' THEN
                                CurrReport.SKIP;


                        IF "Detailed Vendor Ledg. Entry"."Document Type" = "Detailed Vendor Ledg. Entry"."Document Type"::" " THEN
                            IF "Detailed Vendor Ledg. Entry"."Source Code" = 'PURCHAPPL' THEN
                                IF VLE.GET("Detailed Vendor Ledg. Entry"."Applied Vend. Ledger Entry No.") THEN
                                    IF VLE."Source Code" = 'FINVOIDCHK' THEN
                                        CurrReport.SKIP;

                        IF ("Detailed Vendor Ledg. Entry"."Document Type" = "Detailed Vendor Ledg. Entry"."Document Type"::" ") AND
                          ("Detailed Vendor Ledg. Entry"."Initial Document Type" = "Detailed Vendor Ledg. Entry"."Initial Document Type"::" ") THEN
                            IF "Detailed Vendor Ledg. Entry"."Source Code" = 'PAYMENTJNL' THEN
                                IF VLE.GET("Detailed Vendor Ledg. Entry"."Applied Vend. Ledger Entry No.") THEN
                                    IF VLE."Source Code" = 'PAYMENTJNL' THEN
                                        CurrReport.SKIP;

                        VLE.Reset();
                        VLE.SetRange("Entry No.", "Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.");
                        VLE.SetRange("Posting Date", StartingDate, EndingDate);
                        if not VLE.FindFirst() then
                            CurrReport.Skip();

                        /*  VLE.Reset();
                         VLE.SetRange("Entry No.", "Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.");
                         if "Vendor Ledger Entry".GetFilter("Amount (LCY)") <> '' then
                             VLE.SetFilter("Amount (LCY)", "Vendor Ledger Entry".GetFilter("Amount (LCY)"));
                         if not VLE.FindFirst() then
                             CurrReport.Skip(); */


                        IF VLE.GET("Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.") THEN BEGIN
                            IF VLE."Document Type" = VLE."Document Type"::Invoice THEN BEGIN
                                IF "Detailed Vendor Ledg. Entry"."Entry Type" = "Detailed Vendor Ledg. Entry"."Entry Type"::Application THEN BEGIN
                                    SkipRecord := CheckSkip;
                                    IF SkipRecord THEN
                                        CurrReport.SKIP;
                                END;
                            END;

                            IF VLE."Document Type" = VLE."Document Type"::"Credit Memo" THEN BEGIN
                                SkipRecord := TRUE;
                                IF "Detailed Vendor Ledg. Entry"."Entry Type" = "Detailed Vendor Ledg. Entry"."Entry Type"::Application THEN BEGIN
                                    IF ("Detailed Vendor Ledg. Entry"."Document Type" IN ["Detailed Vendor Ledg. Entry"."Document Type"::Invoice, "Detailed Vendor Ledg. Entry"."Document Type"::"Credit Memo"]) THEN BEGIN
                                        WITH DetailedVendorLedgEntry DO BEGIN
                                            IF "Detailed Vendor Ledg. Entry"."Transaction No." = 0 THEN BEGIN
                                                SETCURRENTKEY("Application No.", "Vendor No.", "Entry Type");
                                                SETRANGE("Application No.", "Detailed Vendor Ledg. Entry"."Application No.");
                                            END ELSE BEGIN
                                                SETCURRENTKEY("Transaction No.", "Vendor No.", "Entry Type");
                                                SETRANGE("Transaction No.", "Detailed Vendor Ledg. Entry"."Transaction No.");
                                            END;
                                            //SETRANGE("Vendor Ledger Entry No.","Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.");
                                            SETRANGE("Entry Type", "Entry Type"::Application);
                                            SETFILTER("Initial Document Type", '%1|%2', DetailedVendorLedgEntry."Initial Document Type"::Invoice, DetailedVendorLedgEntry."Initial Document Type"::Payment);
                                            SETRANGE(Unapplied, FALSE);
                                            ApplicationEntryNo := 0;
                                            IF FIND('-') THEN
                                                REPEAT
                                                    IF "Entry No." > ApplicationEntryNo THEN
                                                        ApplicationEntryNo := "Vendor Ledger Entry No.";
                                                    //Test 2nd Sceaniro
                                                    DetailedVendorLedgEntry2.RESET;
                                                    DetailedVendorLedgEntry2.SETRANGE("Vendor Ledger Entry No.", "Vendor Ledger Entry No.");
                                                    DetailedVendorLedgEntry2.SETRANGE("Document Type", DetailedVendorLedgEntry2."Document Type"::Payment);
                                                    DetailedVendorLedgEntry2.SETFILTER("Source Code", '<>%1', 'FINVOIDCHK');
                                                    DetailedVendorLedgEntry2.SETRANGE(Unapplied, FALSE);
                                                    IF DetailedVendorLedgEntry2.FINDFIRST THEN
                                                        SkipRecord := FALSE;
                                                UNTIL NEXT = 0;
                                            IF SkipRecord THEN
                                                CurrReport.SKIP;
                                        END;
                                    END;
                                END;
                            END;
                        END;



                        VarDesc := '';
                        VarAmtExclVAT := 0;
                        VarVATAmt := 0;
                        VarDOCNOE := "Detailed Vendor Ledg. Entry"."Document No.";

                        IF (VLE.GET("Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.")) THEN BEGIN
                            VLE.CALCFIELDS(VLE."Original Amt. (LCY)", VLE."Remaining Amt. (LCY)");

                            IF (VLE."Document Type" <> VLE."Document Type"::Payment) OR ((VLE."Document Type" = VLE."Document Type"::Payment)
                               AND ("Detailed Vendor Ledg. Entry"."Initial Document Type" <> "Detailed Vendor Ledg. Entry"."Initial Document Type"::Payment)) THEN BEGIN
                                CASE VLE."Document Type" OF
                                    VLE."Document Type"::Invoice:
                                        BEGIN

                                            IF PurchInvHdr.GET(VLE."Document No.") THEN BEGIN
                                                PurchInvHdr.CALCFIELDS(PurchInvHdr.Amount, PurchInvHdr."Amount Including VAT");
                                                VarAmtExclVAT := ROUND(PurchInvHdr.Amount, 1, '=');
                                                VarVATAmt := ROUND(PurchInvHdr."Amount Including VAT" - PurchInvHdr.Amount, 1, '=');
                                                VarDesc := DELCHR(PurchInvHdr."Posting Description");
                                                //VarDesc := PurchInvHdr."Posting Description";
                                                IF PurchInvHdr."Currency Code" <> '' THEN BEGIN
                                                    VarAmtExclVAT := PurchInvHdr.Amount;
                                                    VarVATAmt := PurchInvHdr."Amount Including VAT" - PurchInvHdr.Amount;
                                                    VarAmtExclVAT := ROUND(VarAmtExclVAT / PurchInvHdr."Currency Factor", 1, '=');
                                                    VarVATAmt := ROUND(VarVATAmt / PurchInvHdr."Currency Factor", 1, '=');
                                                END;
                                                VLE2.RESET;
                                                VLE2.SETRANGE(VLE2."Document Type", VLE2."Document Type"::Payment);
                                                VLE2.SETFILTER(VLE2."Document No.", '=%1', VarDOCNOE);
                                                IF VLE2.FINDFIRST THEN BEGIN
                                                    VarDesc2 := VLE2.Description;
                                                END;
                                            END;
                                        END;

                                    VLE."Document Type"::"Credit Memo":
                                        BEGIN
                                            IF PurchCrMemoHdr.GET(VLE."Document No.") THEN BEGIN
                                                PurchCrMemoHdr.CALCFIELDS(PurchCrMemoHdr.Amount, PurchCrMemoHdr."Amount Including VAT");
                                                VarAmtExclVAT := ROUND(PurchCrMemoHdr.Amount, 1, '=') * -1;
                                                VarVATAmt := ROUND(PurchCrMemoHdr."Amount Including VAT" - PurchCrMemoHdr.Amount, 1, '=') * -1;
                                                VarDesc := DELCHR(PurchCrMemoHdr."Posting Description");
                                                IF PurchCrMemoHdr."Currency Code" <> '' THEN BEGIN
                                                    VarAmtExclVAT := (PurchCrMemoHdr.Amount) * -1;
                                                    VarVATAmt := (PurchCrMemoHdr."Amount Including VAT" - PurchCrMemoHdr.Amount) * -1;
                                                    VarAmtExclVAT := ROUND(VarAmtExclVAT / PurchCrMemoHdr."Currency Factor", 1, '=');
                                                    VarVATAmt := ROUND(VarVATAmt / PurchCrMemoHdr."Currency Factor", 1, '=');
                                                END;
                                            END ELSE BEGIN
                                                VLE.CALCFIELDS(VLE."Amount (LCY)");
                                                GLEntry.RESET;
                                                GLEntry.SETCURRENTKEY("G/L Account No.", "Document No.");
                                                //GLEntry.SETRANGE(GLEntry."G/L Account No.","Company Information"."G/L Account - MRA");
                                                GLEntry.SETRANGE(GLEntry."Document No.", VLE."Document No.");
                                                IF GLEntry.FINDFIRST THEN
                                                    VarVATAmt := ROUND(ABS(GLEntry.Amount), 1, '=');

                                                VarAmtExclVAT := ROUND(ABS(VLE."Amount (LCY)") - GLEntry.Amount, 1, '=');
                                                VarDesc := DELCHR(VLE.Description);
                                                //VarDesc := VLE.Description;
                                            END;
                                        END;

                                    VLE."Document Type"::Payment,
                                    VLE."Document Type"::" ":
                                        BEGIN
                                            VLE.CALCFIELDS(VLE."Amount (LCY)");
                                            VarDesc := DELCHR(VLE.Description);
                                            //VarDesc := VLE.Description;
                                            VarDesc2 := VLE.Description;
                                        END;
                                END;//Case end

                                CLEAR(VarInvoiceNo);
                                VarInvoiceNo := VLE."External Document No.";

                                CLEAR(VarName);
                                //VarName := DELCHR(Vendor.Name,'=','-_+=\|[]âàé}{".,#$@%^&*+!~`:;/?><() ''');
                                VarName := Vendor.Name;


                                CLEAR(VarPaidAmt);
                                VarPaidAmt := ROUND("Detailed Vendor Ledg. Entry"."Amount (LCY)", 1, '=');

                                //IF VLE."Document Type" =VLE."Document Type"::Payment THEN
                                // VarPaidAmt := VLE."Remaining Amt. (LCY)";

                                //IF (VarInvoiceNo = '') AND
                                IF VLE."Document Type" <> VLE."Document Type"::Refund THEN BEGIN

                                    if VarPaidAmt > grecPurchPayableSetup."Threshold Goods & Services Rpt" then begin
                                        ExcelBuf.NewRow;
                                        ExcelBuf.AddColumn(BuildDate(VLE."Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                        ExcelBuf.AddColumn(VarInvoiceNo, FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                                        ExcelBuf.AddColumn(VarName, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);



                                        IF Vendor.BRN <> '' THEN
                                            ExcelBuf.AddColumn(Vendor.BRN, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                        else
                                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);


                                        if Vendor.NID <> '' then
                                            ExcelBuf.AddColumn(Vendor.NID, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                        else
                                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);


                                        ExcelBuf.AddColumn(VarDesc, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                        ExcelBuf.AddColumn(VarAmtExclVAT, FALSE, '', FALSE, FALSE, FALSE, '0', ExcelBuf."Cell Type"::Number);
                                        ExcelBuf.AddColumn(VarVATAmt, FALSE, '', FALSE, FALSE, FALSE, '0', ExcelBuf."Cell Type"::Number);


                                        IF VLE."Document Type" = VLE."Document Type"::"Credit Memo" THEN
                                            ExcelBuf.AddColumn(VarPaidAmt, FALSE, '', FALSE, FALSE, FALSE, '0', ExcelBuf."Cell Type"::Number)
                                        ELSE
                                            ExcelBuf.AddColumn(VarPaidAmt, FALSE, '', FALSE, FALSE, FALSE, '0', ExcelBuf."Cell Type"::Number);


                                        IF VLE."Document Type" = VLE."Document Type"::Invoice THEN
                                            ExcelBuf.AddColumn('I', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                        IF VLE."Document Type" = VLE."Document Type"::"Credit Memo" THEN
                                            ExcelBuf.AddColumn('C', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                        IF VLE."Document Type" = VLE."Document Type"::Payment THEN
                                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                        IF VLE."Document Type" = VLE."Document Type"::" " THEN
                                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    end;

                                    /* ExcelBuf.AddColumn(VarDesc2, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn(BuildDate(VLE."Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn(Vendor."VAT Registration No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn(DELCHR(Vendor.Address, '=', '-_+=\|[]âàé}{".,#$@%^&*+!~`:;/?><() '''), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn(Vendor."Address 2", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn(Vendor.City, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn(VarDOCNOE, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn(VLE."Document Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn("Entry No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); */
                                END;
                            END;
                        END;

                    end;

                    trigger OnPostDataItem()
                    begin
                        IF COUNTI > 1 THEN
                            IF VarGrossAmtPaiddup = VarGrossAmtPaid THEN
                                CurrReport.SKIP;


                        CLEAR(VarGrossAmtPaid);
                        VLE.RESET;
                        VLE.SETCURRENTKEY("Document Type", "Vendor No.", "Posting Date", "Currency Code");
                        VLE.SETRANGE(VLE."Document Type", VLE."Document Type"::Payment);
                        VLE.SETRANGE(VLE."Document No.", "Detailed Vendor Ledg. Entry"."Document No.");
                        VLE.SETRANGE(VLE."Vendor No.", Vendor."No.");
                        VLE.SETFILTER(VLE."Posting Date", '%1..%2', StartingDate, EndingDate);
                        IF VLE.FINDSET THEN BEGIN
                            REPEAT
                                VLE.CALCFIELDS(VLE."Remaining Amt. (LCY)");
                                VarGrossAmtPaid += VLE."Remaining Amt. (LCY)";
                            UNTIL VLE.NEXT = 0;
                        END;

                        /*
                        IF VarGrossAmtPaid <>  0 THEN BEGIN
                          ExcelBuf.NewRow;
                          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
                          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
                          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
                          ExcelBuf.AddColumn(DELCHR(FORMAT(VarGrossAmtPaid),'=',','),FALSE,'',FALSE,FALSE,FALSE,'0',ExcelBuf."Cell Type"::Number);
                          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
                          ExcelBuf.AddColumn(VLE.Description,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                        END;
                        */



                        VarGrossAmtPaiddup := VarGrossAmtPaid;

                    end;

                    trigger OnPreDataItem()
                    begin
                        /*"Detailed Vendor Ledg. Entry".SETFILTER("Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.",'<>%1',
                                                                "Vendor Ledger Entry"."Entry No.");*/

                        COUNTI += 1;

                        CLEAR(VarDesc2);

                        //"Detailed Vendor Ledg. Entry".SETFILTER("Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.",'=%1',383046);
                    end;
                }
                dataitem(Unpaid; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Applied Vend. Ledger Entry No.", "Entry Type")
                                        WHERE("Entry Type" = CONST("Initial Entry"),
                                              "Document Type" = FILTER(Payment));

                    trigger OnAfterGetRecord()
                    var
                        DetailedVendorLedgEntry: Record 380;
                        ApplicationEntryNo: Integer;
                    begin

                        VarDesc := '';
                        VarAmtExclVAT := 0;
                        VarVATAmt := 0;
                        VarDOCNOE := "Document No.";

                        VLE.GET(Unpaid."Vendor Ledger Entry No.");
                        VLE.CALCFIELDS(VLE."Original Amt. (LCY)", VLE."Remaining Amt. (LCY)");
                        IF (VLE."Remaining Amt. (LCY)" = 0) THEN
                            CurrReport.SKIP;

                        VarDesc := DELCHR(VLE.Description);
                        //VarDesc := VLE.Description;
                        VarDesc2 := VLE.Description;

                        CLEAR(VarInvoiceNo);
                        VarInvoiceNo := VLE."External Document No.";

                        CLEAR(VarName);
                        //VarName := DELCHR(Vendor.Name,'=','-_+=\|[]âàé}{".,#$@%^&*+!~`:;/?><() ''');
                        VarName := Vendor.Name;


                        //CLEAR(VarPaidAmt);
                        //VarPaidAmt := ROUND(VLE."Remaining Amt. (LCY)", 1, '=');

                        CLEAR(VarPaidAmt);
                        VarPaidAmt := ROUND(Unpaid."Amount (LCY)", 1, '=');


                        if VarPaidAmt > grecPurchPayableSetup."Threshold Goods & Services Rpt" then begin
                            ExcelBuf.NewRow;
                            ExcelBuf.AddColumn(BuildDate(VLE."Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn(VarInvoiceNo, FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn(VarName, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                            IF Vendor.BRN <> '' THEN
                                ExcelBuf.AddColumn(Vendor.BRN, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                            else
                                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                            if Vendor.NID <> '' then
                                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                            else
                                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);


                            ExcelBuf.AddColumn(VarDesc2, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn(VarAmtExclVAT, FALSE, '', FALSE, FALSE, FALSE, '0', ExcelBuf."Cell Type"::Number);
                            ExcelBuf.AddColumn(VarVATAmt, FALSE, '', FALSE, FALSE, FALSE, '0', ExcelBuf."Cell Type"::Number);


                            IF VLE."Document Type" = VLE."Document Type"::"Credit Memo" THEN
                                ExcelBuf.AddColumn(VarPaidAmt, FALSE, '', FALSE, FALSE, FALSE, '0', ExcelBuf."Cell Type"::Number)
                            ELSE
                                ExcelBuf.AddColumn(VarPaidAmt, FALSE, '', FALSE, FALSE, FALSE, '0', ExcelBuf."Cell Type"::Number);

                            IF VLE."Document Type" = VLE."Document Type"::Invoice THEN
                                ExcelBuf.AddColumn('I', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                            IF VLE."Document Type" = VLE."Document Type"::"Credit Memo" THEN
                                ExcelBuf.AddColumn('C', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                            IF VLE."Document Type" = VLE."Document Type"::Payment THEN
                                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                            IF VLE."Document Type" = VLE."Document Type"::" " THEN
                                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        end;
                        /* ExcelBuf.AddColumn(VarDesc2, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(VarDOCNOE, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(VLE."Document Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);*/

                    end;

                    trigger OnPreDataItem()
                    begin
                        CLEAR(VarDesc2);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    // IF "Document Type" = "Document Type"::Payment THEN  BEGIN
                    //   VoidVLE.SETRANGE("Closed by Entry No.","Vendor Ledger Entry"."Entry No.");
                    //   VoidVLE.SETRANGE(VoidVLE."Source Code",'FINVOIDCHK');
                    //   IF VoidVLE.FINDFIRST THEN
                    //     CurrReport.SKIP;
                    //
                    // END;
                end;

                trigger OnPreDataItem()
                begin
                    "Vendor Ledger Entry".SETFILTER("Vendor Ledger Entry"."Posting Date", '%1..%2', StartingDate, EndingDate);
                    CLEAR(COUNTI);
                end;
            }

            trigger OnAfterGetRecord()
            begin

                Window.UPDATE(1, Vendor."No.");

                PaymentAmt := 0;
                CLEAR(VarDOCNOE);

                VLE.RESET;
                VLE.SETCURRENTKEY("Document Type", "Vendor No.", "Posting Date", "Currency Code");
                VLE.SETRANGE(VLE."Document Type", VLE."Document Type"::Payment);
                VLE.SETRANGE(VLE."Vendor No.", Vendor."No.");
                VLE.SETFILTER(VLE."Posting Date", '%1..%2', StartingDate, EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS(VLE."Amount (LCY)");
                        PaymentAmt += VLE."Amount (LCY)";
                        VarDesc2 := DELCHR(VLE.Description, '=', '-_+=\|[]âàé}{".,#$@%^&*+!~`:;/?><() ''');
                    //VarDOCNOE := VLE."Document No."
                    UNTIL VLE.NEXT = 0;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                CLEAR(VarDesc2);
                Vendor.SETFILTER(Vendor."VAT Bus. Posting Group", '<>%1', 'FSUP');
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(StartingDate; StartingDate)
                {
                    Caption = 'Starting Date';
                    ApplicationArea = All;
                }
                field(EndingDate; EndingDate)
                {
                    Caption = 'Ending Date';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    trigger OnPostReport()
    begin
        CreateExcelBook;
    end;

    trigger OnPreReport()
    begin
        //table50060.DELETEALL;
        grecPurchPayableSetup.Get();
    end;

    var
        StartingDate: Date;
        EndingDate: Date;
        VLE: Record 25;
        PaymentAmt: Decimal;
        PurchInvHdr: Record 122;
        PurchCrMemoHdr: Record 124;
        PurchInvLine: Record 123;
        PurchCrMemoLine: Record 125;
        VarDesc: Text;
        VarAmtExclVAT: Decimal;
        VarVATAmt: Decimal;
        VarInvoiceNo: Text;
        VarName: Text;
        VarPaidAmt: Decimal;
        Window: Dialog;
        VLEIn: Record 25;
        GLEntry: Record 17;
        Text000: Label 'Reading Vendor No    #1##########';
        ExcelBuf: Record 370 temporary;
        VarGrossAmtPaid: Decimal;
        VarGrossRemaingAmt: Decimal;
        VLEREMAINING: Record 380;
        VarDesc2: Text;
        //table50060: Record 50030;
        DVLE: Record 380;
        PurchCrMemoHdrr2: Record 124;
        PurchCrMemoLinee2: Record 125;
        VarDOCNOE: Code[20];
        VarGrossAmtPaiddup: Decimal;
        COUNTI: Integer;
        VLE2: Record 25;
        DetailedVendorLedgEntryInitial: Record 380;
        VoidVLE: Record 25;
        grecPurchPayableSetup: Record "Purchases & Payables Setup";

    procedure BuildDate(ParamDate: Date) DateText: Text[8]
    var
        VarMonth: Integer;
        VarMonthTxt: Text[2];
        VarDay: Integer;
        VarDayText: Text[2];
        VarYear: Integer;
        VarYearText: Text[4];
    begin
        CLEAR(VarMonth);
        CLEAR(VarMonthTxt);
        CLEAR(VarDay);
        CLEAR(VarDayText);
        CLEAR(VarYear);
        CLEAR(VarYearText);


        VarDayText := FORMAT(DATE2DMY(ParamDate, 1));
        IF STRLEN(VarDayText) = 1 THEN
            VarDayText := '0' + VarDayText;


        VarMonthTxt := FORMAT(DATE2DMY(ParamDate, 2));
        IF STRLEN(VarMonthTxt) = 1 THEN
            VarMonthTxt := '0' + VarMonthTxt;

        VarYearText := FORMAT(DATE2DMY(ParamDate, 3));

        DateText := VarYearText + VarMonthTxt + VarDayText;
    end;

    local procedure MakeExcelDataHeader()
    begin

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('MRA', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('LCSRTN', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('V1.0', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('TAN of the Company', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('BRN of the Company', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Name of the Company', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Year Ending 30 June', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Telephone Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Mobile Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Name of Declarant', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Email Address', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Company Information".TAN, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Company Information".BRN, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Company Information".Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(DATE2DMY(EndingDate, 3), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Company Information"."Telephone Number", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Company Information"."Mobile Number", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Company Information"."Name of Declarant", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Company Information"."MRA VAT Email Address", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Date of Invoice', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Supplier''s' + ' Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Supplier''s ' + 'Business Registration Number(BRN)', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Supplier''s ' + 'National Identity Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Description of Goods/Services', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoiced Amount Exclusive of VAT(Rs)', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoiced Amount of VAT(Rs)', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Paid Amount(Rs)', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        //new fields to be added Labelling Start
        /* 
        ExcelBuf.AddColumn('Payment Description', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Supplier VAT No', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Supplier Address', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Supplier Address 2', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Supplier City', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Payment Doc No', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); */
        //new fields to be added Labelling End
    end;

    local procedure CreateExcelBook()
    begin
        ExcelBuf.CreateBookAndOpenExcel('', 'Goods & Services', '', COMPANYNAME, USERID);
    end;

    local procedure CheckSkip(): Boolean
    var
        SkipRecord: Boolean;
        DetailedVendorLedgEntry: Record 380;
        PaymentVendorLedgerEntry: Record 25;
    begin
        SkipRecord := FALSE;
        DetailedVendorLedgEntry.RESET;
        WITH DetailedVendorLedgEntry DO BEGIN
            IF "Detailed Vendor Ledg. Entry"."Transaction No." = 0 THEN BEGIN
                SETCURRENTKEY("Application No.", "Vendor No.", "Entry Type");
                SETRANGE("Application No.", "Detailed Vendor Ledg. Entry"."Application No.");
            END ELSE BEGIN
                SETCURRENTKEY("Transaction No.", "Vendor No.", "Entry Type");
                SETRANGE("Transaction No.", "Detailed Vendor Ledg. Entry"."Transaction No.");
            END;
            SETRANGE("Entry No.", "Detailed Vendor Ledg. Entry"."Entry No.");
            SETRANGE("Entry Type", "Entry Type"::Application);
            SETRANGE("Initial Document Type", DetailedVendorLedgEntry."Initial Document Type"::Payment);
            //SETRANGE(Unapplied,FALSE);
            SETRANGE(Unapplied, FALSE);
            DetailedVendorLedgEntryInitial.RESET;
            DetailedVendorLedgEntryInitial.SETRANGE("Vendor Ledger Entry No.", "Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.");
            DetailedVendorLedgEntryInitial.SETRANGE(DetailedVendorLedgEntryInitial."Document Type", DetailedVendorLedgEntryInitial."Document Type"::Payment);
            DetailedVendorLedgEntryInitial.SETRANGE(Unapplied, FALSE);
            IF "Vendor Ledger Entry".GetFilter("Amount (LCY)") <> '' then begin
                SetFilter("Amount (LCY)", "Vendor Ledger Entry".GetFilter("Amount (LCY)"));
            end;
            IF DetailedVendorLedgEntryInitial.FINDFIRST THEN
                SETFILTER("Initial Document Type", '%1|%2', DetailedVendorLedgEntry."Initial Document Type"::Payment, DetailedVendorLedgEntry."Initial Document Type"::Invoice);
            //SETFILTER("Source Code",'<>%1','FINVOIDCHK');
            IF NOT FIND('-') THEN
                SkipRecord := TRUE
        END;


        IF NOT SkipRecord THEN
            EXIT(FALSE);


        DetailedVendorLedgEntry.RESET;
        WITH DetailedVendorLedgEntry DO BEGIN
            IF "Detailed Vendor Ledg. Entry"."Transaction No." = 0 THEN BEGIN
                SETCURRENTKEY("Application No.", "Vendor No.", "Entry Type");
                SETRANGE("Application No.", "Detailed Vendor Ledg. Entry"."Application No.");
            END ELSE BEGIN
                SETCURRENTKEY("Transaction No.", "Vendor No.", "Entry Type");
                SETRANGE("Transaction No.", "Detailed Vendor Ledg. Entry"."Transaction No.");
            END;
            SETRANGE("Entry No.", "Detailed Vendor Ledg. Entry"."Entry No.");
            SETRANGE("Entry Type", "Entry Type"::Application);
            SETRANGE(Unapplied, FALSE);
            SETRANGE("Document Type", DetailedVendorLedgEntry."Document Type"::Payment);
            IF "Vendor Ledger Entry".GetFilter("Amount (LCY)") <> '' then begin
                SetFilter("Amount (LCY)", "Vendor Ledger Entry".GetFilter("Amount (LCY)"));
            end;
            //SETFILTER("Source Code",'<>%1','FINVOIDCHK');
            IF NOT FIND('-') THEN
                SkipRecord := TRUE
            ELSE
                SkipRecord := FALSE;
        END;


        IF NOT SkipRecord THEN
            EXIT(FALSE);


        DetailedVendorLedgEntry.RESET;
        WITH DetailedVendorLedgEntry DO BEGIN
            IF "Detailed Vendor Ledg. Entry"."Transaction No." = 0 THEN BEGIN
                SETCURRENTKEY("Application No.", "Vendor No.", "Entry Type");
                SETRANGE("Application No.", "Detailed Vendor Ledg. Entry"."Application No.");
            END ELSE BEGIN
                SETCURRENTKEY("Transaction No.", "Vendor No.", "Entry Type");
                SETRANGE("Transaction No.", "Detailed Vendor Ledg. Entry"."Transaction No.");
            END;
            SETRANGE("Entry No.", "Detailed Vendor Ledg. Entry"."Entry No.");
            SETRANGE("Entry Type", "Entry Type"::Application);
            SETRANGE(Unapplied, FALSE);
            SETRANGE("Source Code", 'PAYMENTJNL');
            IF "Vendor Ledger Entry".GetFilter("Amount (LCY)") <> '' then begin
                SetFilter("Amount (LCY)", "Vendor Ledger Entry".GetFilter("Amount (LCY)"));
            end;
            IF FINDSET THEN
                REPEAT
                    IF PaymentVendorLedgerEntry.GET("Applied Vend. Ledger Entry No.") AND
                      (PaymentVendorLedgerEntry."Bal. Account Type" = PaymentVendorLedgerEntry."Bal. Account Type"::"Bank Account") THEN
                        SkipRecord := FALSE;

                UNTIL NEXT = 0;
        END;
        EXIT(SkipRecord);
    end;
}

