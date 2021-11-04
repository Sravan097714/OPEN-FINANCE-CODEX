report 50084 "Import Budget"
{
    ProcessingOnly = true;
    //UsageCategory = Administration;
    //ApplicationArea = All;

    RequestPage
    {
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            gtextFilename: Text[50];
        begin
            gtextFilename := 'C:\Users\';
            gtextFilename += 'app_fee' + FORMAT(20210222D, 0, '<Year4><Month,2><Day,2>') + '.xlsx';

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
        MESSAGE('%1 lines have been uploaded in the system.', gintCounter);
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
        clear(grecGLBudgetAccCategory);

        grecGLBudgetAccCategory.Init();
        grecGLBudgetAccCategory."Budget Name" := GetValueAtCell(RowNo, 1);
        grecGLBudgetAccCategory."Budget Category" := GetValueAtCell(RowNo, 2);
        grecGLBudgetAccCategory.Description := GetValueAtCell(RowNo, 3);
        evaluate(grecGLBudgetAccCategory."Date From", GetValueAtCell(RowNo, 4));
        evaluate(grecGLBudgetAccCategory."Date To", GetValueAtCell(RowNo, 5));

        case GetValueAtCell(RowNo, 6) of

            'Original Budgeted Amount for the Year':
                begin
                    if GetValueAtCell(RowNo, 7) = '' then
                        Evaluate(grecGLBudgetAccCategory."Original Budgeted Amt for Year", '0')
                    else
                        Evaluate(grecGLBudgetAccCategory."Original Budgeted Amt for Year", GetValueAtCell(RowNo, 7));
                end;

            'Revised Amount for the Year (1)':
                begin
                    if GetValueAtCell(RowNo, 7) = '' then
                        Evaluate(grecGLBudgetAccCategory."Revised Amount for Year (1)", '0')
                    else
                        Evaluate(grecGLBudgetAccCategory."Revised Amount for Year (1)", GetValueAtCell(RowNo, 7));
                end;

            'Revised Amount for the Year (2)':
                begin
                    if GetValueAtCell(RowNo, 7) = '' then
                        Evaluate(grecGLBudgetAccCategory."Revised Amount for Year (2)", '0')
                    else
                        Evaluate(grecGLBudgetAccCategory."Revised Amount for Year (2)", GetValueAtCell(RowNo, 7));
                end;

            'Revised Amount for the Year (3)':
                begin
                    if GetValueAtCell(RowNo, 7) = '' then
                        Evaluate(grecGLBudgetAccCategory."Revised Amount for Year (3)", '0')
                    else
                        Evaluate(grecGLBudgetAccCategory."Revised Amount for Year (3)", GetValueAtCell(RowNo, 7));
                end;

            'Revised Amount for the Year (4)':
                begin
                    if GetValueAtCell(RowNo, 7) = '' then
                        Evaluate(grecGLBudgetAccCategory."Revised Amount for Year (4)", '0')
                    else
                        Evaluate(grecGLBudgetAccCategory."Revised Amount for Year (4)", GetValueAtCell(RowNo, 7));
                end;

            'Revised Amount for the Year (5)':
                begin
                    if GetValueAtCell(RowNo, 7) = '' then
                        Evaluate(grecGLBudgetAccCategory."Revised Amount for Year (5)", '0')
                    else
                        Evaluate(grecGLBudgetAccCategory."Revised Amount for Year (5)", GetValueAtCell(RowNo, 7));
                end;

            'Revised Amount for the Year (6)':
                begin
                    if GetValueAtCell(RowNo, 7) = '' then
                        Evaluate(grecGLBudgetAccCategory."Revised Amount for Year (6)", '0')
                    else
                        Evaluate(grecGLBudgetAccCategory."Revised Amount for Year (6)", GetValueAtCell(RowNo, 7));
                end;

            'Final Budgeted Amount for the Year':
                begin
                    if GetValueAtCell(RowNo, 7) = '' then
                        Evaluate(grecGLBudgetAccCategory."Final Budgeted Amount for Year", '0')
                    else
                        Evaluate(grecGLBudgetAccCategory."Final Budgeted Amount for Year", GetValueAtCell(RowNo, 7));
                end;
        end;
        gintCounter += 1;
        grecGLBudgetAccCategory.Insert;
    END;


    var
        ExcelBuf: Record "Excel Buffer";
        ServerFileName: Text[250];
        SheetName: Text[250];
        TotalRows: Integer;
        TotalColumns: Integer;
        FileMgt: Codeunit 419;
        Text006: Label 'Import Excel File';
        ExcelExtensionTok: Label '.xlsx';
        X: Integer;
        EntryNo: Integer;
        gintCounter: Integer;

        grecGLBudgetAccCategory: Record "G/L Budget by Account Category";

}

