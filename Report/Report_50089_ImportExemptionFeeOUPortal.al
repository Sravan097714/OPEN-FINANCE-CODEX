report 50089 "Import Exemption Fee OU Portal"
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
        grecExemptionFromOUPortal.Reset();
        grecExemptionFromOUPortal.SetRange(Exemption, true);
        if grecExemptionFromOUPortal.FindFirst() then
            grecExemptionFromOUPortal.DeleteAll();
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
        grecExemptionFromOUPortal2.Reset();
        if grecExemptionFromOUPortal2.FindLast then
            EntryNo := grecExemptionFromOUPortal2."Line No." + 1
        else
            EntryNo := 1;

        grecExemptionFromOUPortal.INIT;
        EVALUATE(grecExemptionFromOUPortal."Line No.", format(EntryNo));
        EVALUATE(grecExemptionFromOUPortal."Date Processed", GetValueAtCell(RowNo, 17));
        Evaluate(grecExemptionFromOUPortal."User ID", GetValueAtCell(RowNo, 2));
        Evaluate(grecExemptionFromOUPortal."Student ID", GetValueAtCell(RowNo, 4));

        //Module
        Evaluate(grecExemptionFromOUPortal."Module Description", GetValueAtCell(RowNo, 13));
        Evaluate(grecExemptionFromOUPortal."No.", GetValueAtCell(RowNo, 14));
        Evaluate(grecExemptionFromOUPortal."Common Module Code", GetValueAtCell(RowNo, 15));
        if GetValueAtCell(RowNo, 16) = '' then
            Evaluate(grecExemptionFromOUPortal."Module Credit", '0')
        else
            Evaluate(grecExemptionFromOUPortal."Module Credit", GetValueAtCell(RowNo, 16));


        //Shortcut Dimension
        EVALUATE(grecExemptionFromOUPortal."Shortcut Dimension 1 Code", GetValueAtCell(RowNo, 12));

        if GetValueAtCell(RowNo, 8) <> '' then begin
            grecGenLedgSetup.get;
            Evaluate(gdateDim2, GetValueAtCell(RowNo, 8));

            grecDimValue.Reset();
            grecDimValue.SetRange("Dimension Code", grecGenLedgSetup."Global Dimension 2 Code");
            grecDimValue.SetFilter("Starting Date", '>=%1', gdateDim2);
            if grecDimValue.Findfirst then begin
                repeat
                    if gdateDim2 <= grecDimValue."Ending Date" then
                        grecExemptionFromOUPortal."Shortcut Dimension 2 Code" := grecDimValue.Code;
                until (grecDimValue.Next = 0) or (grecExemptionFromOUPortal."Shortcut Dimension 2 Code" <> '');
            end;
        End;

        //Student Personal Info
        Evaluate(grecExemptionFromOUPortal.RDAP, GetValueAtCell(RowNo, 3));
        Evaluate(grecExemptionFromOUPortal."First Name", GetValueAtCell(RowNo, 5));
        Evaluate(grecExemptionFromOUPortal."Last Name", GetValueAtCell(RowNo, 6));
        Evaluate(grecExemptionFromOUPortal."Maiden Name", GetValueAtCell(RowNo, 7));
        Evaluate(grecExemptionFromOUPortal."Payment Semester", GetValueAtCell(RowNo, 10));

        Evaluate(grecExemptionFromOUPortal."Payment Mode", GetValueAtCell(RowNo, 18));
        Evaluate(grecExemptionFromOUPortal.Remarks, GetValueAtCell(RowNo, 19));

        grecExemptionFromOUPortal."Imported By" := UserId;
        grecExemptionFromOUPortal."Imported On" := CurrentDateTime;
        grecExemptionFromOUPortal.Exemption := true;
        grecExemptionFromOUPortal.INSERT(TRUE);
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
        grecExemptionFromOUPortal: Record "Exemption/Resit Fee OU Portal";
        grecExemptionFromOUPortal2: Record "Exemption/Resit Fee OU Portal";
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

