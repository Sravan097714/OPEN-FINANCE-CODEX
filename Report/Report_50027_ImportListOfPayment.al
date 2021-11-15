report 50027 "Import List of Payment"
{
    ProcessingOnly = true;

    RequestPage
    {
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            IF CloseAction = ACTION::OK THEN BEGIN
                ServerFileName := FileMgt.UploadFile(Text006, ExcelExtensionTok);
                IF ServerFileName = '' THEN
                    EXIT(FALSE);

                SheetName := ExcelBuf.SelectSheetsName(ServerFileName);
                IF SheetName = '' THEN
                    EXIT(FALSE);
            END;
        end;
    }


    trigger OnPreReport()
    begin
        Clear(gintCounter);
        ExcelBuf.LOCKTABLE;
        ExcelBuf.OpenBook(ServerFileName, SheetName);
        ExcelBuf.ReadSheet;
        GetLastRowandColumn;

        FOR X := 2 TO TotalRows DO
            InsertData(X);

        ExcelBuf.DELETEALL;
        MESSAGE('%1 lines have been uploaded.', gintCounter);
    end;


    PROCEDURE GetLastRowandColumn();
    BEGIN
        ExcelBuf.SETRANGE("Row No.", 1);
        TotalColumns := ExcelBuf.COUNT;

        ExcelBuf.RESET;
        IF ExcelBuf.FINDLAST THEN
            TotalRows := ExcelBuf."Row No.";
    END;


    PROCEDURE GetValueAtCell(RowNo: Integer; ColNo: Integer): Text;
    VAR
        ExcelBuf1: Record 370;
    BEGIN
        ExcelBuf1.GET(RowNo, ColNo);
        EXIT(ExcelBuf1."Cell Value as Text");
    END;


    PROCEDURE InsertData(RowNo: Integer);
    BEGIN
        grecListofUploadedPayments2.Reset();
        if grecListofUploadedPayments2.FindLast then
            EntryNo := grecListofUploadedPayments2."Entry No." + 1
        else
            EntryNo := 1;

        grecListofUploadedPayments.INIT;
        EVALUATE(grecListofUploadedPayments."Entry No.", format(EntryNo));
        EVALUATE(grecListofUploadedPayments."Posting Date", GetValueAtCell(RowNo, 1));
        EVALUATE(grecListofUploadedPayments."Student Code", GetValueAtCell(RowNo, 2));
        EVALUATE(grecListofUploadedPayments.Amount, GetValueAtCell(RowNo, 3));
        EVALUATE(grecListofUploadedPayments."Posted Invoice No.", GetValueAtCell(RowNo, 4));
        grecListofUploadedPayments."Imported by" := UserId;
        grecListofUploadedPayments."Imported On" := Today;
        grecListofUploadedPayments.INSERT(TRUE);
        gintCounter += 1;
    END;


    var
        gintCounter: Integer;
        ExcelBuf: Record "Excel Buffer";
        ServerFileName: Text[250];
        SheetName: Text[250];
        TotalRows: Integer;
        TotalColumns: Integer;
        FileMgt: Codeunit "File Management";
        Text006: Label 'Import Excel File';
        ExcelExtensionTok: Label '.xlsx';
        X: Integer;
        grecListofUploadedPayments: Record "List of Uploaded Payments";
        grecListofUploadedPayments2: Record "List of Uploaded Payments";
        EntryNo: Integer;
}

