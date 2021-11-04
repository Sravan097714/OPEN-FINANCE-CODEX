report 50019 "Sales Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\SalesOrder.rdl';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Sales Order';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            column(No_SalesInvoiceHeader; "Sales Header"."No.") { }
            column(CurrencyCode_SalesInvoiceHeader; "Sales Header"."Currency Code") { }
            column(VATText; VATText) { }
            column(VatDisplay; VatDisplay) { }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                    column(CompanyInfo_Picture; CompanyInfo.Picture) { }
                    column(CompanyInfo_Name; CompanyInfo.Name) { }
                    column(CompanyBRN; CompanyInfo.BRN) { }
                    column(CompanyVATRegNo; CompanyInfo."VAT Registration No.") { }
                    column(CompanyPhoneNo; CompanyInfo."Phone No.") { }
                    column(CompanyEmail2; CompanyInfo."Email 2") { }
                    column(PostalAddress; CompanyInfo."Postal Address") { }
                    column(CODE_Caption; CODE_CaptionLbl) { }
                    column(DESCRIPTION_Caption; DESCRIPTION_CaptionLbl) { }
                    column(UOM_Caption; UOM_CaptionLbl) { }
                    column(QTY_Caption; QTY_CaptionLbl) { }
                    column(UNIT_PRICE_Caption; UNIT_PRICE_CaptionLbl) { }
                    column(DISCOUNT_Caption; DISCOUNT_CaptionLbl) { }
                    column(NET_PRICE_Caption; NET_PRICE_CaptionLbl) { }
                    column(VAT_Caption; VAT_CaptionLbl) { }
                    column(AMOUNT_INV_Caption; AMOUNT_INV_CaptionLbl) { }
                    column(Delivered_By_Caption; Delivered_By_CaptionLbl) { }
                    column(Received_by_Caption; Received_by_CaptionLbl) { }
                    column(Payment_Terms_Caption; Payment_Terms_CaptionLbl) { }
                    column(SUB_TOTAL_Caption; SUB_TOTAL_CaptionLbl) { }
                    column(VAT1_Caption; VAT1_CaptionLbl) { }
                    column(TOTAL_Caption; TOTAL_CaptionLbl) { }
                    column(ShortcutDimension1Code_SalesInvoiceHeader; "Sales Header"."Shortcut Dimension 1 Code") { }
                    column(DueDate; "Sales Header"."Due Date") { }
                    column(ExternalDocumentNo_SalesInvoiceHeader; "Sales Header"."External Document No.") { }
                    column(PostingDate_SalesInvoiceHeader; "Sales Header"."Posting Date") { }
                    column(BilltoCustomerNo_SalesInvoiceHeader; "Sales Header"."Bill-to Customer No.") { }
                    column(SalesInvoiceHeader_Pre_Assigned_No_SalesInvoiceHeader_Order_No; "Sales Header"."No.") { }
                    column(VATRegistrationNo_SalesInvoiceHeader; CustomerVAT) { }
                    column(CustName; CustomerName) { }
                    //column(CurrReport_PAGENO; CurrReport.PAGENO()) { }
                    column(CurrCode; CurrCode) { }
                    column(Dept; Dept) { }
                    column(UPPERCASE_CompanyInfo_Name; UPPERCASE(CompanyInfo.Name)) { }
                    column(CompanyArr1_CompanyArr2_CompanyArr3_CompanyArr4; CompanyArr[1]) { }
                    column(CompanyArr5_CompanyArr6_CompanyArr7_CompanyArr8; CompanyArr[2]) { }
                    column(CompanyArr9_CompanyArr10; CompanyArr[9] + ' ' + CompanyArr[10]) { }
                    column(CompanyArr9; CompanyArr[9]) { }
                    column(CompanyArr10; CompanyArr[10]) { }
                    column(Title_2_; Title[2]) { }
                    column(Title_1_; Title[1]) { }
                    column(YourRef; YourRef) { }
                    column(B_UNIT_Caption; B_UNIT_CaptionLbl) { }
                    column(INVOICE_NO_Caption; INVOICE_NO_CaptionLbl) { }
                    column(DATE_Caption; DATE_CaptionLbl) { }
                    column(PAGE_NO_Caption; PAGE_NO_CaptionLbl) { }
                    column(CLIENT_CODE_Caption; CLIENT_CODE_CaptionLbl) { }
                    column(CURRENCY_Caption; CURRENCY_CaptionLbl) { }
                    column(SALES_NO_Caption; SALES_NO_CaptionLbl) { }
                    column(CUSTOMER_DETAILS_Caption; CUSTOMER_DETAILS_CaptionLbl) { }
                    column(DELIVERED_TO_Caption; DELIVERED_TO_CaptionLbl) { }
                    column(Colun_Caption; Colun_CaptionLbl) { }
                    column(CustAddr_1_; CustAddr[1]) { }
                    column(CustAddr_2_; CustAddr[2]) { }
                    column(CustAddr_3_; CustAddr[3]) { }
                    column(CustAddr_4_; CustAddr[4]) { }
                    column(CustAddr_5_; CustAddr[5]) { }
                    column(CustAddr_6_; CustAddr[6]) { }
                    column(CustAddr_7_; CustAddr[7]) { }
                    column(ContactName; ContactName) { }
                    column(ShipToAddr_1_; ShipToAddr[1]) { }
                    column(ShipToAddr_2_; ShipToAddr[2]) { }
                    column(ShipToAddr_3_; ShipToAddr[3]) { }
                    column(ShipToAddr_4_; ShipToAddr[4]) { }
                    column(ShipToAddr_5_; ShipToAddr[5]) { }
                    column(ShipToAddr_6_; ShipToAddr[6]) { }
                    column(ShipToAddr_7_; ShipToAddr[7]) { }
                    column(BRNText_1_; BRNText[1]) { }
                    column(BRNText_2_; BRNText[2]) { }
                    column(OutputNo; OutputNo) { }
                    column(PurchaseOrderNo; "Sales Header"."External Document No.") { }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Sales Header";
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

                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(ZERO_RATED_Z_Caption; ZERO_RATED_Z_CaptionLbl) { }
                        column(EXEMPTED_E_Caption; EXEMPTED_E_CaptionLbl) { }
                        column(TAXABLE_T_Caption; TAXABLE_T_CaptionLbl) { }
                        column(Dot_Caption; Dot_CaptionLbl) { }
                        column(No_SalesInvoiceLine; "Sales Line"."No.") { }
                        column(ItemCode2; gtextItemCode2) { }
                        column(LineNo_SalesInvoiceLine; "Sales Line"."Line No.") { }
                        column(LineDiscountAmount_SalesInvoiceLine; "Sales Line"."Line Discount Amount") { }
                        column(UnitPrice_SalesInvoiceLine; "Sales Line"."Unit Price") { }
                        column(Description_SalesInvoiceLine; COPYSTR("Sales Line".Description + ' ' + "Sales Line"."Description 2", 1, 100)) { }
                        column(UnitofMeasureCode_SalesInvoiceLine; "Sales Line"."Unit of Measure Code") { }
                        column(Quantity_SalesInvoiceLine; "Sales Line".Quantity) { }
                        column(LineAmount_SalesInvoiceLine; "Sales Line"."Line Amount") { }
                        column(AmountExcVAT; "Sales Line"."Amount Including VAT" - Amount) { }
                        column(VATStatus; VATStatus) { }
                        column(AmountIncludingVAT_SalesInvoiceLine; "Sales Line"."Amount Including VAT") { }
                        column(LineAmt; LineAmt) { }
                        column(Amount_Including_VAT_Amount; "Amount Including VAT" - Amount) { }
                        column(VATPerc; VATPerc) { }
                        column(VatAmount; VatAmount) { }
                        column(AmtIncl; AmtIncl) { }
                        column(AmountIncludingVAT; "Amount Including VAT") { }
                        column(NetPrice_1_; NetPrice[1]) { }
                        column(NetPrice_2_; NetPrice[2]) { }
                        column(NetPrice_3_; NetPrice[3]) { }
                        column(AmtInvoiced_1_; AmtInvoiced[1]) { }
                        column(AmtInvoiced_2_; AmtInvoiced[2]) { }
                        column(AmtInvoiced_3_; AmtInvoiced[3]) { }
                        column(PaymentTerms_Description; PaymentTerms.Description) { }
                        column(CompanyInfoAddr2_BankAdd; 'Bank Address') { }
                        column(CompanyInfoAddr2_BankName; 'Bank Name') { }

                        column(CompanyInfoAddr2_AccNo; 'CompanyInfoAddr2."Bank Account No."') { }
                        column(CompanyInfoAddr2_IBAN; 'CompanyInfoAddr2.IBAN') { }
                        column(CompanyInfoAddr2_SWIFT_Code; 'CompanyInfoAddr2."SWIFT Code"') { }
                        dataitem("Sales Comment Line"; "Sales Comment Line")
                        {
                            DataItemLinkReference = "Sales Line";
                            DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("POSTED INVOICE"));
                            DataItemLink = "No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                            column(SalesComment; "Sales Comment Line".Comment) { }
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
                                SalesShipmentBuffer.SETRANGE("Document No.", "Sales Line"."Document No.");
                                SalesShipmentBuffer.SETRANGE("Line No.", "Sales Line"."Line No.");
                                SETRANGE(Number, 1, SalesShipmentBuffer.COUNT());
                            end;
                        }
                        dataitem("Item Ledger Entry"; "Item Ledger Entry")
                        {
                            DataItemLinkReference = "Sales Line";
                            DataItemLink = "Item No." = FIELD("No."), "Document No." = FIELD("Document No.");
                            column(ILE_ItemNo; "Item Ledger Entry"."Serial No.") { }
                            column(ILE_Qty; "Item Ledger Entry".Quantity) { }
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

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
                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord();
                        begin
                            PostedShipmentDate := 0D;
                            CLEAR(LineAmt);
                            CLEAR(AmtIncl);
                            /* IF Quantity <> 0 THEN
                                PostedShipmentDate := FindPostedShipmentDate(); */

                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "No." := '';

                            IF VATPostingSetup.GET("Sales Line"."VAT Bus. Posting Group", "Sales Line"."VAT Prod. Posting Group") THEN
                                VATStatus := COPYSTR(VATPostingSetup."VAT Identifier", 1, 1)
                            ELSE
                                CLEAR(VATStatus);

                            IF ("Sales Line"."No." = '') AND
                               ("Sales Line".Quantity = 0) AND
                               ("Sales Line"."Unit Price" = 0) THEN
                                CLEAR(VATStatus);

                            IF DocNo = "Sales Line"."Document No." THEN BEGIN
                                CASE VATStatus OF
                                    'Z':
                                        BEGIN
                                            NetPrice[1] += "Sales Line"."Line Amount";
                                            AmtInvoiced[1] += "Sales Line"."Amount Including VAT";
                                        END;
                                    'T':
                                        BEGIN
                                            NetPrice[3] += "Sales Line"."Line Amount";
                                            AmtInvoiced[3] += "Sales Line"."Amount Including VAT";
                                            IF "VAT %" <> 0 THEN
                                                Taxable := "VAT %";
                                        END;

                                    'E':
                                        BEGIN
                                            NetPrice[2] += "Sales Line"."Line Amount";
                                            AmtInvoiced[2] += "Sales Line"."Amount Including VAT";
                                        END;

                                    ELSE BEGIN
                                            NetPrice[4] += "Sales Line"."Line Amount";
                                            AmtInvoiced[4] += "Sales Line"."Amount Including VAT";
                                        END;
                                END;
                            END ELSE BEGIN
                                DocNo := "Sales Line"."Document No.";
                                CLEAR(NetPrice);
                                CLEAR(AmtInvoiced);
                                CASE VATStatus OF
                                    'Z':
                                        BEGIN
                                            NetPrice[1] := "Sales Line"."Line Amount";
                                            AmtInvoiced[1] := "Sales Line"."Amount Including VAT";
                                        END;
                                    'T':
                                        BEGIN
                                            NetPrice[3] := "Sales Line"."Line Amount";
                                            AmtInvoiced[3] += "Sales Line"."Amount Including VAT";
                                            IF "VAT %" <> 0 THEN
                                                Taxable := "VAT %";
                                        END;

                                    'E':
                                        BEGIN
                                            NetPrice[2] := "Sales Line"."Line Amount";
                                            AmtInvoiced[2] := "Sales Line"."Amount Including VAT";
                                        END;

                                    ELSE BEGIN
                                            NetPrice[4] := "Sales Line"."Line Amount";
                                            AmtInvoiced[4] := "Sales Line"."Amount Including VAT";
                                        END;
                                END;
                            END;

                            VATAmountLine.INIT();
                            VATAmountLine."VAT %" := "VAT %";
                            VATAmountLine.InsertLine();

                            IF "VAT %" <> 0 THEN
                                VATPerc := "VAT %";

                            clear(gtextItemCode2);
                            if grecItem.get("Sales Line"."No.") then
                                gtextItemCode2 := grecItem."No. 2";
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
                            //CurrReport.CREATETOTALS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", LineAmt, AmtIncl);

                            CLEAR(NetPrice);       //asaad 30/10/07
                            CLEAR(AmtInvoiced);    //asaad 30/10/07
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
                        Title[2] := Text003;
                        OutputNo += 1;
                    END;
                end;

                trigger OnPostDataItem();
                begin
                    /* IF NOT CurrReport.PREVIEW() THEN
                        SalesInvCountPrinted.RUN("Sales Header"); */
                end;

                trigger OnPreDataItem();
                begin

                    NoOfLoops := ABS(NoOfCopies) + Cust."Invoice Copies" + 1;
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord();
            var
                grecSalesInvLine: Record "Sales Line";
            begin

                CLEAR(CurrCode);
                CLEAR(BRNText);
                Clear(Dept);
                Clear(ContactName);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                IF "Sales Header"."No. Printed" > 0 THEN
                    Title[2] := 'COPY'
                ELSE
                    Title[2] := '';

                IF "Sales Header"."External Document No." <> '' THEN BEGIN
                    YourRef := Text007;
                    Dot := Text008;
                END ELSE BEGIN
                    CLEAR(YourRef);
                    CLEAR(Dot);
                END;

                IF "Sales Header"."Currency Code" <> '' THEN
                    CurrCode := COPYSTR("Sales Header"."Currency Code", 1, 3)
                ELSE BEGIN
                    IF GLSetup.GET() THEN
                        CurrCode := GLSetup."LCY Code";
                END;

                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

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

                clear(CustomerName);
                clear(CustomerVAT);
                FormatAddr.SalesHeaderBillTo(CustAddr, "Sales Header");
                IF Customer.GET("Sales Header"."Bill-to Customer No.") THEN BEGIN
                    CustomerName := Customer.Name;
                    CustomerVAT := Customer."VAT Registration No.";
                    CustAddr[1] := Customer.Address;
                    CustAddr[2] := Customer."Address 2";
                    CustAddr[3] := Customer.City;
                    CustAddr[5] := Customer.BRN;
                    IF Country.GET(Customer."Country/Region Code") THEN
                        CustAddr[4] := Country.Name
                    else
                        CustAddr[4] := '';
                END;
                COMPRESSARRAY(CustAddr);

                IF Customer.GET("Sales Header"."Bill-to Customer No.") THEN BEGIN
                    ContactName := Customer.Contact;
                END;


                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT()
                ELSE
                    PaymentTerms.GET("Payment Terms Code");


                Formataddress.GetCustomer("Sales Header"."Bill-to Customer No.", BRNText[2], BRNText[1]);
                //FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, "Sales Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;


                //RCTS1.0 03/07/19
                CLEAR(VATText);
                Clear(VatAmount);
                grecSalesInvLine.Reset;
                grecSalesInvLine.SetRange("Document No.", "No.");
                grecSalesInvLine.SetFilter("VAT %", '<>%1', 0);
                if grecSalesInvLine.FindFirst then begin
                    VATText := 'VAT(' + Format(grecSalesInvLine."VAT %") + '%)';
                end else
                    VATText := 'VAT(0%)';
                //RCTS1.0 03/07/19


                VatAmount := grecSalesInvLine."Amount Including VAT" - grecSalesInvLine."Line Amount";
                IF VatAmount = 0 THEN
                    Title[1] := 'INVOICE'
                ELSE
                    Title[1] := 'VAT INVOICE';
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
        GLSetup: Record 98;
        ShipmentMethod: Record 10;
        grecItem: Record Item;
        PaymentTerms: Record 3;
        SalesPurchPerson: Record 13;
        CompanyInfo: Record 79;
        CompanyInfo1: Record 79;
        CompanyInfo2: Record 79;
        SalesSetup: Record 311;
        Cust: Record 18;
        VATAmountLine: Record 290 temporary;
        RespCenter: Record 5714;
        Language: Record 8;
        //SalesInvCountPrinted: Codeunit Sales Ord
        FormatAddr: Codeunit 365;
        SegManagement: Codeunit SegManagement;
        SalesShipmentBuffer: Record 7190 temporary;
        PostedShipmentDate: Date;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        OrderNoText: Text[30];
        SalesPersonText: Text[30];
        VATNoText: Text[30];
        VatAmount: Decimal;
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        NextEntryNo: Integer;
        FirstValueEntryNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        Title: array[3] of Text[30];
        Item: Record 27;
        VATStatus: Text[1];
        Formataddress: Codeunit 50008;
        ContactName: Text[250];
        CompanyArr: array[10] of Text[95];
        YourRef: Code[10];
        Dot: Text[1];
        VatDisplay: Text[30];
        VATPostingSetup: Record 325;
        CurrCode: Code[3];
        "eisAsaad-----------301007": Integer;
        DocNo: Code[20];
        NetPrice: array[4] of Decimal;
        AmtInvoiced: array[4] of Decimal;
        Taxable: Decimal;
        Customer: Record 18;
        BRNText: array[2] of Text[30];
        LineAmt: Decimal;
        AmtIncl: Decimal;
        Country: Record 9;
        //TecLibrary: Codeunit 50025;
        VATPerc: Decimal;
        //EISLibrary: Codeunit 50005;
        //CompanyInfoAddr2: Record 50004;
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Sales - Invoice %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        Text007: Label 'YOUR REF ';
        Text008: Label ':';
        Text009: Label 'VAT Registration No.';
        Text010: Label 'BRN No.';
        B_UNIT_CaptionLbl: Label 'B/UNIT';
        INVOICE_NO_CaptionLbl: Label 'INVOICE NO.';
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
        ZERO_RATED_Z_CaptionLbl: Label 'ZERO RATED -Z';
        EXEMPTED_E_CaptionLbl: Label 'EXEMPTED-E';
        TAXABLE_T_CaptionLbl: Label 'TAXABLE-T';
        Financial_Charges_CaptionLbl: Label 'Financial Charges at an annual rate of 3% pa above the Bank of Mauritius repo rate will be charged on all overdue balance';
        All_legal_fees_CaptionLbl: Label 'All legal fees will be charged to the customer for recovery through an Attorney / Solicitor';
        OutputNo: Integer;
        Dot_CaptionLbl: Label '................................................................';
        Colun_CaptionLbl: Label ':';
        DimSetEntry1: Record 480;
        DimSetEntry2: Record 480;
        VATText: Text;
        SalesInvHdr: Record 112;
        Dept: Code[20];

        CustomerName: Text;
        CustomerVAT: Text;
        gtextItemCode2: Text;

    //ARPayTerms: Record 50031;

    /* procedure FindPostedShipmentDate(): Date;
    var
        SalesShipmentHeader: Record 110;
        SalesShipmentBuffer2: Record 7190 temporary;
    begin
        NextEntryNo := 1;
        IF "Sales Line"."Shipment No." <> '' THEN
            IF SalesShipmentHeader.GET("Sales Line"."Shipment No.") THEN
                EXIT(SalesShipmentHeader."Posting Date");

        IF "Sales Header"."No." = '' THEN
            EXIT("Sales Header"."Posting Date");

        CASE "Sales Line".Type OF
            "Sales Line".Type::Item:
                GenerateBufferFromValueEntry("Sales Line");
            "Sales Line".Type::"G/L Account", "Sales Line".Type::Resource,
          "Sales Line".Type::"Charge (Item)", "Sales Line".Type::"Fixed Asset":
                GenerateBufferFromShipment("Sales Line");
            "Sales Line".Type::" ":
                EXIT(0D);
        END;

        SalesShipmentBuffer.RESET();
        SalesShipmentBuffer.SETRANGE("Document No.", "Sales Line"."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", "Sales Line"."Line No.");
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer2 := SalesShipmentBuffer;
            IF SalesShipmentBuffer.NEXT() = 0 THEN BEGIN
                SalesShipmentBuffer.GET(
                  SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                SalesShipmentBuffer.DELETE();
                EXIT(SalesShipmentBuffer2."Posting Date");
                // ;
            END;
            SalesShipmentBuffer.CALCSUMS(Quantity);
            IF SalesShipmentBuffer.Quantity <> "Sales Line".Quantity THEN BEGIN
                SalesShipmentBuffer.DELETEALL();
                EXIT("Sales Header"."Posting Date");
            END;
        END ELSE
            EXIT("Sales Header"."Posting Date");
    end; */

    procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record 113);
    var
        ValueEntry: Record 5802;
        ItemLedgerEntry: Record 32;
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
        ValueEntry.SETCURRENTKEY("Document No.", "Posting Date");
        ValueEntry.SETRANGE("Document No.", SalesInvoiceLine2."Document No.");
        ValueEntry.SETRANGE("Posting Date", "Sales Header"."Posting Date");
        ValueEntry.SETRANGE("Item Charge No.", '');
        ValueEntry.SETFILTER("Entry No.", '%1..', FirstValueEntryNo);
        IF ValueEntry.FIND('-') THEN
            REPEAT
                IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
                    IF SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 THEN
                        Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
                    ELSE
                        Quantity := ValueEntry."Invoiced Quantity";
                    AddBufferEntry(
                      SalesInvoiceLine2,
                      -Quantity,
                      ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
                END;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
            UNTIL (ValueEntry.NEXT() = 0) OR (TotalQuantity = 0);
    end;

    procedure GenerateBufferFromShipment(SalesInvoiceLine: Record 113);
    var
        SalesInvoiceHeader: Record 112;
        SalesInvoiceLine2: Record 113;
        SalesShipmentHeader: Record 110;
        SalesShipmentLine: Record 111;
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := 0;
        SalesInvoiceHeader.SETCURRENTKEY("Order No.");
        SalesInvoiceHeader.SETFILTER("No.", '..%1', "Sales Header"."No.");
        SalesInvoiceHeader.SETRANGE("Order No.", "Sales Header"."No.");
        IF SalesInvoiceHeader.FIND('-') THEN
            REPEAT
                SalesInvoiceLine2.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine2.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
                SalesInvoiceLine2.SETRANGE(Type, SalesInvoiceLine.Type);
                SalesInvoiceLine2.SETRANGE("No.", SalesInvoiceLine."No.");
                SalesInvoiceLine2.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
                IF SalesInvoiceLine2.FIND('-') THEN
                    REPEAT
                        TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
                    UNTIL SalesInvoiceLine2.NEXT() = 0;
            UNTIL SalesInvoiceHeader.NEXT() = 0;

        SalesShipmentLine.SETCURRENTKEY("Order No.", "Order Line No.");
        SalesShipmentLine.SETRANGE("Order No.", "Sales Header"."No.");
        SalesShipmentLine.SETRANGE("Order Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE(Type, SalesInvoiceLine.Type);
        SalesShipmentLine.SETRANGE("No.", SalesInvoiceLine."No.");
        SalesShipmentLine.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
        SalesShipmentLine.SETFILTER(Quantity, '<>%1', 0);

        IF SalesShipmentLine.FIND('-') THEN
            REPEAT
                IF "Sales Header"."Get Shipment Used" THEN
                    CorrectShipment(SalesShipmentLine);
                IF ABS(SalesShipmentLine.Quantity) <= ABS(TotalQuantity - SalesInvoiceLine.Quantity) THEN
                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
                ELSE BEGIN
                    IF ABS(SalesShipmentLine.Quantity) > ABS(TotalQuantity) THEN
                        SalesShipmentLine.Quantity := TotalQuantity;
                    Quantity :=
                      SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);

                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
                    SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;

                    IF SalesShipmentHeader.GET(SalesShipmentLine."Document No.") THEN BEGIN
                        AddBufferEntry(
                          SalesInvoiceLine,
                          Quantity,
                          SalesShipmentHeader."Posting Date");
                    END;
                END;
            UNTIL (SalesShipmentLine.NEXT() = 0) OR (TotalQuantity = 0);
    end;

    procedure CorrectShipment(var SalesShipmentLine: Record 111);
    var
        SalesInvoiceLine: Record 113;
    begin
        SalesInvoiceLine.SETCURRENTKEY("Shipment No.", "Shipment Line No.");
        SalesInvoiceLine.SETRANGE("Shipment No.", SalesShipmentLine."Document No.");
        SalesInvoiceLine.SETRANGE("Shipment Line No.", SalesShipmentLine."Line No.");
        IF SalesInvoiceLine.FIND('-') THEN
            REPEAT
                SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
            UNTIL SalesInvoiceLine.NEXT() = 0;
    end;

    procedure AddBufferEntry(SalesInvoiceLine: Record 113; QtyOnShipment: Decimal; PostingDate: Date);
    begin
        SalesShipmentBuffer.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentBuffer.SETRANGE("Posting Date", PostingDate);
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity + QtyOnShipment;
            SalesShipmentBuffer.MODIFY();
            EXIT;
        END;

        WITH SalesShipmentBuffer DO BEGIN
            "Document No." := SalesInvoiceLine."Document No.";
            "Line No." := SalesInvoiceLine."Line No.";
            "Entry No." := NextEntryNo;
            Type := SalesInvoiceLine.Type;
            "No." := SalesInvoiceLine."No.";
            Quantity := QtyOnShipment;
            "Posting Date" := PostingDate;
            INSERT();
            NextEntryNo := NextEntryNo + 1
        END;
    end;
}

