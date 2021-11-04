report 50034 "Imp Registration Fee OU Portal"
{
    ProcessingOnly = true;
    //UsageCategory = Administration;
    //ApplicationArea = All;
    Caption = 'Import Re-Registration Fee OU Portal';

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
        grecReRegistrationFromOUPortal.DeleteAll();
        ExcelBuf.LOCKTABLE;
        ExcelBuf.OpenBook(ServerFileName, SheetName);
        ExcelBuf.ReadSheet;
        GetLastRowandColumn;

        FOR X := 2 TO TotalRows DO
            InsertData(X);

        ExcelBuf.DELETEALL;

        MESSAGE('%1 lines have been uploaded in the system for Re-Registration Fees.', gintCounter);
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
        grecReRegistrationFromOUPortal2.Reset();
        if grecReRegistrationFromOUPortal2.FindLast then
            EntryNo := grecReRegistrationFromOUPortal2."Line No." + 1
        else
            EntryNo := 1;

        grecReRegistrationFromOUPortal.INIT;
        EVALUATE(grecReRegistrationFromOUPortal."Line No.", format(EntryNo));
        EVALUATE(grecReRegistrationFromOUPortal."Date Processed", GetValueAtCell(RowNo, 28));
        Evaluate(grecReRegistrationFromOUPortal."Student ID", GetValueAtCell(RowNo, 4));

        //Module
        Evaluate(grecReRegistrationFromOUPortal."Module Description", GetValueAtCell(RowNo, 13));
        Evaluate(grecReRegistrationFromOUPortal."No.", GetValueAtCell(RowNo, 14));
        Evaluate(grecReRegistrationFromOUPortal."Common Module Code", GetValueAtCell(RowNo, 15));
        if GetValueAtCell(RowNo, 16) = '' then
            Evaluate(grecReRegistrationFromOUPortal."Module Credit", '0')
        else
            Evaluate(grecReRegistrationFromOUPortal."Module Credit", GetValueAtCell(RowNo, 16));

        if GetValueAtCell(RowNo, 17) = '' then
            Evaluate(grecReRegistrationFromOUPortal."Module Amount", '0')
        else
            Evaluate(grecReRegistrationFromOUPortal."Module Amount", GetValueAtCell(RowNo, 17));

        if GetValueAtCell(RowNo, 18) = '' then
            Evaluate(grecReRegistrationFromOUPortal."Module Fee Ins", '0')
        else
            Evaluate(grecReRegistrationFromOUPortal."Module Fee Ins", GetValueAtCell(RowNo, 18));

        //Shortcut Dimension
        EVALUATE(grecReRegistrationFromOUPortal."Shortcut Dimension 1 Code", GetValueAtCell(RowNo, 12));

        if GetValueAtCell(RowNo, 8) <> '' then begin
            grecGenLedgSetup.get;
            Evaluate(gdateDim2, GetValueAtCell(RowNo, 8));

            grecDimValue.Reset();
            grecDimValue.SetRange("Dimension Code", grecGenLedgSetup."Global Dimension 2 Code");
            grecDimValue.SetFilter("Starting Date", '>=%1', gdateDim2);
            if grecDimValue.Findfirst then begin
                repeat
                    if gdateDim2 <= grecDimValue."Ending Date" then
                        grecReRegistrationFromOUPortal."Shortcut Dimension 2 Code" := grecDimValue.Code;
                until (grecDimValue.Next = 0) or (grecReRegistrationFromOUPortal."Shortcut Dimension 2 Code" <> '');
            end;
        End;

        //Student Personal Info
        if GetValueAtCell(RowNo, 1) <> '' then begin
            Evaluate(grecReRegistrationFromOUPortal.PTN, GetValueAtCell(RowNo, 1));
            gtextPTN := GetValueAtCell(RowNo, 1);
        end else
            grecReRegistrationFromOUPortal.PTN := gtextPTN;

        Evaluate(grecReRegistrationFromOUPortal.Status, GetValueAtCell(RowNo, 2));
        Evaluate(grecReRegistrationFromOUPortal.RDAP, GetValueAtCell(RowNo, 3));
        Evaluate(grecReRegistrationFromOUPortal."First Name", GetValueAtCell(RowNo, 5));
        Evaluate(grecReRegistrationFromOUPortal."Last Name", GetValueAtCell(RowNo, 6));
        Evaluate(grecReRegistrationFromOUPortal."Maiden Name", GetValueAtCell(RowNo, 7));
        Evaluate(grecReRegistrationFromOUPortal."Payment Semester", GetValueAtCell(RowNo, 10));

        //Evaluate(grecReRegistrationFromOUPortal.Currency, GetValueAtCell(RowNo, 17));

        if (GetValueAtCell(RowNo, 20) <> '') AND (GetValueAtCell(RowNo, 20) <> 'Rs') then
            grecReRegistrationFromOUPortal.Currency := 'USD';

        if GetValueAtCell(RowNo, 22) = '' then
            Evaluate(grecReRegistrationFromOUPortal.Total, '0')
        else
            Evaluate(grecReRegistrationFromOUPortal.Total, GetValueAtCell(RowNo, 22));

        if GetValueAtCell(RowNo, 23) = '' then
            Evaluate(grecReRegistrationFromOUPortal."Penalty Fee", '0')
        else
            Evaluate(grecReRegistrationFromOUPortal."Penalty Fee", GetValueAtCell(RowNo, 23));

        if GetValueAtCell(RowNo, 24) = '' then
            Evaluate(grecReRegistrationFromOUPortal."Net Total", '0')
        else
            Evaluate(grecReRegistrationFromOUPortal."Net Total", GetValueAtCell(RowNo, 24));

        Evaluate(grecReRegistrationFromOUPortal."Payment For", GetValueAtCell(RowNo, 25));
        Evaluate(grecReRegistrationFromOUPortal."Payment Type", GetValueAtCell(RowNo, 26));
        Evaluate(grecReRegistrationFromOUPortal."Date Paid On", GetValueAtCell(RowNo, 27));

        Evaluate(grecReRegistrationFromOUPortal."MyT Money Ref", GetValueAtCell(RowNo, 29));
        Evaluate(grecReRegistrationFromOUPortal."MyT Money Ref Staff", GetValueAtCell(RowNo, 30));
        Evaluate(grecReRegistrationFromOUPortal.Remarks, GetValueAtCell(RowNo, 31));

        grecReRegistrationFromOUPortal."Imported By" := UserId;
        grecReRegistrationFromOUPortal."Imported On" := CurrentDateTime;
        grecReRegistrationFromOUPortal.INSERT(TRUE);
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
        grecReRegistrationFromOUPortal: Record "ReRegistration Fee OU Portal";
        grecReRegistrationFromOUPortal2: Record "ReRegistration Fee OU Portal";
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

