report 50031 "Import App Fee from OU Portal"
{
    ProcessingOnly = true;
    //UsageCategory = Administration;
    //ApplicationArea = All;
    Caption = 'Import Application Fee from OU Portal';

    RequestPage
    {
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            IF CloseAction = ACTION::OK THEN BEGIN
                //ServerFileName := gtextFilename;
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
        if ExcelBuf1.GET(RowNo, ColNo) then;
        EXIT(ExcelBuf1."Cell Value as Text");
    END;


    PROCEDURE InsertData(RowNo: Integer);
    BEGIN

        clear(ApplFeeGRec);

        if ApplFeeGRec2.FindLast then
            ApplFeeGRec."Line No." := ApplFeeGRec2."Line No." + 1
        else
            ApplFeeGRec."Line No." := 1;

        ApplFeeGRec.Init();


        EVALUATE(ApplFeeGRec."Posting Date", GetValueAtCell(RowNo, 23));

        ApplFeeGRec."Payment Method Code" := GetValueAtCell(RowNo, 21);
        EVALUATE(ApplFeeGRec.Amount, GetValueAtCell(RowNo, 20));


        ApplFeeGRec."Student ID" := GetValueAtCell(RowNo, 2);
        ApplFeeGRec.RDAP := GetValueAtCell(RowNo, 4);
        ApplFeeGRec.RDBL := GetValueAtCell(RowNo, 5);
        ApplFeeGRec.NIC := GetValueAtCell(RowNo, 6);
        ApplFeeGRec."Student Name" := GetValueAtCell(RowNo, 7) + ' ' + GetValueAtCell(RowNo, 9) + ' ' + GetValueAtCell(RowNo, 8);

        if GetValueAtCell(RowNo, 10) <> '' then begin
            Evaluate(gdateDim2, GetValueAtCell(RowNo, 10));
            ApplFeeGRec.Dim2Date := gdateDim2;
        end;

        //ApplFeeGRec."Shortcut Dimension 2 Code" := GetValueAtCell(RowNo, 8);
        ApplFeeGRec."Login Email" := GetValueAtCell(RowNo, 12);
        ApplFeeGRec."Contact Email" := GetValueAtCell(RowNo, 13);
        ApplFeeGRec.Phone := GetValueAtCell(RowNo, 14);
        ApplFeeGRec.Mobile := GetValueAtCell(RowNo, 15);
        ApplFeeGRec.Address := GetValueAtCell(RowNo, 16);
        ApplFeeGRec.Country := GetValueAtCell(RowNo, 17);
        ApplFeeGRec."Currency Code" := GetValueAtCell(RowNo, 19);
        ApplFeeGRec.Insert();
        gintCounter += 1;
    END;


    var
        ExcelBuf: Record "Excel Buffer";
        ServerFileName: Text[250];
        SheetName: Text[250];
        gdateDim2: Date;
        TotalRows: Integer;
        TotalColumns: Integer;
        FileMgt: Codeunit 419;
        Text006: Label 'Import Excel File';
        ExcelExtensionTok: Label '.xlsx';
        X: Integer;
        ApplFeeGRec: Record "Appl. Fee From OU Portal";
        ApplFeeGRec2: Record "Appl. Fee From OU Portal";
        gintCounter: Integer;

}

