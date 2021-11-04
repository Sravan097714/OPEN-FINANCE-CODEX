report 50092 "Import Application Submission"
{
    ProcessingOnly = true;
    //UsageCategory = Administration;
    //ApplicationArea = All;

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
        gintCounter := 0;
        grecOUPortalAppSubmission.DeleteAll();
        ExcelBuf.LOCKTABLE;
        ExcelBuf.OpenBook(ServerFileName, SheetName);
        ExcelBuf.ReadSheet;
        GetLastRowandColumn;

        FOR X := 2 TO TotalRows DO
            InsertData(X);

        ExcelBuf.DELETEALL;

        MESSAGE('%1 lines have been uploaded in the system for Application Submission.', gintCounter);
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
        if ExcelBuf1.GET(RowNo, ColNo) then
            EXIT(ExcelBuf1."Cell Value as Text")
        else
            exit('');
    END;


    PROCEDURE InsertData(RowNo: Integer);
    BEGIN
        grecOUPortalAppSubmission2.Reset();
        if grecOUPortalAppSubmission2.FindLast then
            EntryNo := grecOUPortalAppSubmission2."Entry No." + 1
        else
            EntryNo := 1;

        grecOUPortalAppSubmission.INIT;
        Evaluate(grecOUPortalAppSubmission.User_ID, GetValueAtCell(RowNo, 2));
        Evaluate(grecOUPortalAppSubmission.Submission, GetValueAtCell(RowNo, 3));
        Evaluate(grecOUPortalAppSubmission.RDAP, GetValueAtCell(RowNo, 4));
        Evaluate(grecOUPortalAppSubmission.RDBL, GetValueAtCell(RowNo, 5));
        Evaluate(grecOUPortalAppSubmission.NIC, GetValueAtCell(RowNo, 6));
        Evaluate(grecOUPortalAppSubmission."First Name", GetValueAtCell(RowNo, 7));
        Evaluate(grecOUPortalAppSubmission."Last Name", GetValueAtCell(RowNo, 8));
        Evaluate(grecOUPortalAppSubmission."Maiden Name", GetValueAtCell(RowNo, 9));

        //Shortcut Dimension
        //EVALUATE(grecOUPortalAppSubmission."Shortcut Dimension 1 Code", GetValueAtCell(RowNo, 12));

        if GetValueAtCell(RowNo, 10) <> '' then begin
            grecGenLedgSetup.get;
            Evaluate(gdateDim2, GetValueAtCell(RowNo, 10));

            grecDimValue.Reset();
            grecDimValue.SetRange("Dimension Code", grecGenLedgSetup."Global Dimension 2 Code");
            grecDimValue.SetFilter("Starting Date", '>=%1', gdateDim2);
            if grecDimValue.Findfirst then begin
                repeat
                    if gdateDim2 <= grecDimValue."Ending Date" then
                        grecOUPortalAppSubmission.Intake := grecDimValue.Code;
                until (grecDimValue.Next = 0) or (grecOUPortalAppSubmission.Intake <> '');
            end;
        End;

        Evaluate(grecOUPortalAppSubmission."Login Email", GetValueAtCell(RowNo, 12));
        Evaluate(grecOUPortalAppSubmission."Contact Email", GetValueAtCell(RowNo, 13));
        Evaluate(grecOUPortalAppSubmission.Phone, GetValueAtCell(RowNo, 14));
        Evaluate(grecOUPortalAppSubmission.Mobile, GetValueAtCell(RowNo, 15));
        Evaluate(grecOUPortalAppSubmission.Address, GetValueAtCell(RowNo, 16));
        Evaluate(grecOUPortalAppSubmission.Country, GetValueAtCell(RowNo, 17));
        Evaluate(grecOUPortalAppSubmission."Programme 1", GetValueAtCell(RowNo, 18));
        Evaluate(grecOUPortalAppSubmission."Programme 2", GetValueAtCell(RowNo, 19));
        Evaluate(grecOUPortalAppSubmission."Programme 3", GetValueAtCell(RowNo, 20));
        Evaluate(grecOUPortalAppSubmission."Programme 4", GetValueAtCell(RowNo, 21));
        Evaluate(grecOUPortalAppSubmission.Status, GetValueAtCell(RowNo, 22));

        grecOUPortalAppSubmission."Imported By" := UserId;
        grecOUPortalAppSubmission."Imported On" := CurrentDateTime;
        grecOUPortalAppSubmission.INSERT(TRUE);
        gintCounter += 1;
    END;


    var
        ExcelBuf: Record "Excel Buffer";
        ServerFileName: Text[250];
        SheetName: Text[250];
        gdateDim2: Date;
        TotalRows: Integer;
        TotalColumns: Integer;
        FileMgt: Codeunit "File Management";
        Text006: Label 'Import Excel File';
        ExcelExtensionTok: Label '.xlsx';
        X: Integer;
        grecOUPortalAppSubmission: Record "OU Portal App Submission";
        grecOUPortalAppSubmission2: Record "OU Portal App Submission";
        EntryNo: Integer;
        grecSalesHeader: Record "Sales Header";
        grecSalesLine: Record "Sales Line";
        grecSalesLine2: Record "Sales Line";
        gtextSalesOrderNo: Text[50];
        gcodeCustomerno: code[20];
        gdatePostingDate: Date;
        grecCustomer: Record Customer;
        grecItem: Record Item;
        grecSalesReceivableSetup: Record "Sales & Receivables Setup";
        grecGenLedgSetup: Record "General Ledger Setup";
        grecDimValue: Record "Dimension Value";
        glblDimError: Label '%1 does not exist.';
        glblModuleError: Label 'Module code %1 does not exist.';
        gtextPTN: text;
        gintCounter: Integer;

}

