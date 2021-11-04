report 50018 "Purchase Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\PurchaseOrder2.rdl';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Purchase Order';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            column(Name_CompanyInfo; CompanyInfo.Name)
            {
            }
            column(Picture_CompanyInfo; CompanyInfo.Picture)
            {
            }
            column(CompanyArr1_2_3_4_; CompanyArr[1])
            {
            }
            column(CompanyArr5_6_7_8_; CompanyArr[2])
            {
            }
            column(CompanyArr9_10_; CompanyArr[9] + ', ' + CompanyArr[10])
            {
            }
            column(CompanyBRN; CompanyInfo.BRN) { }
            column(CompanyVATRegNo; CompanyInfo."VAT Registration No.") { }
            column(CompanyPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyEmail2; CompanyInfo."Email 2") { }
            column(CompanyFAX; CompanyInfo."Fax No.") { }
            column(PostalAddress; CompanyInfo."Postal Address") { }
            column(PrintInstruction; PrintInstruction)
            {
            }
            column(Request_for_Purchase_No_; "Request for Purchase No.") { }
            column(Procurement_Reference_No_; "Procurement Reference No.") { }
            column(Request_Dated; format("Request Dated")) { }
            column(CurrReport_PAGENO; 'CurrReport_PAGENO') { }
            column(Title_2; Title[2])
            {
            }
            column(Title_1; Title[1])
            {
            }
            column(NetPrice1_; NetPrice[1])
            {
            }
            column(NetPrice2_; NetPrice[2])
            {
            }
            column(NetPrice3_; NetPrice[3])
            {
            }
            column(ShortcutDimension1Code_PurchHdr; "Purchase Header"."Shortcut Dimension 1 Code")
            {
            }
            column(USERID; OrdertakenBy)
            {
            }
            column(PaymentTerms_Description; PaymentTerms.Description)
            {
                IncludeCaption = true;
            }
            column(ShipmentMethodCode_PurchHdr; "Purchase Header"."Shipment Method Code")
            {
            }

            column(No_PurchHdr; "Purchase Header"."No.")
            {
            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {

            }
            column(DocumentType_PurchHdr; "Purchase Header"."Document Type")
            {
            }
            column(OrderDate_PurchHdr; "Purchase Header"."Order Date")
            {
            }
            column(VATRegNo; VATRegNo)
            {

            }
            column(CurrCode; CurrCode)
            {
            }
            column(ExpectedReceiptDate_PurchHdr; "Purchase Header"."Expected Receipt Date")
            {
            }
            column(BuyfromVendorNo_PurchHdr; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(CurrencyCode_PurchaseHeader; "Purchase Header"."Currency Code")
            {
            }
            column(BuyFromAddr_1; BuyFromAddr[1])
            {
            }
            column(BuyFromAddr_2; BuyFromAddr[2])
            {
            }
            column(BuyFromAddr_3; BuyFromAddr[3])
            {
            }
            column(BuyFromAddr_4; BuyFromAddr[4])
            {
            }
            column(BuyFromAddr_5; BuyFromAddr[5])
            {
            }
            column(BuyFromAddr_6; BuyFromAddr[6])
            {
            }
            column(BuyFromAddr_7; BuyFromAddr[7])
            {
            }
            column(Buy_from_City; "Buy-from City") { }
            column(BRNText_1; BRNText[1])
            {
            }
            column(BRNText_2; BRNText[2])
            {
            }
            column(BUnitCaption; BUnitCaptionLbl)
            {
            }
            column(OrderTakenByCaption; OrderTakenByCaptionLbl)
            {
            }
            column(TermCaption; TermCaptionLbl)
            {
            }
            column(ShipmentTermsCaption; ShipmentTermsCaptionLbl)
            {
            }
            column(TransportMethodCaption; TransportMethodCaptionLbl)
            {
            }
            column(OrderNumberCaption; OrderNumberCaptionLbl)
            {
            }
            column(OrderDateCaption; OrderDateCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(CurrencyCaption; CurrencyCaptionLbl)
            {
            }
            column(DeliveryDateCaption; DeliveryDateCaptionLbl)
            {
            }
            column(SupplierNoCaption; SupplierNoCaptionLbl)
            {
            }
            column(SupplierCaption; SupplierCaptionLbl)
            {
            }
            column(ShipToCaption; ShipToCaptionLbl)
            {
            }
            column(DeliveryInstructionsCaption; DeliveryInstructionsCaptionLbl)
            {
            }
            column(AuthorizedByCaption; AuthorizedByCaptionLbl)
            {
            }
            column(PreparedByCaption; PreparedByCaptionLbl)
            {
            }
            column(SubTotalCaption; SubTotalCaptionLbl)
            {
            }
            column(VatCaption; VatCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(CodeCaption; CodeCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(QtyCaption; QtyCaptionLbl)
            {
            }
            column(UnitPriceCaption; UnitPriceCaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(PUCaption; PUCaptionLbl)
            {
            }
            column(AmountEcxlVatCaption; AmountEcxlVatCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(ShipToAddr_1; ShipToAddr[1])
            {
            }
            column(ShipToAddr_2; ShipToAddr[2])
            {
            }
            column(ShipToAddr_3; ShipToAddr[3])
            {
            }
            column(ShipToAddr_4; ShipToAddr[4])
            {
            }
            column(ShipToAddr_5; ShipToAddr[5])
            {
            }
            column(ShipToAddr_6; ShipToAddr[6])
            {
            }
            column(ShipToAddr_7; ShipToAddr[7])
            {
            }
            column(POPreparedBy; POPreparedBy)
            {
            }
            column(ApprovedBy; ApprovedBy)
            {
            }
            column(Created_By; CreatedBy)
            {
            }
            column(Approved_By; Approved)
            {
            }
            column(gtextVendorAccNo; gtextVendorAccNo) { }

            column(EarmarkedBy; gtextEarmarkedBy) { }
            column(gdateEarmarked; format(gdateEarmarked)) { }


            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(OutputNo; OutputNo)
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Purchase Header";
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
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem();
                        begin
                            CurrReport.BREAK();
                        end;
                    }

                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(PurchLine_AmountIncludingVAT_PurchLine_AmountAmtExlVAT_; (PurchLine."Amount Including VAT" - PurchLine.Amount) + AmtExlVAT)
                        {
                        }
                        column(AmtExlVAT; AmtExlVAT)
                        {
                        }
                        column(PurchLine_AmountIncludingVAT_PurchLine_Amount_; "Purchase Line"."Amount Including VAT" - "Purchase Line".Amount)
                        {
                        }
                        column(VATAmountLine_VAT; VATAmountLine."VAT %")
                        {
                        }
                        column(No_PurchLne; COPYSTR("Purchase Line"."No.", 1, 17))
                        {
                        }
                        column(Description_PurchLne; "Purchase Line"."Description")
                        {
                        }
                        column(Description2; "Purchase Line"."Description 2") { }
                        column(Quantity_PurchLne; "Purchase Line".Quantity)
                        {
                        }
                        column(DirectUnitCost_PurchLne; "Purchase Line"."Direct Unit Cost")
                        {
                            //AutoFormatExpression = "Purchase Header"."Currency Code";
                        }
                        column(UnitofMeasureCode_PurchLne; "Purchase Line"."Unit of Measure Code")
                        {
                        }
                        column(Amount_PurchLne; "Purchase Line"."Amount Including VAT" - "Purchase Line".Amount)
                        {
                        }
                        column(AmountIncVat; "Purchase Line"."Amount Including VAT")
                        {
                        }
                        column(UOM; UOM)
                        {
                        }
                        column(DirectUnitCost_PurchaseLineQuantity_; "Purchase Line"."Direct Unit Cost" * "Purchase Line".Quantity)
                        {
                        }
                        column(LineNo_PurchLne; "Purchase Line"."Line No.")
                        {
                        }
                        column(LineDiscountAmount; "Purchase Line"."Line Discount Amount")
                        {
                        }
                        column(EarmarkID; "Purchase Line"."Earmark ID") { }
                        column(DateEarmarked; format("Purchase Line"."Date Earmarked")) { }
                        dataitem("Purch. Comment Line"; "Purch. Comment Line")
                        {
                            DataItemLinkReference = "Purchase Line";
                            DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(ORDER));
                            DataItemLink = "No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                            column(PurchComment; "Purch. Comment Line".Comment)
                            {
                            }
                            column(Document_Type; "Document Type") { }
                            column(No_; "No.") { }
                            column(Document_Line_No_; "Document Line No.") { }
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

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Purchase Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord();
                        begin

                            CLEAR(AmtExlVAT);
                            CLEAR(UOM);
                            IF Number = 1 THEN
                                PurchLine.FIND('-')
                            ELSE
                                PurchLine.NEXT();
                            "Purchase Line" := PurchLine;

                            IF NOT "Purchase Header"."Prices Including VAT" AND
                               (PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                PurchLine."Line Amount" := 0;

                            IF (PurchLine.Type = PurchLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "Purchase Line"."No." := '';

                            AmtExlVAT := PurchLine."Direct Unit Cost" * PurchLine.Quantity;

                            IF Item.GET("Purchase Line"."No.") THEN
                                UOM := Item."Purch. Unit of Measure";


                        end;



                        trigger OnPostDataItem();
                        begin
                            //RoundLoop - OnPostDataItem()
                            PurchLine.DELETEALL();
                        end;

                        trigger OnPreDataItem();
                        begin

                            MoreLines := PurchLine.FIND('+');
                            WHILE MoreLines AND (PurchLine.Description = '') AND (PurchLine."Description 2" = '') AND
                                  (PurchLine."No." = '') AND (PurchLine.Quantity = 0) AND
                                  (PurchLine.Amount = 0) DO
                                MoreLines := PurchLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            PurchLine.SETRANGE("Line No.", 0, PurchLine."Line No.");
                            SETRANGE(Number, 1, PurchLine.COUNT());
                            /* CurrReport.CREATETOTALS(PurchLine."Line Amount", PurchLine."Inv. Discount Amount", AmtExlVAT,
                            PurchLine.Amount, PurchLine."Amount Including VAT"); */
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);

                        trigger OnAfterGetRecord();
                        begin
                            //VATCounter - OnAfterGetRecord()
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem();
                        begin
                            //VATCounter - OnPreDataItem()
                            IF VATAmount = 0 THEN
                                CurrReport.BREAK;
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

                        trigger OnPreDataItem();
                        begin
                            //Total2 - OnPreDataItem()
                            IF "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(Total3; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));

                        trigger OnPreDataItem();
                        begin
                            //Total3 - OnPreDataItem()
                            IF ("Purchase Header"."Sell-to Customer No." = '') AND (ShipToAddr[1] = '') THEN
                                CurrReport.BREAK();
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                begin

                    CLEAR(PurchLine);
                    CLEAR(PurchPost);
                    PurchLine.DELETEALL();
                    VATAmountLine.DELETEALL();
                    PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);
                    PurchLine.CalcVATAmountLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    PurchLine.UpdateVATOnLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := VATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT();


                    IF Number > 1 THEN BEGIN
                        //Title[2] := Text003;
                        OutputNo := OutputNo + 1;
                    END;

                    if OutputNo = 0 then
                        Title[2] := 'ORIGINAL';
                    if OutputNo = 1 then
                        Title[2] := 'DUPLICATE';
                    if OutputNo = 2 then
                        Title[2] := 'TRIPLICATE';
                    if OutputNo = 3 then
                        Title[2] := 'QUADRUPLICATE';


                    //CurrReport.PAGENO := 1;
                end;


                trigger OnPostDataItem();
                begin

                    IF NOT CurrReport.PREVIEW() THEN
                        PurchCountPrinted.RUN("Purchase Header");
                end;

                trigger OnPreDataItem();
                begin
                    //NoOfLoops := ABS(NoOfCopies) + 1;
                    NoOfLoops := 4;
                    //NoOfCopies := 4;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                User.RESET;
                User.SETRANGE(User."User Name", "Purchase Header"."Created By");
                IF User.FINDLAST THEN BEGIN
                    OrdertakenBy := User."Full Name";
                END;

                clear(gtextEarmarkedBy);
                User.RESET;
                User.SETRANGE(User."User Name", "Purchase Header".Earmarked);
                IF User.FINDLAST THEN BEGIN
                    gtextEarmarkedBy := User."Full Name";
                END;

                Clear(VatRegNo);
                clear(gtextVendorAccNo);
                IF Vendor.GET("Purchase Header"."Buy-from Vendor No.") THEN BEGIN
                    VATRegNo := Vendor."VAT Registration No.";
                    //gtextVendorAccNo := Vendor."Account No.";
                END;

                CLEAR(BRNText);

                CLEAR(CurrCode);
                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                /* IF "No. Printed" > 0 THEN
                    Title[2] := 'COPY'
                ELSE
                    Title[2] := 'ORIGINAL'; */

                IF Supplier.GET("Purchase Header"."Ship-to Code") THEN;

                IF "Currency Code" = '' THEN BEGIN
                    IF GLSetup.GET() THEN
                        CurrCode := GLSetup."LCY Code";
                END ELSE
                    CurrCode := COPYSTR("Currency Code", 1, 3);


                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");

                IF Vendor.GET("Purchase Header"."Buy-from Vendor No.") THEN BEGIN
                    BuyFromAddr[1] := Vendor.Name;
                    BuyFromAddr[2] := Vendor.Address;
                    if Vendor."Address 2" <> '' then
                        BuyFromAddr[2] += ', ' + Vendor."Address 2";
                    BuyFromAddr[3] := Vendor.City;
                    BuyFromAddr[4] := Vendor."Fax No.";
                    BuyFromAddr[5] := Vendor."E-Mail";
                END;
                //COMPRESSARRAY(BuyFromAddr);

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT()
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                FormatAddr.PurchHeaderShipTo(ShipToAddr, "Purchase Header");
                Formataddress.GetVendor("Purchase Header"."Buy-from Vendor No.", BRNText[2], BRNText[1]);

                //EIS-ZS-001 BEGIN
                CLEAR(NetPrice);
                CLEAR(AmtInvoiced);
                CLEAR(VATStatus);

                PurchLineGRec.RESET();
                PurchLineGRec.SETRANGE(PurchLineGRec."Document Type", "Purchase Header"."Document Type");
                PurchLineGRec.SETRANGE(PurchLineGRec."Document No.", "Purchase Header"."No.");
                IF PurchLineGRec.FINDFIRST() THEN BEGIN
                    REPEAT
                        IF (PurchLineGRec."No." <> '') AND (PurchLineGRec.Quantity <> 0) THEN BEGIN
                            IF VATPostingSetup.GET(PurchLineGRec."VAT Bus. Posting Group", PurchLineGRec."VAT Prod. Posting Group") THEN BEGIN
                                VATStatus := COPYSTR(VATPostingSetup."VAT Identifier", 1, 1);
                                CASE VATStatus OF
                                    'Z':
                                        BEGIN
                                            NetPrice[1] += PurchLineGRec."Line Amount";

                                        END;

                                    'T':
                                        BEGIN
                                            NetPrice[3] += PurchLineGRec."Line Amount";

                                        END;

                                    'E':
                                        BEGIN
                                            NetPrice[2] += PurchLineGRec."Line Amount";

                                        END;
                                END;
                            END;
                        END;
                    UNTIL PurchLineGRec.NEXT() = 0;
                END;
                //EIS-ZS-001 END


                grecPurchaseLine.Reset();
                grecPurchaseLine.SetRange("Document No.", "No.");
                if grecPurchaseLine.FindFirst() then
                    gdateEarmarked := grecPurchaseLine."Date Earmarked";

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
                    field(NoofCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = all;
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                        Visible = false;
                        ApplicationArea = all;
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        Caption = 'Archive Document';
                        Visible = false;
                        ApplicationArea = all;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
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

    trigger OnInitReport();
    begin
        //Report - OnInitReport()
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture);
        Formataddress.Companys(CompanyArr, CompanyInfo);

        Title[1] := Text007;
    end;


    procedure SetTitle2(ptextTitle2: Text)
    begin
        Title[2] := ptextTitle2;
    end;


    var
        gdateEarmarked: Date;
        gtextEarmarkedBy: Text;
        grecPurchaseLine: Record "Purchase Line";
        Text000: Label 'Purchaser';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Order %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        Text007: Label 'PURCHASE ORDER';
        Text008: Label 'You do not have permission to reprint this document.';
        GLSetup: Record 98;
        CompanyInfo: Record 79;
        ShipmentMethod: Record 10;
        PaymentTerms: Record 3;
        SalesPurchPerson: Record 13;
        Vendor: Record 23;
        VatRegNo: Text[50];
        VATAmountLine: Record 290 temporary;
        PurchLine: Record 39 temporary;
        RespCenter: Record 5714;
        Language: Record 8;
        PurchCountPrinted: Codeunit 317;
        FormatAddr: Codeunit 365;
        PurchPost: Codeunit 90;
        ArchiveManagement: Codeunit 5063;
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        BuyFromAddr: array[8] of Text[250];
        PurchaserText: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        Supplier: Record 23;
        Formataddress: Codeunit 50008;
        CompanyArr: array[10] of Text[95];
        Title: array[3] of Text[30];
        Item: Record 27;
        AmtExlVAT: Decimal;
        TransMethod: array[6] of Text[1];
        UOM: Code[10];
        CurrCode: Code[3];
        BRNText: array[2] of Text[30];
        BUnitCaptionLbl: Label 'DEPARTMENT';
        OrderTakenByCaptionLbl: Label 'ORDER TAKEN  BY';
        TermCaptionLbl: Label 'TERM';
        ShipmentTermsCaptionLbl: Label 'SHIPMENT TERMS';
        TransportMethodCaptionLbl: Label 'TRANSPORT METHOD ';
        OrderNumberCaptionLbl: Label 'ORDER NUMBER';
        OrderDateCaptionLbl: Label 'ORDER DATE';
        PageCaptionLbl: Label 'PAGE                     ';
        CurrencyCaptionLbl: Label 'CURRENCY           ';
        DeliveryDateCaptionLbl: Label 'DELIVERY DATE   ';
        SupplierNoCaptionLbl: Label 'SUPPLIER NO      ';
        SupplierCaptionLbl: Label 'SUPPLIER';
        ShipToCaptionLbl: Label 'SHIP TO';
        DeliveryInstructionsCaptionLbl: Label 'DELIVERY INSTRUCTIONS';
        AuthorizedByCaptionLbl: Label 'Authorised By:';
        PreparedByCaptionLbl: Label 'Prepared By:';
        SubTotalCaptionLbl: Label 'SUB TOTAL';
        VatCaptionLbl: Label 'VAT (%)';
        TotalCaptionLbl: Label 'TOTAL';
        CodeCaptionLbl: Label 'CODE';
        DescriptionCaptionLbl: Label 'DESCRIPTION';
        QtyCaptionLbl: Label 'QTY ORDERED';
        UnitPriceCaptionLbl: Label 'UNIT PRICE';
        UOMCaptionLbl: Label 'UOM';
        PUCaptionLbl: Label 'PU UM';
        AmountEcxlVatCaptionLbl: Label 'AMOUNT EXCL VAT';
        EmptyStringCaptionLbl: Label ':';
        OutputNo: Integer;
        DimSetEntry1: Record 480;
        DimSetEntry2: Record 480;
        NetPrice: array[4] of Decimal;
        PurchLineGRec: Record 39;
        VATStatus: Text[1];
        VATPostingSetup: Record 325;
        AmtInvoiced: array[4] of Decimal;
        ApprovedBy: Text[100];
        ApprovalEntries: Record 454;
        POPreparedBy: Text[100];
        TextDot: Label '..............................................................';
        //CompanySecPermission: Record 50003;
        ActiveSession: Record 2000000110;
        User: Record 2000000120;
        User3: Record 2000000120;
        OrdertakenBy: Text;
        PrintInstruction: Text[250];
        CreatedBy: Text;
        Approved: Text;
        Customer: Record 18;
        gtextVendorAccNo: Text[20];
}

