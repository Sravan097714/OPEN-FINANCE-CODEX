report 50017 "Sales Credit Memo"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\SalesCreditMemo.rdl';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Sales Credit Memo';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            CalcFields = "Amount", "Amount Including VAT";
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            column(No_SalesCrMemoHeader; "Sales Cr.Memo Header"."No.") { }
            column(CurrencyCode_SalesInvoiceHeader; gtextCurrency) { }
            column(Taxable_; Taxable) { }
            column(SignatureName; grecSalesReceivableSetup."Sales Invoice Signature Name") { }
            column(gtextBRN; gtextBRN) { }
            column(gtextVATREGNo; gtextVATREGNo) { }
            column(Our_Ref; "Our Ref") { }
            column(Your_Ref; "Your Ref") { }
            column(Pre_Assigned_No_; "Pre-Assigned No.") { }
            column(User_ID; "User ID") { }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));

                    column(CompanyInfo_Picture; CompanyInfo.Picture) { }
                    column(CompanyInfo_Name; CompanyInfo.Name) { }
                    column(CompanyBRN; CompanyInfo.BRN) { }
                    column(CompanyVATRegNo; CompanyInfo."VAT Registration No.") { }
                    column(CompanyPhoneNo; CompanyInfo."Phone No.") { }
                    column(CompanyEmail2; CompanyInfo."E-Mail") { }
                    column(PostalAddress; CompanyInfo."Postal Address") { }
                    column(ShortcutDimension1Code_SalesCrMemoHeader; "Sales Cr.Memo Header"."Shortcut Dimension 1 Code")
                    {
                    }
                    column(gtextCreatedBy; gtextCreatedBy) { }
                    column(ExternalDocumentNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."External Document No.")
                    {
                    }
                    column(PostingDate_SalesCrMemoHeader; "Sales Cr.Memo Header"."Posting Date")
                    {
                    }
                    column(BilltoCustomerNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                    }
                    column(BilltoName_SalesCrMemoHeader; CustomerName)
                    {
                    }
                    column(PreAssignedNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Pre-Assigned No.")
                    {
                    }
                    column(VATRegistrationNo_SalesCrMemoHeader; CustomerVAT)
                    {
                    }
                    column(DueDate; "Sales Cr.Memo Header"."Due Date")
                    { }
                    column(CODE_Caption; CODE_CaptionLbl)
                    {
                    }
                    column(DESCRIPTION_Caption; DESCRIPTION_CaptionLbl)
                    {
                    }
                    column(UOM_Caption; UOM_CaptionLbl)
                    {
                    }
                    column(QTY_Caption; QTY_CaptionLbl)
                    {
                    }
                    column(UNIT_PRICE_Caption; UNIT_PRICE_CaptionLbl)
                    {
                    }
                    column(DISCOUNT_Caption; DISCOUNT_CaptionLbl)
                    {
                    }
                    column(NET_PRICE_Caption; NET_PRICE_CaptionLbl)
                    {
                    }
                    column(VAT_Caption; VAT_CaptionLbl)
                    {
                    }
                    column(AMOUNT_INV_Caption; AMOUNT_INV_CaptionLbl)
                    {
                    }
                    column(Delivered_By_Caption; Delivered_By_CaptionLbl)
                    {
                    }
                    column(Received_by_Caption; Received_by_CaptionLbl)
                    {
                    }
                    column(Payment_Terms_Caption; Payment_Terms_CaptionLbl)
                    {
                    }
                    column(SUB_TOTAL_Caption; SUB_TOTAL_CaptionLbl)
                    {
                    }
                    column(VAT1_Caption; VAT1_CaptionLbl)
                    {
                    }
                    column(TOTAL_Caption; TOTAL_CaptionLbl)
                    {
                    }
                    /* column(CurrReport_PAGENO; CurrReport.PAGENO())
                    {
                    } */
                    column(CurrCode; CurrCode)
                    {
                    }
                    column(UPPERCASE_CompanyInfo_Name; UPPERCASE(CompanyInfo.Name))
                    {
                    }
                    column(CompanyArr1_CompanyArr2_CompanyArr3_CompanyArr4; CompanyArr[1])
                    {
                    }
                    column(CompanyArr5_CompanyArr6_CompanyArr7_CompanyArr8; CompanyArr[2])
                    {
                    }
                    column(CompanyArr9_CompanyArr10; CompanyArr[9] + '' + CompanyArr[10])
                    {
                    }
                    column(CompanyArr9; CompanyArr[9])
                    {
                    }
                    column(CompanyArr10; CompanyArr[10])
                    {
                    }
                    column(Title_2_; Title[2])
                    {
                    }
                    column(Title_1_; Title[1])
                    {
                    }
                    column(YourRef; YourRef)
                    {
                    }
                    column(B_UNIT_Caption; B_UNIT_CaptionLbl)
                    {
                    }
                    column(INVOICE_NO_Caption; INVOICE_NO_CaptionLbl)
                    {
                    }
                    column(DATE_Caption; DATE_CaptionLbl)
                    {
                    }
                    column(PAGE_NO_Caption; PAGE_NO_CaptionLbl)
                    {
                    }
                    column(CLIENT_CODE_Caption; CLIENT_CODE_CaptionLbl)
                    {
                    }
                    column(CURRENCY_Caption; CURRENCY_CaptionLbl)
                    {
                    }
                    column(SALES_NO_Caption; SALES_NO_CaptionLbl)
                    {
                    }
                    column(CUSTOMER_DETAILS_Caption; CUSTOMER_DETAILS_CaptionLbl)
                    {
                    }
                    column(DELIVERED_TO_Caption; DELIVERED_TO_CaptionLbl)
                    {
                    }
                    column(Colun_Caption; Colun_CaptionLbl)
                    {
                    }
                    column(CustAddr_1_; CustAddr[1])
                    {
                    }
                    column(CustAddr_2_; CustAddr[2])
                    {
                    }
                    column(CustAddr_3_; CustAddr[3])
                    {
                    }
                    column(CustAddr_4_; CustAddr[4])
                    {
                    }
                    column(CustAddr_5_; CustAddr[5])
                    {
                    }
                    column(CustAddr_6_; CustAddr[6])
                    {
                    }
                    column(CustAddr_7_; CustAddr[7])
                    {
                    }
                    column(ShipToAddr_1_; ShipToAddr[1])
                    {
                    }
                    column(ShipToAddr_2_; ShipToAddr[2])
                    {
                    }
                    column(ShipToAddr_3_; ShipToAddr[3])
                    {
                    }
                    column(ShipToAddr_4_; ShipToAddr[4])
                    {
                    }
                    column(ShipToAddr_5_; ShipToAddr[5])
                    {
                    }
                    column(ShipToAddr_6_; ShipToAddr[6])
                    {
                    }
                    column(ShipToAddr_7_; ShipToAddr[7])
                    {
                    }
                    column(BRNText_1_; BRNText[1])
                    {
                    }
                    column(BRNText_2_; BRNText[2])
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(VatDisplay; VATDisplay)
                    {
                    }

                    column(Dot_Caption; Dot_CaptionLbl)
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));

                        trigger OnAfterGetRecord();
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDSET() THEN
                                    CurrReport.BREAK();
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK();

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL DimSetEntry1.NEXT() = 0;
                        end;

                        trigger OnPreDataItem();
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(Description_SalesCrMemoLine; "Sales Cr.Memo Line".Description + ' ' + "Sales Cr.Memo Line"."Description 2")
                        {
                        }
                        column(No_SalesCrMemoLine; "Sales Cr.Memo Line"."No.")
                        {
                        }
                        column(ItemCode2; gtextItemCode2) { }
                        column(UnitofMeasureCode_SalesCrMemoLine; "Sales Cr.Memo Line"."Unit of Measure Code")
                        {
                        }
                        column(UnitPrice_SalesCrMemoLine; "Sales Cr.Memo Line"."Unit Price")
                        {
                        }
                        column(Quantity_SalesCrMemoLine; "Sales Cr.Memo Line".Quantity)
                        {
                        }
                        column(LineDiscountAmount_SalesCrMemoLine; "Sales Cr.Memo Line"."Line Discount Amount")
                        {
                        }
                        column(LineAmount_SalesCrMemoLine; "Sales Cr.Memo Line"."Line Amount")
                        {
                        }
                        column(LineNo_SalesCrMemoLine; "Sales Cr.Memo Line"."Line No.")
                        {
                        }
                        column(CompanyInfoAddr2_BankAdd; 'CompanyInfoAddr2."Bank Address"')
                        {

                        }
                        column(CompanyInfoAddr2_BankName; 'CompanyInfoAddr2."Bank Name"')
                        {

                        }
                        column(CompanyInfoAddr2_AccNo; 'CompanyInfoAddr2."Account No."')
                        {

                        }
                        column(CompanyInfoAddr2_IBAN; 'CompanyInfoAddr2.IBAN')
                        {

                        }
                        column(CompanyInfoAddr2_SWIFT_Code; 'CompanyInfoAddr2."SWIFT Code"')
                        {

                        }
                        column(VATStatus; VATStatus)
                        {
                        }
                        column(Amount_SalesCrMemoLine; "Sales Cr.Memo Line".Amount)
                        {
                        }
                        column(AmountIncludingVAT_SalesCrMemoLine; "Sales Cr.Memo Line"."Amount Including VAT")
                        {
                        }
                        column(LineAmt; LineAmt)
                        {
                        }
                        column(AmtIncl; AmtIncl)
                        {
                        }
                        column(Amount_Including_VAT_Amount; "Amount Including VAT" - Amount)
                        {
                        }
                        column(VATPerc; VATAmountLine."VAT %")
                        {
                        }
                        column(VatAmount; VatAmount)
                        { }
                        column(AmountIncludingVAT; "Amount Including VAT")
                        {
                        }
                        column(PaymentTerms_Description; PaymentTerms.Description)
                        {
                        }
                        dataitem("Sales Comment Line"; "Sales Comment Line")
                        {
                            DataItemLinkReference = "Sales Cr.Memo Line";
                            DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("POSTED CREDIT MEMO"));
                            DataItemLink = "No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                            column(SalesComment; "Sales Comment Line".Comment)
                            {
                            }
                            column(Document_Type; "Document Type") { }
                            column(No_; "No.") { }
                            column(Document_Line_No_; "Document Line No.") { }

                        }
                        dataitem("Sales Shipment Buffer"; Integer)
                        {
                            DataItemTableView = SORTING(Number);

                            trigger OnAfterGetRecord();
                            begin

                                IF Number = 1 THEN
                                    SalesShipmentBuffer.FIND('-')
                                ELSE
                                    SalesShipmentBuffer.NEXT();
                            end;

                            trigger OnPreDataItem();
                            begin
                                SETRANGE(Number, 1, SalesShipmentBuffer.COUNT());
                            end;
                        }
                        dataitem("Item Ledger Entry"; "Item Ledger Entry")
                        {
                            DataItemLinkReference = "Sales Cr.Memo Line";
                            DataItemLink = "Item No." = FIELD("No."), "Document No." = FIELD("Document No.");
                            column(ILE_ItemNo; "Item Ledger Entry"."Serial No.")
                            {

                            }
                            column(ILE_Qty; "Item Ledger Entry".Quantity)
                            {

                            }
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));

                            trigger OnAfterGetRecord();
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FINDSET() THEN
                                        CurrReport.BREAK();
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL DimSetEntry2.NEXT() = 0;
                            end;

                            trigger OnPreDataItem();
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK();

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Cr.Memo Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord();
                        begin
                            SalesShipmentBuffer.DELETEALL();

                            CLEAR(LineAmt);
                            CLEAR(AmtIncl);

                            PostedReceiptDate := 0D;


                            IF Quantity <> 0 THEN
                                PostedReceiptDate := FindPostedShipmentDate();

                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "No." := '';

                            IF VATPostingSetup.GET("VAT Bus. Posting Group", "VAT Prod. Posting Group") THEN
                                VATStatus := COPYSTR(VATPostingSetup."VAT Identifier", 1, 1)
                            ELSE
                                CLEAR(VATStatus);

                            IF ("Sales Cr.Memo Line"."No." = '') AND
                               ("Sales Cr.Memo Line".Quantity = 0) AND
                               ("Sales Cr.Memo Line"."Unit Price" = 0) THEN
                                CLEAR(VATStatus);

                            clear(gtextItemCode2);
                            if grecItem.get("Sales Cr.Memo Line"."No.") then
                                gtextItemCode2 := grecItem."Vendor Item No.";

                            VATAmountLine.INIT();
                            //VATAmountLine."VAT Identifier" := "VAT Identifier";
                            //VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            //VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."VAT %" := "VAT %";
                            //VATAmountLine."VAT Base" := Amount;
                            //VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            //VATAmountLine."Line Amount" := "Line Amount";
                            //IF "Allow Invoice Disc." THEN
                            //  VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            //VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine.InsertLine();
                        end;

                        trigger OnPreDataItem();
                        begin
                            VATAmountLine.DELETEALL();
                            SalesShipmentBuffer.RESET();
                            SalesShipmentBuffer.DELETEALL();
                            FirstValueEntryNo := 0;
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");

                            //CurrReport.CREATETOTALS(Amount, "Amount Including VAT", "Inv. Discount Amount", LineAmt, AmtIncl);
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);

                        trigger OnAfterGetRecord();
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem();
                        begin
                            IF VATAmountLine.GetTotalVATAmount() = 0 THEN
                                CurrReport.BREAK();
                            SETRANGE(Number, 1, VATAmountLine.COUNT());
                            /* CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount"); */
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));

                        trigger OnAfterGetRecord();
                        begin
                            IF NOT ShowShippingAddr THEN
                                CurrReport.BREAK();
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                begin
                    IF Number > 1 THEN BEGIN
                        Title[2] := Text004;
                        OutputNo += 1;
                    END;

                    grecUsers.Reset();
                    grecUsers.SetRange("User Name", "Sales Cr.Memo Header"."Created By");
                    if grecUsers.FindFirst() then
                        gtextCreatedBy := grecUsers."Full Name";

                end;

                trigger OnPostDataItem();
                begin
                    IF NOT CurrReport.PREVIEW() THEN
                        SalesCrMemoCountPrinted.RUN("Sales Cr.Memo Header");
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord();
            begin

                CLEAR(CurrCode);
                CLEAR(BRNText);
                //SO-001****************************************************************************************************************************
                //  IF CompanyInfo."VAT Registration No." <> '' THEN
                // Title[1] := 'VAT CREDIT NOTE'
                // ELSE
                // Title[1] := 'CREDIT NOTE';

                IF "No. Printed" > 0 THEN
                    Title[2] := 'COPY'
                ELSE
                    Title[2] := '';

                IF "External Document No." <> '' THEN BEGIN
                    YourRef := Text009;
                    Dot := Text008;
                END ELSE BEGIN
                    CLEAR(YourRef);
                    CLEAR(Dot);
                END;

                IF "Sales Cr.Memo Header"."VAT Registration No." <> '' THEN
                    VATDisplay := Text010
                ELSE
                    CLEAR(VATDisplay);

                IF "Currency Code" = '' THEN
                    gtextCurrency := 'MUR'
                else
                    gtextCurrency := "Currency Code";


                IF "Currency Code" <> '' THEN
                    CurrCode := COPYSTR("Currency Code", 1, 3)
                ELSE BEGIN
                    IF GLSetup.GET() THEN
                        CurrCode := GLSetup."LCY Code";
                END;

                //IF "Sales Cr.Memo Header"."Currency Code" <> '' THEN
                //   CompanyInfoAddr2.GET(CurrCode)
                // ELSE
                //  CompanyInfoAddr2.GET('');


                //END SO-001************************************************************************************************************************


                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                grecSalesReceivableSetup.get;


                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");
                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT()
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                IF "Salesperson Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT();
                    SalesPersonText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;
                END;

                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");

                Clear(CustomerName);
                clear(CustomerVAT);
                //FormatAddr.SalesCrMemoBillTo(CustAddr, "Sales Cr.Memo Header");
                IF Customer.GET("Sales Cr.Memo Header"."Bill-to Customer No.") THEN BEGIN
                    CustomerName := Customer.Name;
                    CustomerVAT := Customer."VAT Registration No.";
                    CustAddr[1] := Customer.Address + ' ' + Customer."Address 2";
                    //CustAddr[2] := Customer."Address 2";
                    CustAddr[3] := Customer.City;
                    IF Country.GET(Customer."Country/Region Code") THEN
                        CustAddr[4] := Country.Name
                    else
                        CustAddr[4] := '';

                    gtextBRN := Customer.BRN;
                    gtextVATREGNo := Customer."VAT Registration No.";
                END;
                COMPRESSARRAY(CustAddr);

                //FormatAddr.SalesCrMemoBillTo(CustAddr, "Sales Cr.Memo Header");
                FormatAddr.SalesCrMemoShipTo(ShipToAddr, CustAddr, "Sales Cr.Memo Header");
                Formataddress.GetCustomer("Bill-to Customer No.", BRNText[2], BRNText[1]);
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;

                //EIS-UPGRADE BEGIN
                Taxable := 0;
                Clear(VatAmount);
                IF "Sales Cr.Memo Header"."Amount Including VAT" - "Sales Cr.Memo Header".Amount <> 0 THEN BEGIN
                    SalesCrMemoLine.RESET();
                    SalesCrMemoLine.SETRANGE(SalesCrMemoLine."Document No.", "Sales Cr.Memo Header"."No.");
                    SalesCrMemoLine.SETFILTER(SalesCrMemoLine."VAT %", '<>%1', 0);
                    IF SalesCrMemoLine.FINDFIRST() THEN
                        Taxable := SalesCrMemoLine."VAT %";
                END;
                VatAmount := SalesCrMemoLine."Amount Including VAT" - SalesCrMemoLine."Line Amount";
                IF VatAmount = 0 THEN
                    Title[1] := 'CREDIT NOTE'
                ELSE
                    Title[1] := 'VAT CREDIT NOTE';
                //EIS-UPGRADE END

                if Customer.get("Sales Cr.Memo Header"."Sell-to Customer No.") then
                    gtextCustomerBRN := Customer.BRN;
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
                    field("No. of Copies"; NoOfCopies)
                    {
                        ApplicationArea = all;
                    }
                    field("Show Internal Information"; ShowInternalInfo)
                    {
                        Visible = false;
                        ApplicationArea = all;
                    }
                    field("Log Interaction"; LogInteraction)
                    {
                        Visible = false;
                        ApplicationArea = all;
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

    trigger OnInitReport();
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
        Formataddress.Companys(CompanyArr, CompanyInfo);
    end;

    var
        gtextBRN: Text;
        gtextVATREGNo: Text;
        gtextCustomerBRN: Text;
        grecSalesReceivableSetup: Record "Sales & Receivables Setup";
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label '(Applies to %1 %2)';
        Text004: Label 'COPY';
        Text005: Label 'Sales - Credit Memo %1';
        Text006: Label 'Page %1';
        Text007: Label 'Total %1 Excl. VAT';
        Text008: Label ':';
        Text009: Label 'YOUR REF';
        Text010: Label 'VAT REG NO :';
        Text011: Label 'BRN: ';
        B_UNIT_CaptionLbl: Label 'B/UNIT';
        INVOICE_NO_CaptionLbl: Label 'CREDIT NOTE NO.';
        DATE_CaptionLbl: Label 'DATE';
        PAGE_NO_CaptionLbl: Label 'PAGE NO';
        CLIENT_CODE_CaptionLbl: Label 'CLIENT CODE';
        CURRENCY_CaptionLbl: Label 'CURRENCY';
        SALES_NO_CaptionLbl: Label 'SALES ORDER NO';
        CUSTOMER_DETAILS_CaptionLbl: Label 'CUSTOMER DETAILS';
        DELIVERED_TO_CaptionLbl: Label 'DELIVERED TO';
        CODE_CaptionLbl: Label 'CODE';
        DESCRIPTION_CaptionLbl: Label 'DESCRIPTION';
        UOM_CaptionLbl: Label 'UOM';
        QTY_CaptionLbl: Label 'QTY';
        UNIT_PRICE_CaptionLbl: Label 'UNIT PRICE';
        DISCOUNT_CaptionLbl: Label 'DISCOUNT';
        NET_PRICE_CaptionLbl: Label 'NET PRICE';
        VAT_CaptionLbl: Label 'VAT';
        AMOUNT_INV_CaptionLbl: Label 'AMOUNT INC VAT';
        Delivered_By_CaptionLbl: Label 'Delivered By:';
        Received_by_CaptionLbl: Label 'Received by:';
        Payment_Terms_CaptionLbl: Label 'Payment Terms :';
        SUB_TOTAL_CaptionLbl: Label 'SUB TOTAL';
        VAT1_CaptionLbl: Label 'VAT';
        TOTAL_CaptionLbl: Label 'TOTAL';
        Dot_CaptionLbl: Label '................................................................';
        Colun_CaptionLbl: Label ':';
        GLSetup: Record 98;
        SalesPurchPerson: Record 13;
        CompanyInfo: Record 79;
        VatAmount: Decimal;
        VATAmountLine: Record 290 temporary;
        Language: Record 8;
        SalesShipmentBuffer: Record 7190 temporary;
        SalesCrMemoCountPrinted: Codeunit 316;
        Country: Record 9;
        FormatAddr: Codeunit 365;
        SegManagement: Codeunit SegManagement;
        RespCenter: Record 5714;
        CustAddr: array[8] of Text[250];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        ReturnOrderNoText: Text[30];
        SalesPersonText: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        AppliedToText: Text[40];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        FirstValueEntryNo: Integer;
        PostedReceiptDate: Date;
        NextEntryNo: Integer;
        Title: array[3] of Text[30];
        PaymentTerms: Record 3;
        Cust: Record 18;
        Item: Record 27;
        VATStatus: Text[1];
        Formataddress: Codeunit 50008;
        CompanyArr: array[10] of Text[95];
        YourRef: Code[8];
        Dot: Text[1];
        VATDisplay: Text[30];
        Dot1: Text[1];
        VATPostingSetup: Record 325;
        CurrCode: Code[3];
        gtextCurrency: Text[10];
        Customer: Record 18;
        BRNText: array[2] of Text[30];
        LineAmt: Decimal;
        AmtIncl: Decimal;
        OutputNo: Integer;
        DimSetEntry1: Record 480;
        DimSetEntry2: Record 480;
        NetPrice: array[4] of Decimal;
        Taxable: Decimal;
        SalesCrMemoLine: Record 115;
        CustomerName: Text;
        CustomerVAT: Text;
        gtextItemCode2: Text;
        grecItem: Record Item;
        grecUsers: Record User;
        gtextCreatedBy: Text;

    procedure FindPostedShipmentDate(): Date;
    var
        ReturnReceiptHeader: Record 6660;
        SalesShipmentBuffer2: Record 7190 temporary;
    begin
        NextEntryNo := 1;
        IF "Sales Cr.Memo Line"."Return Receipt No." <> '' THEN
            IF ReturnReceiptHeader.GET("Sales Cr.Memo Line"."Return Receipt No.") THEN
                EXIT(ReturnReceiptHeader."Posting Date");

        CASE "Sales Cr.Memo Line".Type OF
            "Sales Cr.Memo Line".Type::Item:
                GenerateBufferFromValueEntry("Sales Cr.Memo Line");
            "Sales Cr.Memo Line".Type::"G/L Account", "Sales Cr.Memo Line".Type::Resource,
          "Sales Cr.Memo Line".Type::"Charge (Item)", "Sales Cr.Memo Line".Type::"Fixed Asset":
                GenerateBufferFromShipment("Sales Cr.Memo Line");
            "Sales Cr.Memo Line".Type::" ":
                EXIT(0D);
        END;

        SalesShipmentBuffer.RESET();
        SalesShipmentBuffer.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", "Sales Cr.Memo Line"."Line No.");

        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer2 := SalesShipmentBuffer;
            IF SalesShipmentBuffer.NEXT() = 0 THEN BEGIN
                SalesShipmentBuffer.GET(SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No."
          );
                SalesShipmentBuffer.DELETE();
                EXIT(SalesShipmentBuffer2."Posting Date");
                // ;
            END;
            SalesShipmentBuffer.CALCSUMS(Quantity);
            IF SalesShipmentBuffer.Quantity <> "Sales Cr.Memo Line".Quantity THEN BEGIN
                SalesShipmentBuffer.DELETEALL();
                EXIT("Sales Cr.Memo Header"."Posting Date");
            END;
        END ELSE
            EXIT("Sales Cr.Memo Header"."Posting Date");
    end;

    procedure GenerateBufferFromValueEntry(SalesCrMemoLine2: Record 115);
    var
        ValueEntry: Record 5802;
        ItemLedgerEntry: Record 32;
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := SalesCrMemoLine2."Quantity (Base)";
        ValueEntry.SETCURRENTKEY("Document No.", "Posting Date");
        ValueEntry.SETRANGE("Document No.", SalesCrMemoLine2."Document No.");
        ValueEntry.SETRANGE("Posting Date", "Sales Cr.Memo Header"."Posting Date");
        ValueEntry.SETRANGE("Item Charge No.", '');
        ValueEntry.SETFILTER("Entry No.", '%1..', FirstValueEntryNo);
        IF ValueEntry.FIND('-') THEN
            REPEAT
                IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
                    IF SalesCrMemoLine2."Qty. per Unit of Measure" <> 0 THEN
                        Quantity := ValueEntry."Invoiced Quantity" / SalesCrMemoLine2."Qty. per Unit of Measure"
                    ELSE
                        Quantity := ValueEntry."Invoiced Quantity";
                    AddBufferEntry(
                      SalesCrMemoLine2,
                      -Quantity,
                      ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity - ValueEntry."Invoiced Quantity";
                END;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
            UNTIL (ValueEntry.NEXT() = 0) OR (TotalQuantity = 0);
    end;

    procedure GenerateBufferFromShipment(SalesCrMemoLine: Record 115);
    var
        SalesCrMemoHeader: Record 114;
        SalesCrMemoLine2: Record 115;
        ReturnReceiptHeader: Record 6660;
        ReturnReceiptLine: Record 6661;
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := 0;
        SalesCrMemoHeader.SETCURRENTKEY("Return Order No.");
        SalesCrMemoHeader.SETFILTER("No.", '..%1', "Sales Cr.Memo Header"."No.");
        SalesCrMemoHeader.SETRANGE("Return Order No.", "Sales Cr.Memo Header"."Return Order No.");
        IF SalesCrMemoHeader.FIND('-') THEN
            REPEAT
                SalesCrMemoLine2.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                SalesCrMemoLine2.SETRANGE("Line No.", SalesCrMemoLine."Line No.");
                SalesCrMemoLine2.SETRANGE(Type, SalesCrMemoLine.Type);
                SalesCrMemoLine2.SETRANGE("No.", SalesCrMemoLine."No.");
                SalesCrMemoLine2.SETRANGE("Unit of Measure Code", SalesCrMemoLine."Unit of Measure Code");
                IF SalesCrMemoLine2.FIND('-') THEN
                    REPEAT
                        TotalQuantity := TotalQuantity + SalesCrMemoLine2.Quantity;
                    UNTIL SalesCrMemoLine2.NEXT() = 0;
            UNTIL SalesCrMemoHeader.NEXT() = 0;

        ReturnReceiptLine.SETCURRENTKEY("Return Order No.", "Return Order Line No.");
        ReturnReceiptLine.SETRANGE("Return Order No.", "Sales Cr.Memo Header"."Return Order No.");
        ReturnReceiptLine.SETRANGE("Return Order Line No.", SalesCrMemoLine."Line No.");
        ReturnReceiptLine.SETRANGE("Line No.", SalesCrMemoLine."Line No.");
        ReturnReceiptLine.SETRANGE(Type, SalesCrMemoLine.Type);
        ReturnReceiptLine.SETRANGE("No.", SalesCrMemoLine."No.");
        ReturnReceiptLine.SETRANGE("Unit of Measure Code", SalesCrMemoLine."Unit of Measure Code");
        ReturnReceiptLine.SETFILTER(Quantity, '<>%1', 0);

        IF ReturnReceiptLine.FIND('-') THEN
            REPEAT
                IF "Sales Cr.Memo Header"."Get Return Receipt Used" THEN
                    CorrectShipment(ReturnReceiptLine);
                IF ABS(ReturnReceiptLine.Quantity) <= ABS(TotalQuantity - SalesCrMemoLine.Quantity) THEN
                    TotalQuantity := TotalQuantity - ReturnReceiptLine.Quantity
                ELSE BEGIN
                    IF ABS(ReturnReceiptLine.Quantity) > ABS(TotalQuantity) THEN
                        ReturnReceiptLine.Quantity := TotalQuantity;
                    Quantity :=
                      ReturnReceiptLine.Quantity - (TotalQuantity - SalesCrMemoLine.Quantity);

                    SalesCrMemoLine.Quantity := SalesCrMemoLine.Quantity - Quantity;
                    TotalQuantity := TotalQuantity - ReturnReceiptLine.Quantity;

                    IF ReturnReceiptHeader.GET(ReturnReceiptLine."Document No.") THEN BEGIN
                        AddBufferEntry(
                          SalesCrMemoLine,
                          -Quantity,
                          ReturnReceiptHeader."Posting Date");
                    END;
                END;
            UNTIL (ReturnReceiptLine.NEXT() = 0) OR (TotalQuantity = 0);
    end;

    procedure CorrectShipment(var ReturnReceiptLine: Record 6661);
    var
        SalesCrMemoLine: Record 115;
    begin
        SalesCrMemoLine.SETCURRENTKEY("Return Receipt No.", "Return Receipt Line No.");
        SalesCrMemoLine.SETRANGE("Return Receipt No.", ReturnReceiptLine."Document No.");
        SalesCrMemoLine.SETRANGE("Return Receipt Line No.", ReturnReceiptLine."Line No.");
        IF SalesCrMemoLine.FIND('-') THEN
            REPEAT
                ReturnReceiptLine.Quantity := ReturnReceiptLine.Quantity - SalesCrMemoLine.Quantity;
            UNTIL SalesCrMemoLine.NEXT() = 0;
    end;

    procedure AddBufferEntry(SalesCrMemoLine: Record 115; QtyOnShipment: Decimal; PostingDate: Date);
    begin
        SalesShipmentBuffer.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", SalesCrMemoLine."Line No.");
        SalesShipmentBuffer.SETRANGE("Posting Date", PostingDate);
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity - QtyOnShipment;
            SalesShipmentBuffer.MODIFY();
            EXIT;
        END;

        WITH SalesShipmentBuffer DO BEGIN
            INIT();
            "Document No." := SalesCrMemoLine."Document No.";
            "Line No." := SalesCrMemoLine."Line No.";
            "Entry No." := NextEntryNo;
            Type := SalesCrMemoLine.Type;
            "No." := SalesCrMemoLine."No.";
            Quantity := -QtyOnShipment;
            "Posting Date" := PostingDate;
            INSERT();
            NextEntryNo := NextEntryNo + 1
        END;
    end;
}

