report 50046 "Aged Accounts Payable VPG"
{
    RDLCLayout = 'Report\Layout\Aged Accounts Payable2.rdl';
    ApplicationArea = All;
    Caption = 'Aged Accounts Payable by Vendor Posting Group';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Vendor Posting Group";//RCTS1.0 15/07/19 - Added Vendor Posting Group
            column(TodayFormatted; TodayFormatted)
            {
            }
            column(CompanyName; CompanyDisplayName)
            {
            }
            column(NewPagePerVendor; NewPagePerVendor)
            {
            }
            column(AgesAsOfEndingDate; STRSUBSTNO(Text006, FORMAT(EndingDate, 0, 4)))
            {
            }
            column(SelectAgeByDuePostngDocDt; STRSUBSTNO(Text007, SELECTSTR(AgingBy + 1, Text009)))
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(CaptionVendorFilter; TABLECAPTION + ': ' + VendorFilter)
            {
            }
            column(gtextCustLedgerEntryFilter; 'Vendor Ledger Entry' + ': ' + gtextVendLedgerEntryFilter) { }
            column(VendorFilter; VendorFilter)
            {
            }
            column(AgingBy; AgingBy)
            {
            }
            column(SelctAgeByDuePostngDocDt1; STRSUBSTNO(Text004, SELECTSTR(AgingBy + 1, Text009)))
            {
            }
            column(HeaderText7; HeaderText[7])
            {
            }
            column(HeaderText6; HeaderText[6])
            {
            }
            column(HeaderText5; HeaderText[5])
            {
            }
            column(HeaderText4; HeaderText[4])
            {
            }
            column(HeaderText3; HeaderText[3])
            {
            }
            column(HeaderText2; HeaderText[2])
            {
            }
            column(HeaderText1; HeaderText[1])
            {
            }
            column(PrintDetails; PrintDetails)
            {
            }
            column(GrandTotalVLE7RemAmtLCY; GrandTotalVLERemaingAmtLCY[7])
            {
                AutoFormatType = 1;
            }
            column(GrandTotalVLE6RemAmtLCY; GrandTotalVLERemaingAmtLCY[6])
            {
                AutoFormatType = 1;
            }
            column(GrandTotalVLE5RemAmtLCY; GrandTotalVLERemaingAmtLCY[5])
            {
                AutoFormatType = 1;
            }
            column(GrandTotalVLE4RemAmtLCY; GrandTotalVLERemaingAmtLCY[4])
            {
                AutoFormatType = 1;
            }
            column(GrandTotalVLE3RemAmtLCY; GrandTotalVLERemaingAmtLCY[3])
            {
                AutoFormatType = 1;
            }
            column(GrandTotalVLE2RemAmtLCY; GrandTotalVLERemaingAmtLCY[2])
            {
                AutoFormatType = 1;
            }
            column(GrandTotalVLE1RemAmtLCY; GrandTotalVLERemaingAmtLCY[1])
            {
                AutoFormatType = 1;
            }
            column(GrandTotalVLE1AmtLCY; GrandTotalVLEAmtLCY)
            {
                AutoFormatType = 1;
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(No_Vendor; "No.")
            {
            }
            column(AgedAcctPayableCaption; AgedAcctPayableCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(AllAmtsinLCYCaption; AllAmtsinLCYCaptionLbl)
            {
            }
            column(AgedOverdueAmsCaption; AgedOverdueAmsCaptionLbl)
            {
            }
            column(GrandTotalVLE5RemAmtLCYCaption; GrandTotalVLE5RemAmtLCYCaptionLbl)
            {
            }
            column(AmountLCYCaption; AmountLCYCaptionLbl)
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(DocumentNoCaption; DocumentNoCaptionLbl)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(DocumentTypeCaption; DocumentTypeCaptionLbl)
            {
            }
            column(VendorNoCaption; FIELDCAPTION("No."))
            {
            }
            column(VendorNameCaption; FIELDCAPTION(Name))
            {
            }
            column(CurrencyCaption; CurrencyCaptionLbl)
            {
            }
            column(TotalLCYCaption; TotalLCYCaptionLbl)
            {
            }
            column(goptGroupBy; goptGroupBy) { }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code");
                PrintOnlyIfDetail = true;
                //RequestFilterFields = "Global Dimension 1 Code"; //RCTS1.0 15/07/19
                trigger OnAfterGetRecord()
                var
                    VendorLedgEntry: Record "Vendor Ledger Entry";
                begin
                    VendorLedgEntry.SETCURRENTKEY("Closed by Entry No.");
                    VendorLedgEntry.SETRANGE("Closed by Entry No.", "Entry No.");
                    VendorLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    CopyDimFiltersFromVendor(VendorLedgEntry);
                    IF VendorLedgEntry.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            InsertTemp(VendorLedgEntry);
                        UNTIL VendorLedgEntry.NEXT = 0;

                    IF "Closed by Entry No." <> 0 THEN BEGIN
                        VendorLedgEntry.SETRANGE("Closed by Entry No.", "Closed by Entry No.");
                        IF VendorLedgEntry.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                InsertTemp(VendorLedgEntry);
                            UNTIL VendorLedgEntry.NEXT = 0;
                    END;

                    VendorLedgEntry.RESET;
                    VendorLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                    VendorLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    CopyDimFiltersFromVendor(VendorLedgEntry);
                    IF VendorLedgEntry.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            InsertTemp(VendorLedgEntry);
                        UNTIL VendorLedgEntry.NEXT = 0;
                    CurrReport.SKIP;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", EndingDate + 1, DMY2DATE(31, 12, 9999));
                    CopyDimFiltersFromVendor("Vendor Ledger Entry");
                end;
            }
            dataitem(OpenVendorLedgEntry; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("Vendor No.", Open, Positive, "Due Date", "Currency Code");
                RequestFilterFields = "Global Dimension 1 Code", "Vendor Posting Group"; //RCTS1.0 15/07/19
                PrintOnlyIfDetail = true;

                trigger OnAfterGetRecord()
                begin
                    IF AgingBy = AgingBy::"Posting Date" THEN BEGIN
                        CALCFIELDS("Remaining Amt. (LCY)");
                        IF "Remaining Amt. (LCY)" = 0 THEN
                            CurrReport.SKIP;
                    END;
                    InsertTemp(OpenVendorLedgEntry);
                    CurrReport.SKIP;
                end;

                trigger OnPreDataItem()
                begin
                    IF AgingBy = AgingBy::"Posting Date" THEN BEGIN
                        SETRANGE("Posting Date", 0D, EndingDate);
                        SETRANGE("Date Filter", 0D, EndingDate);
                    END;
                    CopyDimFiltersFromVendor(OpenVendorLedgEntry);

                    //RCTS1.0 27/11/19
                    FilterfromVendorLedgerEntry := OpenVendorLedgEntry.GETVIEW();
                    //RCTS1.0 27/11/19

                end;
            }
            dataitem(CurrencyLoop; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1 ..));
                PrintOnlyIfDetail = true;
                dataitem(TempVendortLedgEntryLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    column(VendorName; Vendor.Name)
                    {
                    }
                    column(VendorNo; Vendor."No.")
                    {
                    }
                    column(VLEEndingDateRemAmtLCY; VendorLedgEntryEndingDate."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedVLE1RemAmtLCY; AgedVendorLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt2RemAmtLCY; AgedVendorLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt3RemAmtLCY; AgedVendorLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt4RemAmtLCY; AgedVendorLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt5RemAmtLCY; AgedVendorLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt6RemAmtLCY; AgedVendorLedgEntry[6]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt7RemAmtLCY; AgedVendorLedgEntry[7]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(VendLedgEntryEndDtAmtLCY; VendorLedgEntryEndingDate."Amount (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(VendLedgEntryEndDtDueDate; FORMAT(VendorLedgEntryEndingDate."Due Date"))
                    {
                    }
                    column(VendLedgEntryEndDtDocNo; VendorLedgEntryEndingDate."Document No.")
                    {
                    }
                    column(VendLedgEntyEndgDtDocType; FORMAT(VendorLedgEntryEndingDate."Document Type"))
                    {
                    }
                    column(VendLedgEntryEndDtPostgDt; FORMAT(VendorLedgEntryEndingDate."Posting Date"))
                    {
                    }
                    column(AgedVendLedgEnt7RemAmt; AgedVendorLedgEntry[7]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt6RemAmt; AgedVendorLedgEntry[6]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt5RemAmt; AgedVendorLedgEntry[5]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt4RemAmt; AgedVendorLedgEntry[4]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt3RemAmt; AgedVendorLedgEntry[3]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt2RemAmt; AgedVendorLedgEntry[2]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt1RemAmt; AgedVendorLedgEntry[1]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(VLEEndingDateRemAmt; VendorLedgEntryEndingDate."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(VendLedgEntryEndingDtAmt; VendorLedgEntryEndingDate.Amount)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(TotalVendorName; STRSUBSTNO(Text005, Vendor.Name))
                    {
                    }
                    column(CurrCode_TempVenLedgEntryLoop; CurrencyCode)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(VendorPostingGrp; gtextGrpBy) { }

                    trigger OnAfterGetRecord()
                    var
                        PeriodIndex: Integer;
                    begin
                        IF Number = 1 THEN BEGIN
                            IF NOT TempVendorLedgEntry.FINDSET(FALSE, FALSE) THEN
                                CurrReport.BREAK;
                        END ELSE
                            IF TempVendorLedgEntry.NEXT = 0 THEN
                                CurrReport.BREAK;

                        VendorLedgEntryEndingDate := TempVendorLedgEntry;
                        DetailedVendorLedgerEntry.SETRANGE("Vendor Ledger Entry No.", VendorLedgEntryEndingDate."Entry No.");
                        IF DetailedVendorLedgerEntry.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                IF (DetailedVendorLedgerEntry."Entry Type" =
                                    DetailedVendorLedgerEntry."Entry Type"::"Initial Entry") AND
                                   (VendorLedgEntryEndingDate."Posting Date" > EndingDate) AND
                                   (AgingBy <> AgingBy::"Posting Date")
                                THEN BEGIN
                                    IF VendorLedgEntryEndingDate."Document Date" <= EndingDate THEN
                                        DetailedVendorLedgerEntry."Posting Date" :=
                                          VendorLedgEntryEndingDate."Document Date"
                                    ELSE
                                        IF (VendorLedgEntryEndingDate."Due Date" <= EndingDate) AND
                                           (AgingBy = AgingBy::"Due Date")
                                        THEN
                                            DetailedVendorLedgerEntry."Posting Date" :=
                                              VendorLedgEntryEndingDate."Due Date"
                                END;

                                IF (DetailedVendorLedgerEntry."Posting Date" <= EndingDate) OR
                                   (TempVendorLedgEntry.Open AND
                                    (AgingBy = AgingBy::"Due Date") AND
                                    (VendorLedgEntryEndingDate."Due Date" > EndingDate) AND
                                    (VendorLedgEntryEndingDate."Posting Date" <= EndingDate))
                                THEN BEGIN
                                    IF DetailedVendorLedgerEntry."Entry Type" IN
                                       [DetailedVendorLedgerEntry."Entry Type"::"Initial Entry",
                                        DetailedVendorLedgerEntry."Entry Type"::"Unrealized Loss",
                                        DetailedVendorLedgerEntry."Entry Type"::"Unrealized Gain",
                                        DetailedVendorLedgerEntry."Entry Type"::"Realized Loss",
                                        DetailedVendorLedgerEntry."Entry Type"::"Realized Gain",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Discount",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Discount (VAT Excl.)",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Discount (VAT Adjustment)",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Tolerance",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Discount Tolerance",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Tolerance (VAT Excl.)",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Tolerance (VAT Adjustment)",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)"]
                                    THEN BEGIN
                                        VendorLedgEntryEndingDate.Amount := VendorLedgEntryEndingDate.Amount + DetailedVendorLedgerEntry.Amount;
                                        VendorLedgEntryEndingDate."Amount (LCY)" :=
                                          VendorLedgEntryEndingDate."Amount (LCY)" + DetailedVendorLedgerEntry."Amount (LCY)";
                                    END;
                                    IF DetailedVendorLedgerEntry."Posting Date" <= EndingDate THEN BEGIN
                                        VendorLedgEntryEndingDate."Remaining Amount" :=
                                          VendorLedgEntryEndingDate."Remaining Amount" + DetailedVendorLedgerEntry.Amount;
                                        VendorLedgEntryEndingDate."Remaining Amt. (LCY)" :=
                                          VendorLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedVendorLedgerEntry."Amount (LCY)";
                                    END;
                                END;
                            UNTIL DetailedVendorLedgerEntry.NEXT = 0;

                        IF VendorLedgEntryEndingDate."Remaining Amount" = 0 THEN
                            CurrReport.SKIP;

                        CASE AgingBy OF
                            AgingBy::"Due Date":
                                PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Due Date");
                            AgingBy::"Posting Date":
                                PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Posting Date");
                            AgingBy::"Document Date":
                                BEGIN
                                    IF VendorLedgEntryEndingDate."Document Date" > EndingDate THEN BEGIN
                                        VendorLedgEntryEndingDate."Remaining Amount" := 0;
                                        VendorLedgEntryEndingDate."Remaining Amt. (LCY)" := 0;
                                        VendorLedgEntryEndingDate."Document Date" := VendorLedgEntryEndingDate."Posting Date";
                                    END;
                                    PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Document Date");
                                END;
                        END;
                        CLEAR(AgedVendorLedgEntry);
                        AgedVendorLedgEntry[PeriodIndex]."Remaining Amount" := VendorLedgEntryEndingDate."Remaining Amount";
                        AgedVendorLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" := VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalVendorLedgEntry[PeriodIndex]."Remaining Amount" += VendorLedgEntryEndingDate."Remaining Amount";
                        TotalVendorLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalVLERemaingAmtLCY[PeriodIndex] += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalVendorLedgEntry[1].Amount += VendorLedgEntryEndingDate."Remaining Amount";
                        TotalVendorLedgEntry[1]."Amount (LCY)" += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalVLEAmtLCY += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";

                        //RCTS1.0 13/04/2020
                        case goptGroupBy of
                            goptGroupBy::"Vendor Posting Group":
                                gtextGrpBy := VendorLedgEntryEndingDate."Vendor Posting Group";

                        /* goptGroupBy::Department:
                            gtextGrpBy := VendorLedgEntryEndingDate."Global Dimension 1 Code"; */
                        end;
                        //RCTS1.0 13/04/2020
                    end;

                    trigger OnPostDataItem()
                    begin
                        IF NOT PrintAmountInLCY THEN
                            UpdateCurrencyTotals;
                    end;

                    trigger OnPreDataItem()
                    begin

                        //RCTS1.0 27/11/19

                        //RCTS1.0 22/07/19
                        //TempVendorLedgEntry.COPYFILTERS(OpenVendorLedgEntry);
                        //RCTS1.0 22/07/19

                        IF FilterfromVendorLedgerEntry <> '' THEN
                            TempVendorLedgEntry.SETVIEW(FilterfromVendorLedgerEntry);
                        //RCTS1.0 27/11/19

                        IF NOT PrintAmountInLCY THEN
                            TempVendorLedgEntry.SETRANGE("Currency Code", TempCurrency.Code);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(TotalVendorLedgEntry);

                    IF Number = 1 THEN BEGIN
                        IF NOT TempCurrency.FINDSET(FALSE, FALSE) THEN
                            CurrReport.BREAK;
                    END ELSE
                        IF TempCurrency.NEXT = 0 THEN
                            CurrReport.BREAK;

                    IF TempCurrency.Code <> '' THEN
                        CurrencyCode := TempCurrency.Code
                    ELSE
                        CurrencyCode := GLSetup."LCY Code";

                    NumberOfCurrencies := NumberOfCurrencies + 1;
                end;

                trigger OnPostDataItem()
                begin
                    IF NewPagePerVendor AND (NumberOfCurrencies > 0) THEN
                        CurrReport.NEWPAGE;
                end;

                trigger OnPreDataItem()
                begin
                    NumberOfCurrencies := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF NewPagePerVendor THEN
                    PageGroupNo := PageGroupNo + 1;

                TempCurrency.RESET;
                TempCurrency.DELETEALL;
                TempVendorLedgEntry.RESET;
                TempVendorLedgEntry.DELETEALL;
                CLEAR(GrandTotalVLERemaingAmtLCY);
                GrandTotalVLEAmtLCY := 0;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
            end;
        }
        dataitem(CurrencyTotals; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = FILTER(1 ..));
            column(Number_CurrencyTotals; Number)
            {
            }
            column(NewPagePerVend_CurrTotal; NewPagePerVendor)
            {
            }
            column(TempCurrency2Code; TempCurrency2.Code)
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt8RemAmtLCY7; AgedVendorLedgEntry[8]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt7RemAmtLCY7; AgedVendorLedgEntry[7]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt6RemAmtLCY6; AgedVendorLedgEntry[6]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt1RemAmtLCY1; AgedVendorLedgEntry[1]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt2RemAmtLCY2; AgedVendorLedgEntry[2]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt3RemAmtLCY3; AgedVendorLedgEntry[3]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt4RemAmtLCY4; AgedVendorLedgEntry[4]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt5RemAmtLCY5; AgedVendorLedgEntry[5]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(CurrencySpecificationCaption; CurrencySpecificationCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN BEGIN
                    IF NOT TempCurrency2.FINDSET(FALSE, FALSE) THEN
                        CurrReport.BREAK;
                END ELSE
                    IF TempCurrency2.NEXT = 0 THEN
                        CurrReport.BREAK;

                CLEAR(AgedVendorLedgEntry);
                TempCurrencyAmount.SETRANGE("Currency Code", TempCurrency2.Code);
                IF TempCurrencyAmount.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        IF TempCurrencyAmount.Date <> DMY2DATE(31, 12, 9999) THEN
                            AgedVendorLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount" :=
                              TempCurrencyAmount.Amount
                        ELSE
                            AgedVendorLedgEntry[8]."Remaining Amount" := TempCurrencyAmount.Amount;
                    UNTIL TempCurrencyAmount.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 0;
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
                group(Options)
                {
                    Caption = 'Options';
                    field("Group By"; goptGroupBy) { ApplicationArea = All; }
                    field(AgedAsOf; EndingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Aged As Of';
                        ToolTip = 'Specifies the date that you want the aging calculated for.';
                    }
                    field(AgingBy; AgingBy)
                    {
                        ApplicationArea = All;
                        Caption = 'Aging by';
                        OptionCaption = 'Due Date,Posting Date,Document Date';
                        ToolTip = 'Specifies if the aging will be calculated from the due date, the posting date, or the document date.';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = All;
                        Caption = 'Period Length';
                        ToolTip = 'Specifies the period for which data is shown in the report. For example, enter "1M" for one month, "30D" for thirty days, "3Q" for three quarters, or "5Y" for five years.';
                        Visible = false;
                    }
                    field(PrintAmountInLCY; PrintAmountInLCY)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Amounts in LCY';
                        ToolTip = 'Specifies if you want the report to specify the aging per vendor ledger entry.';
                    }
                    field(PrintDetails; PrintDetails)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Details';
                        ToolTip = 'Specifies if you want the report to show the detailed entries that add up the total balance for each vendor.';
                    }
                    field(HeadingType; HeadingType)
                    {
                        ApplicationArea = All;
                        Caption = 'Heading Type';
                        OptionCaption = 'Date Interval,Number of Days';
                        ToolTip = 'Specifies if the column heading for the three periods will indicate a date interval or the number of days overdue.';
                    }
                    field(NewPagePerVendor; NewPagePerVendor)
                    {
                        ApplicationArea = All;
                        Caption = 'New Page per Vendor';
                        ToolTip = 'Specifies if each vendor''s information is printed on a new page if you have chosen two or more vendors to be included in the report.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF EndingDate = 0D THEN
                EndingDate := WORKDATE;
            IF FORMAT(PeriodLength) = '' THEN
                EVALUATE(PeriodLength, '<1M>');
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        CaptionManagement: Codeunit "Format Document";
    begin
        VendorFilter := CaptionManagement.GetRecordFiltersWithCaptions(Vendor);
        gtextVendLedgerEntryFilter := CaptionManagement.GetRecordFiltersWithCaptions(OpenVendorLedgEntry);

        GLSetup.GET;

        CalcDates;
        CreateHeadings;

        TodayFormatted := TypeHelper.GetFormattedCurrentDateTimeInUserTimeZone('f');
        CompanyDisplayName := COMPANYPROPERTY.DISPLAYNAME;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        TempVendorLedgEntry: Record "Vendor Ledger Entry" temporary;
        VendorLedgEntryEndingDate: Record "Vendor Ledger Entry";
        TotalVendorLedgEntry: array[7] of Record "Vendor Ledger Entry";
        AgedVendorLedgEntry: array[8] of Record "Vendor Ledger Entry";
        TempCurrency: Record Currency temporary;
        TempCurrency2: Record Currency temporary;
        TempCurrencyAmount: Record "Currency Amount" temporary;
        DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        TypeHelper: Codeunit "Type Helper";
        GrandTotalVLERemaingAmtLCY: array[7] of Decimal;
        GrandTotalVLEAmtLCY: Decimal;
        VendorFilter: Text;
        PrintAmountInLCY: Boolean;
        EndingDate: Date;
        AgingBy: Option "Due Date","Posting Date","Document Date";
        PeriodLength: DateFormula;
        PrintDetails: Boolean;
        HeadingType: Option "Date Interval","Number of Days";
        NewPagePerVendor: Boolean;
        PeriodStartDate: array[7] of Date;
        PeriodEndDate: array[7] of Date;
        HeaderText: array[7] of Text[30];
        Text000: Label 'Not Due';
        Text001: Label 'Before';
        CurrencyCode: Code[10];
        Text002: Label 'days';
        Text003: Label 'More than';
        Text004: Label 'Aged by %1';
        Text005: Label 'Total for %1';
        Text006: Label 'Aged as of %1';
        Text007: Label 'Aged by %1';
        NumberOfCurrencies: Integer;
        Text009: Label 'Due Date,Posting Date,Document Date';
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it, for example, by using 1M+CM instead of CM+1M.';
        PageGroupNo: Integer;
        EnterDateFormulaErr: Label 'Enter a date formula in the Period Length field.';
        Text027: Label '-%1', Comment = 'Negating the period length: %1 is the period length';
        AgedAcctPayableCaptionLbl: Label 'Aged Accounts Payable by Vendor Posting Group';
        CurrReportPageNoCaptionLbl: Label 'Page';
        AllAmtsinLCYCaptionLbl: Label 'All Amounts in LCY';
        AgedOverdueAmsCaptionLbl: Label 'Aged Overdue Amounts';
        GrandTotalVLE5RemAmtLCYCaptionLbl: Label 'Balance';
        AmountLCYCaptionLbl: Label 'Original Amount';
        DueDateCaptionLbl: Label 'Due Date';
        DocumentNoCaptionLbl: Label 'Document No.';
        PostingDateCaptionLbl: Label 'Posting Date';
        DocumentTypeCaptionLbl: Label 'Document Type';
        CurrencyCaptionLbl: Label 'Currency Code';
        TotalLCYCaptionLbl: Label 'Total (LCY)';
        CurrencySpecificationCaptionLbl: Label 'Currency Specification';
        TodayFormatted: Text;
        CompanyDisplayName: Text;
        FilterfromVendorLedgerEntry: Text;
        gtextVendLedgerEntryFilter: Text;
        goptGroupBy: Option "Vendor Posting Group";
        gtextGrpBy: Text;

    local procedure CalcDates()
    var
        i: Integer;
        PeriodLength2: DateFormula;
    begin
        //RCTS1.0 01/07/19
        /* IF NOT EVALUATE(PeriodLength2, STRSUBSTNO(Text027, PeriodLength)) THEN
            ERROR(EnterDateFormulaErr); */
        IF NOT EVALUATE(PeriodLength2, '<-30D>') then
            ERROR(EnterDateFormulaErr);
        //RCTS1.0 01/07/19
        IF AgingBy = AgingBy::"Due Date" THEN BEGIN
            PeriodEndDate[1] := DMY2DATE(31, 12, 9999);
            PeriodStartDate[1] := EndingDate + 1;
        END ELSE BEGIN
            PeriodEndDate[1] := EndingDate;
            PeriodStartDate[1] := CALCDATE(PeriodLength2, EndingDate + 1);
        END;
        FOR i := 2 TO ARRAYLEN(PeriodEndDate) DO BEGIN
            //RCTS1.0 01/07/19
            IF AgingBy = AgingBy::"Posting Date" THEN BEGIN
                IF i = 4 THEN
                    EVALUATE(PeriodLength2, '<-90D>');
                IF i >= 5 THEN
                    // EVALUATE(PeriodLength2, '<-180D>');
                    EVALUATE(PeriodLength2, '<-185D>');
            END;
            IF AgingBy = AgingBy::"Due Date" THEN BEGIN
                IF i = 5 THEN
                    EVALUATE(PeriodLength2, '<-90D>');
                IF i = 6 THEN
                    //EVALUATE(PeriodLength2, '<-180D>');
                    EVALUATE(PeriodLength2, '<-185D>');
            END;
            //RCTS1.0 01/07/19 
            PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
            PeriodStartDate[i] := CALCDATE(PeriodLength2, PeriodEndDate[i] + 1);
        END;

        i := ARRAYLEN(PeriodEndDate);

        PeriodStartDate[i] := 0D;

        FOR i := 1 TO ARRAYLEN(PeriodEndDate) DO
            IF PeriodEndDate[i] < PeriodStartDate[i] THEN
                ERROR(Text010, PeriodLength);
    end;

    local procedure CreateHeadings()
    var
        i: Integer;
    begin
        IF AgingBy = AgingBy::"Due Date" THEN BEGIN
            HeaderText[1] := Text000;
            i := 2;
        END ELSE
            i := 1;
        WHILE i < ARRAYLEN(PeriodEndDate) DO BEGIN
            IF HeadingType = HeadingType::"Date Interval" THEN
                HeaderText[i] := STRSUBSTNO('%1\..%2', PeriodStartDate[i], PeriodEndDate[i])
            ELSE
                HeaderText[i] :=
                  STRSUBSTNO('%1 - %2 %3', EndingDate - PeriodEndDate[i] + 1, EndingDate - PeriodStartDate[i] + 1, Text002);
            i := i + 1;
        END;
        IF HeadingType = HeadingType::"Date Interval" THEN
            HeaderText[i] := STRSUBSTNO('%1\%2', Text001, PeriodStartDate[i - 1])
        ELSE
            HeaderText[i] := STRSUBSTNO('%1\%2 %3', Text003, EndingDate - PeriodStartDate[i - 1] + 1, Text002);
    end;

    local procedure InsertTemp(var VendorLedgEntry: Record "Vendor Ledger Entry")
    var
        Currency: Record Currency;
    begin
        WITH TempVendorLedgEntry DO BEGIN
            IF GET(VendorLedgEntry."Entry No.") THEN
                EXIT;
            TempVendorLedgEntry := VendorLedgEntry;
            INSERT;
            IF PrintAmountInLCY THEN BEGIN
                CLEAR(TempCurrency);
                TempCurrency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
                IF TempCurrency.INSERT THEN;
                EXIT;
            END;
            IF TempCurrency.GET("Currency Code") THEN
                EXIT;
            IF "Currency Code" <> '' THEN
                Currency.GET("Currency Code")
            ELSE BEGIN
                CLEAR(Currency);
                Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
            END;
            TempCurrency := Currency;
            TempCurrency.INSERT;
        END;
    end;

    local procedure GetPeriodIndex(Date: Date): Integer
    var
        i: Integer;
    begin
        FOR i := 1 TO ARRAYLEN(PeriodEndDate) DO
            IF Date IN [PeriodStartDate[i] .. PeriodEndDate[i]] THEN
                EXIT(i);
    end;

    local procedure UpdateCurrencyTotals()
    var
        i: Integer;
    begin
        TempCurrency2.Code := CurrencyCode;
        IF TempCurrency2.INSERT THEN;
        WITH TempCurrencyAmount DO BEGIN
            FOR i := 1 TO ARRAYLEN(TotalVendorLedgEntry) DO BEGIN
                "Currency Code" := CurrencyCode;
                Date := PeriodStartDate[i];
                IF FIND THEN BEGIN
                    Amount := Amount + TotalVendorLedgEntry[i]."Remaining Amount";
                    MODIFY;
                END ELSE BEGIN
                    "Currency Code" := CurrencyCode;
                    Date := PeriodStartDate[i];
                    Amount := TotalVendorLedgEntry[i]."Remaining Amount";
                    INSERT;
                END;
            END;
            "Currency Code" := CurrencyCode;
            Date := DMY2DATE(31, 12, 9999);
            IF FIND THEN BEGIN
                Amount := Amount + TotalVendorLedgEntry[1].Amount;
                MODIFY;
            END ELSE BEGIN
                "Currency Code" := CurrencyCode;
                Date := DMY2DATE(31, 12, 9999);
                Amount := TotalVendorLedgEntry[1].Amount;
                INSERT;
            END;
        END;
    end;

    [Scope('Personalization')]
    procedure InitializeRequest(NewEndingDate: Date; NewAgingBy: Option; NewPeriodLength: DateFormula; NewPrintAmountInLCY: Boolean; NewPrintDetails: Boolean; NewHeadingType: Option; NewNewPagePerVendor: Boolean)
    begin
        EndingDate := NewEndingDate;
        AgingBy := NewAgingBy;
        PeriodLength := NewPeriodLength;
        PrintAmountInLCY := NewPrintAmountInLCY;
        PrintDetails := NewPrintDetails;
        HeadingType := NewHeadingType;
        NewPagePerVendor := NewNewPagePerVendor;
    end;

    local procedure CopyDimFiltersFromVendor(var VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        IF Vendor.GETFILTER("Global Dimension 1 Filter") <> '' THEN
            VendorLedgerEntry.SETFILTER("Global Dimension 1 Code", Vendor.GETFILTER("Global Dimension 1 Filter"));
        IF Vendor.GETFILTER("Global Dimension 2 Filter") <> '' THEN
            VendorLedgerEntry.SETFILTER("Global Dimension 2 Code", Vendor.GETFILTER("Global Dimension 2 Filter"));
    end;
}

