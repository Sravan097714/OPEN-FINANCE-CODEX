report 50000 "MRA Sales VAT"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = SORTING("Primary Key");
            dataitem("VAT Entry"; "VAT Entry")
            {
                DataItemTableView = SORTING("Document Type", "Posting Date")
                                    ORDER(Ascending)
                                    WHERE(Type = CONST(Sale), "VAT Prod. Posting Group" = filter(<> 'TDS'));
                RequestFilterFields = "Posting Date";

                trigger OnAfterGetRecord()
                begin
                    IF DocNo = '' THEN BEGIN
                        Recordcount := EntryCount("VAT Entry"."Document No.");
                        VatEntryRecordCount := 0;
                        DocNo := "VAT Entry"."Document No.";
                        TTBASE := 0;
                        TTAMT := 0;
                    END;

                    VatEntryRecordCount += 1;

                    // TTBASE += ROUND("VAT Entry"."Additional-Currency Base 1, 1,'=');
                    TTBASE += ROUND("VAT Entry".Base, 1, '=');
                    // TTAMT += ROUND("VAT Entry"."Additional-Currency Amount 1, 1,'=');
                    TTAMT += ROUND("VAT Entry".Amount, 1, '=');

                    IF "VAT Entry".Type = "VAT Entry".Type::Sale THEN
                        IF "VAT Entry"."Bill-to/Pay-to No." <> '' THEN
                            Customer.GET("VAT Entry"."Bill-to/Pay-to No.");


                    grecCustLedgerEntry.Reset();
                    grecCustLedgerEntry.SetRange("Document No.", "Document No.");
                    if grecCustLedgerEntry.FindFirst then begin
                        gtextDescription := grecCustLedgerEntry.Description;
                    end;


                    IF VatEntryRecordCount = Recordcount THEN BEGIN
                        IF Customer.Name <> ' ' THEN BEGIN
                            ExcelBuf.NewRow;
                            ExcelBuf.AddColumn((Customer."VAT Registration No."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn(Customer.Name, FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                            CLEAR(Newvalur);
                            ExcelBuf.AddColumn(TTBASE * -1, FALSE, '@', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            CLEAR(Newvalur);
                            ExcelBuf.AddColumn(TTAMT * -1, FALSE, '@', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

                            ExcelBuf.AddColumn(FORMAT("VAT Entry"."Posting Date", 10, '<Year4><Month,2><Day,2>'), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn("VAT Entry"."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn(Customer.BRN, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            //ExcelBuf.AddColumn("VAT Entry"."VAT Bus. Posting Group", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            //ExcelBuf.AddColumn("VAT Entry"."VAT Prod. Posting Group", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn(gtextDescription, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            DocNo := '';


                        END;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    "VAT Entry".SETFILTER("VAT Entry"."Posting Date", '%1..%2', StartingDate, EndingDate);
                    CLEAR(DocNo);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Month := FORMAT(DATE2DMY(EndingDate, 2));
                Year := FORMAT(DATE2DMY(EndingDate, 3));
                Window.OPEN(Text000);
                MakeExcelDataHeader;
                //"VAT Entry".SETFILTER("VAT Entry"."Posting Date",'%1..%2',StartingDate,EndingDate);
            end;
        }
    }

    requestpage
    {

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

    labels
    {
    }

    trigger OnPostReport()
    begin
        CreateExcelBook;
    end;

    var
        StartingDate: Date;
        EndingDate: Date;
        VLE: Record "Vendor Ledger Entry";
        PaymentAmt: Decimal;
        PurchInvHdr: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchInvLine: record "Purch. Inv. Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        VarDesc: Text[50];
        VarAmtExclVAT: Decimal;
        VarVATAmt: Decimal;
        VarInvoiceNo: Text[50];
        VarName: Text[50];
        VarPaidAmt: Decimal;
        Window: Dialog;
        VLEIn: Record "Vendor Ledger Entry";
        GLEntry: Record "G/L Entry";
        Text000: Label 'Reading Customer No    #1##########';
        ExcelBuf: Record "Excel Buffer" temporary;
        Month: Text;
        Year: Text;
        DocNo: Code[20];
        TTBASE: Decimal;
        TTAMT: Decimal;
        VatEntry2: record "Vat Entry";
        Recordcount: Integer;
        VatEntryRecordCount: Integer;
        Customer: Record Customer;
        Newvalur: Integer;
        grecCustLedgerEntry: Record "Cust. Ledger Entry";
        gtextDescription: Text;

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

        //DateText := VarYearText + VarMonthTxt + VarDayText;
        DateText := VarYearText + VarMonthTxt;
    end;

    local procedure MakeExcelDataHeader()
    begin

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('MNS', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('VT03', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('V1.0', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);


        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('VAT Payer Tan', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('VAT Payer Business Registration Number (BRN)', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('VAT Payer Full Name', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('VAT Period', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Telephone Number', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Mobile Number', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Name of Declarant', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Email Address', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);


        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Company Information"."VAT Payer Tax", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Company Information".BRN, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Company Information"."VAT Payer Full Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('Year Ending 30 June',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(BuildDate(EndingDate), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Company Information"."Phone No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Company Information"."Mobile Number", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Company Information"."Name Of Declarant", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Company Information"."MRA VAT Email Address", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('VAT Registration No. of person to whom supplier is made', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Name of person to whom supplies is made', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Value of Supplies or Credit Note (MUR)', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('VAT Amount', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Date of Invoice OR Credit Note (MUR)', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice OR Credit Note Number', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('BRN of person to whom supplies is made', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('VAT Business Posting Group', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('VAT Product Posting Group', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Description', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
    end;

    local procedure CreateExcelBook()
    begin
        ExcelBuf.CreateBookAndOpenExcel('', 'VAT ANNEX', '', COMPANYNAME, USERID);
    end;

    local procedure EntryCount(DocNo: Code[20]): Integer
    begin
        VatEntry2.SETRANGE("Document No.", DocNo);
        VatEntry2.SetRange(Type, VatEntry2.Type::Sale);
        VatEntry2.SetFilter("VAT Prod. Posting Group", '<>%1', 'TDS');
        IF VatEntry2.FINDSET THEN
            EXIT(VatEntry2.COUNT);
    end;
}

