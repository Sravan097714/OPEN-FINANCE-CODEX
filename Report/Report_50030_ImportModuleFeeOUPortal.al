report 50030 "Import Module Fee OU Portal"
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
        grecModuleFromOUPortal.DeleteAll();
        ExcelBuf.LOCKTABLE;
        ExcelBuf.OpenBook(ServerFileName, SheetName);
        ExcelBuf.ReadSheet;
        GetLastRowandColumn;

        FOR X := 2 TO TotalRows DO
            InsertData(X);

        ExcelBuf.DELETEALL;

        MESSAGE('%1 lines have been uploaded in the system for Module Fees.', gintCounter);
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
        grecModuleFromOUPortal2.Reset();
        if grecModuleFromOUPortal2.FindLast then
            EntryNo := grecModuleFromOUPortal2."Line No." + 1
        else
            EntryNo := 1;

        grecModuleFromOUPortal.INIT;
        EVALUATE(grecModuleFromOUPortal."Line No.", format(EntryNo));
        EVALUATE(grecModuleFromOUPortal."Posting Date", GetValueAtCell(RowNo, 62));
        Evaluate(grecModuleFromOUPortal."Learner ID", GetValueAtCell(RowNo, 5));

        //Module 1
        Evaluate(grecModuleFromOUPortal."Module Description 1", GetValueAtCell(RowNo, 15));
        Evaluate(grecModuleFromOUPortal."No. 1", GetValueAtCell(RowNo, 16));
        Evaluate(grecModuleFromOUPortal."Common Module Code 1", GetValueAtCell(RowNo, 17));
        if GetValueAtCell(RowNo, 18) = '' then
            Evaluate(grecModuleFromOUPortal."Module Amount 1", '0')
        else
            Evaluate(grecModuleFromOUPortal."Module Amount 1", GetValueAtCell(RowNo, 18));

        if GetValueAtCell(RowNo, 19) = '' then
            Evaluate(grecModuleFromOUPortal."Module 1 Fee Ins", '0')
        else
            Evaluate(grecModuleFromOUPortal."Module 1 Fee Ins", GetValueAtCell(RowNo, 19));

        if GetValueAtCell(RowNo, 20) = '' then
            Evaluate(grecModuleFromOUPortal."Module Credit 1", '0')
        else
            Evaluate(grecModuleFromOUPortal."Module Credit 1", GetValueAtCell(RowNo, 20));


        //Module 2
        Evaluate(grecModuleFromOUPortal."Module Description 2", GetValueAtCell(RowNo, 21));
        Evaluate(grecModuleFromOUPortal."No. 2", GetValueAtCell(RowNo, 22));
        Evaluate(grecModuleFromOUPortal."Common Module Code 2", GetValueAtCell(RowNo, 23));
        if GetValueAtCell(RowNo, 24) = '' then
            Evaluate(grecModuleFromOUPortal."Module Amount 2", '0')
        else
            Evaluate(grecModuleFromOUPortal."Module Amount 2", GetValueAtCell(RowNo, 24));

        if GetValueAtCell(RowNo, 25) = '' then
            Evaluate(grecModuleFromOUPortal."Module 2 Fee Ins", '0')
        else
            Evaluate(grecModuleFromOUPortal."Module 2 Fee Ins", GetValueAtCell(RowNo, 25));

        if GetValueAtCell(RowNo, 26) = '' then
            Evaluate(grecModuleFromOUPortal."Module Credit 2", '0')
        else
            Evaluate(grecModuleFromOUPortal."Module Credit 2", GetValueAtCell(RowNo, 26));


        //Module 3
        Evaluate(grecModuleFromOUPortal."Module Description 3", GetValueAtCell(RowNo, 27));
        Evaluate(grecModuleFromOUPortal."No. 3", GetValueAtCell(RowNo, 28));
        Evaluate(grecModuleFromOUPortal."Common Module Code 3", GetValueAtCell(RowNo, 28));
        if GetValueAtCell(RowNo, 30) = '' then
            Evaluate(grecModuleFromOUPortal."Module Amount 3", '0')
        else
            Evaluate(grecModuleFromOUPortal."Module Amount 3", GetValueAtCell(RowNo, 30));

        if GetValueAtCell(RowNo, 31) = '' then
            Evaluate(grecModuleFromOUPortal."Module 3 Fee Ins", '0')
        else
            Evaluate(grecModuleFromOUPortal."Module 3 Fee Ins", GetValueAtCell(RowNo, 31));

        if GetValueAtCell(RowNo, 32) = '' then
            Evaluate(grecModuleFromOUPortal."Module Credit 3", '0')
        else
            Evaluate(grecModuleFromOUPortal."Module Credit 3", GetValueAtCell(RowNo, 32));


        //Module 4
        Evaluate(grecModuleFromOUPortal."Module Description 4", GetValueAtCell(RowNo, 33));
        Evaluate(grecModuleFromOUPortal."No. 4", GetValueAtCell(RowNo, 34));
        Evaluate(grecModuleFromOUPortal."Common Module Code 4", GetValueAtCell(RowNo, 35));
        if GetValueAtCell(RowNo, 36) = '' then
            Evaluate(grecModuleFromOUPortal."Module Amount 4", '0')
        else
            Evaluate(grecModuleFromOUPortal."Module Amount 4", GetValueAtCell(RowNo, 36));

        if GetValueAtCell(RowNo, 37) = '' then
            Evaluate(grecModuleFromOUPortal."Module 4 Fee Ins", '0')
        else
            Evaluate(grecModuleFromOUPortal."Module 4 Fee Ins", GetValueAtCell(RowNo, 37));

        if GetValueAtCell(RowNo, 38) = '' then
            Evaluate(grecModuleFromOUPortal."Module Credit 4", '0')
        else
            Evaluate(grecModuleFromOUPortal."Module Credit 4", GetValueAtCell(RowNo, 38));


        //Module 5
        Evaluate(grecModuleFromOUPortal."Module Description 5", GetValueAtCell(RowNo, 39));
        Evaluate(grecModuleFromOUPortal."No. 5", GetValueAtCell(RowNo, 40));
        Evaluate(grecModuleFromOUPortal."Common Module Code 5", GetValueAtCell(RowNo, 41));
        if GetValueAtCell(RowNo, 42) = '' then
            Evaluate(grecModuleFromOUPortal."Module Amount 5", '0')
        else
            Evaluate(grecModuleFromOUPortal."Module Amount 5", GetValueAtCell(RowNo, 42));

        if GetValueAtCell(RowNo, 43) = '' then
            Evaluate(grecModuleFromOUPortal."Module 5 Fee Ins", '0')
        else
            Evaluate(grecModuleFromOUPortal."Module 5 Fee Ins", GetValueAtCell(RowNo, 43));
        if GetValueAtCell(RowNo, 44) = '' then
            Evaluate(grecModuleFromOUPortal."Module Credit 5", '0')
        else
            Evaluate(grecModuleFromOUPortal."Module Credit 5", GetValueAtCell(RowNo, 44));


        //Module 6
        Evaluate(grecModuleFromOUPortal."Module Description 6", GetValueAtCell(RowNo, 45));
        Evaluate(grecModuleFromOUPortal."No. 6", GetValueAtCell(RowNo, 46));
        Evaluate(grecModuleFromOUPortal."Common Module Code 6", GetValueAtCell(RowNo, 47));
        if GetValueAtCell(RowNo, 48) = '' then
            Evaluate(grecModuleFromOUPortal."Module Amount 6", '0')
        else
            Evaluate(grecModuleFromOUPortal."Module Amount 6", GetValueAtCell(RowNo, 48));

        if GetValueAtCell(RowNo, 49) = '' then
            Evaluate(grecModuleFromOUPortal."Module 6 Fee Ins", '0')
        else
            Evaluate(grecModuleFromOUPortal."Module 6 Fee Ins", GetValueAtCell(RowNo, 49));
        if GetValueAtCell(RowNo, 50) = '' then
            Evaluate(grecModuleFromOUPortal."Module Credit 6", '0')
        else
            Evaluate(grecModuleFromOUPortal."Module Credit 6", GetValueAtCell(RowNo, 50));


        //Shortcut Dimension
        EVALUATE(grecModuleFromOUPortal."Shortcut Dimension 1 Code", GetValueAtCell(RowNo, 14));

        if GetValueAtCell(RowNo, 9) <> '' then begin
            grecGenLedgSetup.get;
            Evaluate(gdateDim2, GetValueAtCell(RowNo, 9));

            grecDimValue.Reset();
            grecDimValue.SetRange("Dimension Code", grecGenLedgSetup."Global Dimension 2 Code");
            grecDimValue.SetFilter("Starting Date", '>=%1', gdateDim2);
            if grecDimValue.Findfirst then begin
                repeat
                    if gdateDim2 <= grecDimValue."Ending Date" then
                        grecModuleFromOUPortal."Shortcut Dimension 2 Code" := grecDimValue.Code;
                until (grecDimValue.Next = 0) or (grecModuleFromOUPortal2."Shortcut Dimension 2 Code" <> '');
            end;

            //Student Personal Info
            Evaluate(grecModuleFromOUPortal.RDAP, GetValueAtCell(RowNo, 2));
            Evaluate(grecModuleFromOUPortal.RDBL, GetValueAtCell(RowNo, 3));
            Evaluate(grecModuleFromOUPortal.NIC, GetValueAtCell(RowNo, 4));
            Evaluate(grecModuleFromOUPortal."First Name", GetValueAtCell(RowNo, 6));
            Evaluate(grecModuleFromOUPortal."Last Name", GetValueAtCell(RowNo, 7));
            Evaluate(grecModuleFromOUPortal."Maiden Name", GetValueAtCell(RowNo, 8));
            Evaluate(grecModuleFromOUPortal."Login Email", GetValueAtCell(RowNo, 11));
            Evaluate(grecModuleFromOUPortal."Contact Email", GetValueAtCell(RowNo, 12));

            Evaluate(grecModuleFromOUPortal."Phone No.", GetValueAtCell(RowNo, 51));
            Evaluate(grecModuleFromOUPortal."Mobile No.", GetValueAtCell(RowNo, 52));
            Evaluate(grecModuleFromOUPortal.Address, GetValueAtCell(RowNo, 53));
            Evaluate(grecModuleFromOUPortal.Country, GetValueAtCell(RowNo, 54));
            Evaluate(grecModuleFromOUPortal.Status, GetValueAtCell(RowNo, 56));

            if (GetValueAtCell(RowNo, 57) <> '') AND (GetValueAtCell(RowNo, 57) <> 'Rs') then
                grecModuleFromOUPortal.Currency := 'USD';

            //Evaluate(grecModuleFromOUPortal.Currency, GetValueAtCell(RowNo, 57));

            grecModuleFromOUPortal."Imported By" := UserId;
            grecModuleFromOUPortal."Imported On" := CurrentDateTime;

            if GetValueAtCell(RowNo, 55) = 'yes' then
                grecModuleFromOUPortal."Gov Grant" := true;

            if GetValueAtCell(RowNo, 58) = 'yes' then
                grecModuleFromOUPortal.Instalment := true;

            if GetValueAtCell(RowNo, 59) <> '' then
                Evaluate(grecModuleFromOUPortal."Payment Amount", GetValueAtCell(RowNo, 59));

            grecModuleFromOUPortal."Portal Payment Mode" := GetValueAtCell(RowNo, 60);
            grecModuleFromOUPortal."MyT Money Ref" := GetValueAtCell(RowNo, 61);
            Evaluate(grecModuleFromOUPortal."Payment Date", GetValueAtCell(RowNo, 62));

            grecModuleFromOUPortal.INSERT(TRUE);
            gintCounter += 1;
        END;
    END;


    var
        ExcelBuf: Record "Excel Buffer";
        ServerFileName: Text[250];
        SheetName: Text[250];
        TotalRows: Integer;
        TotalColumns: Integer;
        FileMgt: Codeunit "File Management";
        Text006: Label 'Import Excel File';
        ExcelExtensionTok: Label '.xlsx';
        X: Integer;
        grecModuleFromOUPortal: Record "Module Fee From OU Portal";
        grecModuleFromOUPortal2: Record "Module Fee From OU Portal";
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
        gdateDim2: Date;
        grecDimValue: Record "Dimension Value";
        glblDimError: Label 'Shortcut Dimension %1 does not exist.';
        glblModuleError: Label 'Module code %1 does not exist.';
        grecCustomer2: Record Customer;
        gintCounter: Integer;
}

