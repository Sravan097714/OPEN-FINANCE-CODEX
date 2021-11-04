report 50006 "Output VAT copy"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\OutputVATCopy.rdl';
    Caption = 'Output VAT Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("VAT Entry"; "VAT Entry")
        {
            DataItemTableView = WHERE(Type = FILTER(Sale));
            RequestFilterFields = "Posting Date";
            column(CompanyName; COMPANYNAME)
            {
            }
            column(Filter1_VatEntry; TABLECAPTION + ': ' + VATEntryFilter)
            {
            }
            column(MinVatDifference; MinVATDifference)
            {
                AutoFormatExpression = GetCurrency;
                AutoFormatType = 1;
            }
            column(MinVatDiffText; MinVATDiffText)
            {
            }
            column(AddCurrAmt_VatEntry; AddCurrAmtTxt)
            {
            }
            column(PostingDate_VatEntry; FORMAT("Posting Date"))
            {
            }
            column(DocumentType_VatEntry; "Document Type")
            {
            }
            column(DocumentNo_VatEntry; "Document No.")
            {
                IncludeCaption = true;
            }
            column(Type_VatEntry; Type)
            {
                IncludeCaption = true;
            }
            column(GenBusPostGrp_VatEntry; "Gen. Bus. Posting Group")
            {
            }
            column(GenProdPostGrp_VatEntry; "Gen. Prod. Posting Group")
            {
            }
            column(VATProdPostingGrp_VatEntry; "VAT Prod. Posting Group")
            {
            }
            column(Base_VatEntry; Base)
            {
                AutoFormatExpression = GetCurrency;
                AutoFormatType = 1;
                IncludeCaption = true;
            }
            column(Amount_VatEntry; Amount)
            {
                AutoFormatExpression = GetCurrency;
                AutoFormatType = 1;
                IncludeCaption = true;
            }
            column(VatCalType_VatEntry; "VAT Calculation Type")
            {
            }
            column(BillToPay_VatEntry; "Bill-to/Pay-to No.")
            {
                IncludeCaption = true;
            }
            column(Eu3PartyTrade_VatEntry; FORMAT("EU 3-Party Trade"))
            {
            }
            column(FormatClosed; FORMAT(Closed))
            {
            }
            column(EntrtyNo_VatEntry; "Entry No.")
            {
                IncludeCaption = true;
            }
            column(VatDiff_VatEntry; "VAT Difference")
            {
                IncludeCaption = true;
            }
            column(VATExceptionsCaption; VATExceptionsCaptionLbl)
            {
            }
            column(CurrReportPageNoOCaption; CurrReportPageNoOCaptionLbl)
            {
            }
            column(FORMATEU3PartyTradeCap; FORMATEU3PartyTradeCapLbl)
            {
            }
            column(FORMATClosedCaption; FORMATClosedCaptionLbl)
            {
            }
            column(VATEntryVATCalcTypeCap; VATEntryVATCalcTypeCapLbl)
            {
            }
            column(GenProdPostingGrpCaption; GenProdPostingGrpCaptionLbl)
            {
            }
            column(GenBusPostingGrpCaption; GenBusPostingGrpCaptionLbl)
            {
            }
            column(DocumentTypeCaption; DocumentTypeCaptionLbl)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(VatRate; VATRate)
            {
            }
            column(CustomerName; CustomerName)
            {
            }
            column(Description; SalesDesc)
            {
            }
            column(TaxableAmt; "VAT Entry".Base)
            {
            }
            column(GrossAmt; Base + Amount)
            {
            }
            column(VATAmt; "VAT Entry".Amount)
            {
            }
            column(VATAmtMur; "VAT Entry"."Additional-Currency Amount")
            {
            }
            column(BaseAmtMur; "VAT Entry"."Additional-Currency Base")
            {
            }
            column(AmtInclVatMur; "VAT Entry"."Additional-Currency Base" + "VAT Entry"."Additional-Currency Amount")
            {
            }
            column(DateFrom; DateFrom)
            {
            }
            column(DateTo; DateTo)
            {
            }
            column(VATBusPostingGroup_VATEntry; "VAT Entry"."VAT Bus. Posting Group")
            {
            }
            column(VATRegNo; VATRegNo)
            {
            }
            column(BRN; BRN)
            {

            }

            trigger OnAfterGetRecord()
            begin
                IF NOT PrintReversedEntries THEN
                    IF Reversed THEN
                        CurrReport.SKIP;
                IF UseAmtsInAddCurr THEN BEGIN
                    Base := "Additional-Currency Base";
                    Amount := "Additional-Currency Amount";
                    "VAT Difference" := "Add.-Curr. VAT Difference";
                END;

                //eis-yb-001
                Clear(VATRate);
                Vat.RESET;
                Vat.SETRANGE(Vat."VAT Prod. Posting Group", "VAT Entry"."VAT Prod. Posting Group");
                Vat.SetRange(Vat."VAT Bus. Posting Group", "VAT Entry"."VAT Bus. Posting Group");
                IF Vat.FINDFIRST THEN
                    VATRate := Vat."VAT %";

                Clear(CustomerName);
                Clear(VATRegNo);
                Clear(BRN);
                Customer.RESET;
                Customer.SETRANGE(Customer."No.", "VAT Entry"."Bill-to/Pay-to No.");
                IF Customer.FINDFIRST THEN BEGIN
                    CustomerName := Customer.Name;
                    VATRegNo := Customer."VAT Registration No.";
                    BRN := Customer.BRN;
                END;


                Clear(SalesDesc);
                if "VAT Entry"."Bill-to/Pay-to No." <> '' then begin
                    SalesInv.RESET;
                    SalesInv.SETRANGE(SalesInv."Document No.", "VAT Entry"."Document No.");
                    IF SalesInv.FINDFIRST THEN
                        SalesDesc := SalesInv.Description;
                end else begin
                    GLEntry.Reset();
                    GLEntry.SetRange("Document No.", "VAT Entry"."Document No.");
                    GLEntry.SetRange("Posting Date", "VAT Entry"."Posting Date");
                    if GLEntry.FindFirst() then
                        SalesDesc := GLEntry.Description;
                end;


                Clear(VATAmt);
                VATAmt := VATRate / 100 * SalesInv.Amount;
                //eis-yb-001
            end;

            trigger OnPreDataItem()
            begin
                IF UseAmtsInAddCurr THEN
                    SETFILTER("Add.-Curr. VAT Difference", '<=%1|>=%2', -ABS(MinVATDifference), ABS(MinVATDifference))
                ELSE
                    SETFILTER("VAT Difference", '<=%1|>=%2', -ABS(MinVATDifference), ABS(MinVATDifference));

                //EIS-YB-001
                //"VAT Entry".SETFILTER("VAT Entry"."Posting Date",'>=%1',DateFrom);
                //"VAT Entry".SETFILTER("VAT Entry"."Posting Date",'<=%1',DateTo);
                "VAT Entry".SETRANGE("VAT Entry"."Posting Date", DateFrom, DateTo);
                //EIS-YB-001
                CLEAR(VATRegNo);
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
                    field(AmountsInAddReportingCurrency; UseAmtsInAddCurr)
                    {
                        Caption = 'Show Amounts in Add. Reporting Currency';
                        MultiLine = true;
                    }
                    field(IncludeReversedEntries; PrintReversedEntries)
                    {
                        Caption = 'Include Reversed Entries';
                    }
                    field(MinVATDifference; MinVATDifference)
                    {
                        AutoFormatExpression = GetCurrency;
                        AutoFormatType = 1;
                        Caption = 'Min. VAT Difference';

                        trigger OnValidate()
                        begin
                            MinVATDifference := ABS(ROUND(MinVATDifference));
                        end;
                    }
                    field(DateFrom; DateFrom)
                    {
                        Caption = 'From';
                    }
                    field(DateTo; DateTo)
                    {
                        Caption = 'To';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        GLSetup.GET;
        VATEntryFilter := "VAT Entry".GETFILTERS;
        IF UseAmtsInAddCurr THEN
            AddCurrAmtTxt := STRSUBSTNO(Text000, GLSetup."Additional Reporting Currency");
        MinVATDiffText := STRSUBSTNO(Text001, "VAT Entry".FIELDCAPTION("VAT Difference"));
    end;

    var
        Text000: Label 'Amounts are shown in %1.';
        Text001: Label 'Show %1 equal to or greater than';
        VATExceptionsCaptionLbl: Label 'VAT Exceptions';
        CurrReportPageNoOCaptionLbl: Label 'Page';
        FORMATEU3PartyTradeCapLbl: Label 'EU 3-Party Trade';
        FORMATClosedCaptionLbl: Label 'Closed';
        VATEntryVATCalcTypeCapLbl: Label 'VAT Calculation Type';
        GenProdPostingGrpCaptionLbl: Label 'Gen. Prod. Posting Group';
        GenBusPostingGrpCaptionLbl: Label 'Gen. Bus. Posting Group';
        DocumentTypeCaptionLbl: Label 'Document Type';
        PostingDateCaptionLbl: Label 'Posting Date';
        GLSetup: Record "General Ledger Setup";
        VATEntryFilter: Text[250];
        UseAmtsInAddCurr: Boolean;
        AddCurrAmtTxt: Text[50];
        MinVATDifference: Decimal;
        MinVATDiffText: Text[250];
        PrintReversedEntries: Boolean;
        Vat: Record "VAT Posting Setup";
        VATRate: Decimal;
        DateFrom: Date;
        DateTo: Date;
        Customer: Record Customer;
        CustomerName: Text[50];
        SalesInv: Record "Sales Invoice Line";
        SalesDesc: Text[100];
        VATAmt: Decimal;
        VATRegNo: Code[50];
        BRN: Text[20];
        GLEntry: Record "G/L Entry";


    local procedure GetCurrency(): Code[10]
    begin
        IF UseAmtsInAddCurr THEN
            EXIT(GLSetup."Additional Reporting Currency");

        EXIT('');
    end;

    procedure InitializeRequest(NewUseAmtsInAddCurr: Boolean; NewPrintReversedEntries: Boolean; NewMinVATDifference: Decimal)
    begin
        UseAmtsInAddCurr := NewUseAmtsInAddCurr;
        PrintReversedEntries := NewPrintReversedEntries;
        MinVATDifference := ABS(ROUND(NewMinVATDifference));
    end;
}

