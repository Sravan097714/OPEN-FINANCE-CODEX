report 50090 "Import Resit Fee OU Portal"
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
        grecResitFromOUPortal.Reset();
        grecResitFromOUPortal.SetRange(Resit, true);
        if grecResitFromOUPortal.FindFirst() then
            grecResitFromOUPortal.DeleteAll();
        ExcelBuf.LOCKTABLE;
        ExcelBuf.OpenBook(ServerFileName, SheetName);
        ExcelBuf.ReadSheet;
        GetLastRowandColumn;

        FOR X := 2 TO TotalRows DO
            InsertData(X);

        ExcelBuf.DELETEALL;

        MESSAGE('%1 lines have been uploaded in the system for Exemption Fees.', gintCounter);
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
        grecResitFromOUPortal2.Reset();
        if grecResitFromOUPortal2.FindLast then
            EntryNo := grecResitFromOUPortal2."Line No." + 1
        else
            EntryNo := 1;

        grecResitFromOUPortal.INIT;
        EVALUATE(grecResitFromOUPortal."Line No.", format(EntryNo));
        EVALUATE(grecResitFromOUPortal."Date Processed", GetValueAtCell(RowNo, 17));
        Evaluate(grecResitFromOUPortal."User ID", GetValueAtCell(RowNo, 2));
        Evaluate(grecResitFromOUPortal."Student ID", GetValueAtCell(RowNo, 4));

        //Module
        Evaluate(grecResitFromOUPortal."Module Description", GetValueAtCell(RowNo, 13));
        Evaluate(grecResitFromOUPortal."No.", GetValueAtCell(RowNo, 14));
        Evaluate(grecResitFromOUPortal."Common Module Code", GetValueAtCell(RowNo, 15));
        if GetValueAtCell(RowNo, 16) = '' then
            Evaluate(grecResitFromOUPortal."Module Credit", '0')
        else
            Evaluate(grecResitFromOUPortal."Module Credit", GetValueAtCell(RowNo, 16));


        //Shortcut Dimension
        EVALUATE(grecResitFromOUPortal."Shortcut Dimension 1 Code", GetValueAtCell(RowNo, 12));

        if GetValueAtCell(RowNo, 8) <> '' then begin
            grecGenLedgSetup.get;
            Evaluate(gdateDim2, GetValueAtCell(RowNo, 8));

            grecDimValue.Reset();
            grecDimValue.SetRange("Dimension Code", grecGenLedgSetup."Global Dimension 2 Code");
            grecDimValue.SetFilter("Starting Date", '>=%1', gdateDim2);
            if grecDimValue.Findfirst then begin
                repeat
                    if gdateDim2 <= grecDimValue."Ending Date" then
                        grecResitFromOUPortal."Shortcut Dimension 2 Code" := grecDimValue.Code;
                until (grecDimValue.Next = 0) or (grecResitFromOUPortal."Shortcut Dimension 2 Code" <> '');
            end;
        End;

        //Student Personal Info
        Evaluate(grecResitFromOUPortal.RDAP, GetValueAtCell(RowNo, 3));
        Evaluate(grecResitFromOUPortal."First Name", GetValueAtCell(RowNo, 5));
        Evaluate(grecResitFromOUPortal."Last Name", GetValueAtCell(RowNo, 6));
        Evaluate(grecResitFromOUPortal."Maiden Name", GetValueAtCell(RowNo, 7));
        Evaluate(grecResitFromOUPortal."Payment Semester", GetValueAtCell(RowNo, 10));
        Evaluate(grecResitFromOUPortal.Remarks, GetValueAtCell(RowNo, 18));

        grecResitFromOUPortal."Imported By" := UserId;
        grecResitFromOUPortal."Imported On" := CurrentDateTime;
        grecResitFromOUPortal.Resit := true;
        grecResitFromOUPortal.INSERT(TRUE);
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
        grecResitFromOUPortal: Record "Exemption/Resit Fee OU Portal";
        grecResitFromOUPortal2: Record "Exemption/Resit Fee OU Portal";
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

