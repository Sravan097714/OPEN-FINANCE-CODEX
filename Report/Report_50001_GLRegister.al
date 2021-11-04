report 50001 "GL Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\GLRegister.rdl';
    //Caption = 'G/L Register';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Register"; "G/L Register")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Creation Date", "Source Code", "User ID";
            column(COMPANYNAME; COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(ShowLines; ShowDetails)
            {
            }
            /* column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            } */
            column(G_L_Register__TABLECAPTION__________GLRegFilter; TABLECAPTION + ': ' + GLRegFilter)
            {
            }
            column(GLRegFilter; GLRegFilter)
            {
            }
            column(G_L_Register__No__; "No.")
            {
            }
            column(G_L_RegisterCaption; G_L_RegisterCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(G_L_Entry__Posting_Date_Caption; G_L_Entry__Posting_Date_CaptionLbl)
            {
            }
            column(G_L_Entry__Document_Type_Caption; G_L_Entry__Document_Type_CaptionLbl)
            {
            }
            column(G_L_Entry__Document_No__Caption; "G/L Entry".FIELDCAPTION("Document No."))
            {
            }
            column(G_L_Entry__G_L_Account_No__Caption; "G/L Entry".FIELDCAPTION("G/L Account No."))
            {
            }
            column(GLAcc_NameCaption; GLAcc_NameCaptionLbl)
            {
            }
            column(G_L_Entry_DescriptionCaption; "G/L Entry".FIELDCAPTION(Description))
            {
            }
            column(G_L_Entry__VAT_Amount_Caption; "G/L Entry".FIELDCAPTION("VAT Amount"))
            {
            }
            column(G_L_Entry__Gen__Posting_Type_Caption; G_L_Entry__Gen__Posting_Type_CaptionLbl)
            {
            }
            column(G_L_Entry__Gen__Bus__Posting_Group_Caption; G_L_Entry__Gen__Bus__Posting_Group_CaptionLbl)
            {
            }
            column(G_L_Entry__Gen__Prod__Posting_Group_Caption; G_L_Entry__Gen__Prod__Posting_Group_CaptionLbl)
            {
            }
            column(G_L_Entry_AmountCaption; "G/L Entry".FIELDCAPTION(Amount))
            {
            }
            column(G_L_Entry__Entry_No__Caption; "G/L Entry".FIELDCAPTION("Entry No."))
            {
            }
            column(G_L_Register__No__Caption; G_L_Register__No__CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemTableView = SORTING("Entry No.");
                RequestFilterFields = "G/L Account No.", "Posting Date";
                column(G_L_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(G_L_Entry__Document_Type_; "Document Type")
                {
                }
                column(G_L_Entry__Document_No__; "Document No.")
                {
                }
                column(G_L_Entry__G_L_Account_No__; "G/L Account No.")
                {
                }
                column(GLAcc_Name; GLAcc.Name)
                {
                }
                column(G_L_Entry_Description; Description)
                {
                }
                column(G_L_Entry__VAT_Amount_; DetailedVATAmount)
                {
                    AutoCalcField = true;
                }
                column(G_L_Entry__Gen__Posting_Type_; "Gen. Posting Type")
                {
                }
                column(G_L_Entry__Gen__Bus__Posting_Group_; "Gen. Bus. Posting Group")
                {
                }
                column(G_L_Entry__Gen__Prod__Posting_Group_; "Gen. Prod. Posting Group")
                {
                }
                column(G_L_Entry_Amount; Amount)
                {
                }
                column(G_L_Entry__Entry_No__; "Entry No.")
                {
                }
                column(G_L_Entry_Amount_Control41; Amount)
                {
                }
                column(G_L_Entry_Amount_Control41Caption; G_L_Entry_Amount_Control41CaptionLbl)
                {
                }
                dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
                {
                    DataItemLink = "Document No." = FIELD("Document No."),
                                   "No." = FIELD("G/L Account No.");
                    UseTemporary = true;
                    column(Purch__Inv__Line_Description; Description)
                    {
                    }
                    column(Purch__Inv__Line_Amount; Amount)
                    {
                    }
                    column(Purch__Inv__Line_Document_No_; "Document No.")
                    {
                    }
                    column(Purch__Inv__Line_Line_No_; "Line No.")
                    {
                    }
                    column(Purch__Inv__Line_No_; "No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        DetailedVATAmount := "Amount Including VAT" - "VAT Base Amount";
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    PurchInvLine: Record 123;
                    SalesInvoiceLine: Record 113;
                    PurchCrMemoLine: Record 125;
                    SalesCrMemoLine: Record 115;
                    PurchInvHeader: Record 122;
                    PurchCrMemoHdr: Record 124;
                    SalesInvoiceHeader: Record 112;
                    SalesCrMemoHeader: Record 114;
                    CurrancyFactor: Decimal;
                begin
                    IF NOT GLAcc.GET("G/L Account No.") THEN
                        GLAcc.INIT;

                    DetailedVATAmount := "VAT Amount";

                    IF NOT ShowDetails THEN
                        EXIT;

                    "Purch. Inv. Line".DELETEALL;

                    PurchInvLine.SETRANGE("Document No.", "Document No.");
                    PurchInvLine.SETRANGE("No.", "G/L Account No.");
                    PurchInvLine.SETRANGE("VAT Prod. Posting Group", "VAT Prod. Posting Group");
                    IF PurchInvLine.FINDSET THEN BEGIN
                        IF NOT PurchInvHeader.GET("Document No.") THEN
                            EXIT;
                        CurrancyFactor := SetCurrancyFactor(PurchInvHeader."Currency Factor");
                        Amount := 0;
                        REPEAT
                            PopulateRecFromPurchInvLine(PurchInvLine, CurrancyFactor, PurchInvHeader."Prices Including VAT");
                        UNTIL PurchInvLine.NEXT = 0;
                        EXIT;
                    END;

                    PurchCrMemoLine.SETRANGE("Document No.", "Document No.");
                    PurchCrMemoLine.SETRANGE("No.", "G/L Account No.");
                    PurchCrMemoLine.SETRANGE("VAT Prod. Posting Group", "VAT Prod. Posting Group");
                    IF PurchCrMemoLine.FINDSET THEN BEGIN
                        IF NOT PurchCrMemoHdr.GET("Document No.") THEN
                            EXIT;
                        CurrancyFactor := SetCurrancyFactor(PurchCrMemoHdr."Currency Factor");
                        Amount := 0;
                        REPEAT
                            PopulateRecFromPurchCrMemoLine(PurchCrMemoLine, CurrancyFactor, PurchCrMemoHdr."Prices Including VAT");
                        UNTIL PurchCrMemoLine.NEXT = 0;
                        EXIT;
                    END;

                    SalesInvoiceLine.SETRANGE("Document No.", "Document No.");
                    SalesInvoiceLine.SETRANGE("No.", "G/L Account No.");
                    SalesInvoiceLine.SETRANGE("VAT Prod. Posting Group", "VAT Prod. Posting Group");
                    IF SalesInvoiceLine.FINDSET THEN BEGIN
                        IF NOT SalesInvoiceHeader.GET("Document No.") THEN
                            EXIT;
                        CurrancyFactor := SetCurrancyFactor(SalesInvoiceHeader."Currency Factor");
                        Amount := 0;
                        REPEAT
                            PopulateRecFromSalesInvoiceLine(SalesInvoiceLine, CurrancyFactor, SalesInvoiceHeader."Prices Including VAT");
                        UNTIL SalesInvoiceLine.NEXT = 0;
                        EXIT;
                    END;

                    SalesCrMemoLine.SETRANGE("Document No.", "Document No.");
                    SalesCrMemoLine.SETRANGE("No.", "G/L Account No.");
                    SalesCrMemoLine.SETRANGE("VAT Prod. Posting Group", "VAT Prod. Posting Group");
                    IF SalesCrMemoLine.FINDSET THEN BEGIN
                        IF NOT SalesCrMemoHeader.GET("Document No.") THEN
                            EXIT;
                        CurrancyFactor := SetCurrancyFactor(SalesCrMemoHeader."Currency Factor");
                        Amount := 0;
                        REPEAT
                            PopulateRecFromSalesCrMemoLine(SalesCrMemoLine, CurrancyFactor, SalesCrMemoHeader."Prices Including VAT");
                        UNTIL SalesCrMemoLine.NEXT = 0;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Entry No.", "G/L Register"."From Entry No.", "G/L Register"."To Entry No.");
                    //CurrReport.CREATETOTALS(Amount);
                end;
            }

            trigger OnPreDataItem()
            begin
                //CurrReport.CREATETOTALS("G/L Entry".Amount);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowDetails; ShowDetails)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show details';
                        ToolTip = 'Specifies if the report displays all lines in detail.';
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
        GLRegFilter := "G/L Register".GETFILTERS;
    end;

    var
        GLAcc: Record 15;
        GLRegFilter: Text;
        G_L_RegisterCaptionLbl: Label 'G/L Register';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        G_L_Entry__Posting_Date_CaptionLbl: Label 'Posting Date';
        G_L_Entry__Document_Type_CaptionLbl: Label 'Document Type';
        GLAcc_NameCaptionLbl: Label 'Name';
        G_L_Entry__Gen__Posting_Type_CaptionLbl: Label 'Gen. Posting Type';
        G_L_Entry__Gen__Bus__Posting_Group_CaptionLbl: Label 'Gen. Bus. Posting Group';
        G_L_Entry__Gen__Prod__Posting_Group_CaptionLbl: Label 'Gen. Prod. Posting Group';
        G_L_Register__No__CaptionLbl: Label 'Register No.';
        TotalCaptionLbl: Label 'Total';
        G_L_Entry_Amount_Control41CaptionLbl: Label 'Total';
        ShowDetails: Boolean;
        DetailedVATAmount: Decimal;

    local procedure PopulateRecFromPurchInvLine(PurchInvLine: Record 123; CurrancyFactor: Decimal; PricesInclVAT: Boolean)
    begin
        IF PricesInclVAT THEN
            PurchInvLine.Amount := ROUND(PurchInvLine."VAT Base Amount" / CurrancyFactor)
        ELSE
            PurchInvLine.Amount := ROUND(PurchInvLine."Line Amount" / CurrancyFactor);
        "Purch. Inv. Line".INIT;
        "Purch. Inv. Line".TRANSFERFIELDS(PurchInvLine);
        "Purch. Inv. Line".INSERT;
    end;

    local procedure PopulateRecFromPurchCrMemoLine(PurchCrMemoLine: Record 125; CurrancyFactor: Decimal; PricesInclVAT: Boolean)
    begin
        "Purch. Inv. Line".INIT;
        IF PricesInclVAT THEN
            PurchCrMemoLine.Amount := ROUND(PurchCrMemoLine."VAT Base Amount" / CurrancyFactor)
        ELSE
            PurchCrMemoLine.Amount := ROUND(PurchCrMemoLine."Line Amount" / CurrancyFactor);
        "Purch. Inv. Line".Description := PurchCrMemoLine.Description;
        "Purch. Inv. Line".Amount := -PurchCrMemoLine.Amount;
        "Purch. Inv. Line"."Document No." := PurchCrMemoLine."Document No.";
        "Purch. Inv. Line"."Line No." := PurchCrMemoLine."Line No.";
        "Purch. Inv. Line"."No." := PurchCrMemoLine."No.";
        "Purch. Inv. Line"."Amount Including VAT" := -PurchCrMemoLine."Amount Including VAT";
        "Purch. Inv. Line"."VAT Base Amount" := -PurchCrMemoLine."VAT Base Amount";
        "Purch. Inv. Line".INSERT;
    end;

    local procedure PopulateRecFromSalesInvoiceLine(SalesInvoiceLine: Record 113; CurrancyFactor: Decimal; PricesInclVAT: Boolean)
    begin
        "Purch. Inv. Line".INIT;
        IF PricesInclVAT THEN
            SalesInvoiceLine.Amount := ROUND(SalesInvoiceLine."VAT Base Amount" / CurrancyFactor)
        ELSE
            SalesInvoiceLine.Amount := ROUND(SalesInvoiceLine."Line Amount" / CurrancyFactor);
        "Purch. Inv. Line".Description := SalesInvoiceLine.Description;
        "Purch. Inv. Line".Amount := -SalesInvoiceLine.Amount;
        "Purch. Inv. Line"."Document No." := SalesInvoiceLine."Document No.";
        "Purch. Inv. Line"."Line No." := SalesInvoiceLine."Line No.";
        "Purch. Inv. Line"."No." := SalesInvoiceLine."No.";
        "Purch. Inv. Line"."Amount Including VAT" := -SalesInvoiceLine."Amount Including VAT";
        "Purch. Inv. Line"."VAT Base Amount" := -SalesInvoiceLine."VAT Base Amount";
        "Purch. Inv. Line".INSERT;
    end;

    local procedure PopulateRecFromSalesCrMemoLine(SalesCrMemoLine: Record 115; CurrancyFactor: Decimal; PricesInclVAT: Boolean)
    begin
        "Purch. Inv. Line".INIT;
        IF PricesInclVAT THEN
            SalesCrMemoLine.Amount := ROUND(SalesCrMemoLine."VAT Base Amount" / CurrancyFactor)
        ELSE
            SalesCrMemoLine.Amount := ROUND(SalesCrMemoLine."Line Amount" / CurrancyFactor);
        "Purch. Inv. Line".Description := SalesCrMemoLine.Description;
        "Purch. Inv. Line".Amount := SalesCrMemoLine.Amount;
        "Purch. Inv. Line"."Document No." := SalesCrMemoLine."Document No.";
        "Purch. Inv. Line"."Line No." := SalesCrMemoLine."Line No.";
        "Purch. Inv. Line"."No." := SalesCrMemoLine."No.";
        "Purch. Inv. Line"."Amount Including VAT" := SalesCrMemoLine."Amount Including VAT";
        "Purch. Inv. Line"."VAT Base Amount" := SalesCrMemoLine."VAT Base Amount";
        "Purch. Inv. Line".INSERT;
    end;

    local procedure SetCurrancyFactor(HeaderCurrancyFactor: Decimal): Decimal
    begin
        IF HeaderCurrancyFactor = 0 THEN
            EXIT(1);
        EXIT(HeaderCurrancyFactor);
    end;
}

