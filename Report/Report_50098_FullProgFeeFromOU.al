report 50098 "Full Prog. Fee From OU Protal"
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
        FullProgFee.DeleteAll();
        ExcelBuf.LOCKTABLE;
        ExcelBuf.OpenBook(ServerFileName, SheetName);
        ExcelBuf.ReadSheet;
        GetLastRowandColumn;

        FOR X := 2 TO TotalRows DO
            InsertData(X);

        ExcelBuf.DELETEALL;

        MESSAGE('%1 lines have been uploaded in the system for Full Program Fee.', gintCounter);
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
        FullProgFee2.Reset();
        if FullProgFee2.FindLast then
            EntryNo := FullProgFee2."Line No." + 1
        else
            EntryNo := 1;

        FullProgFee.INIT;
        FullProgFee."Line No." := EntryNo;
        Evaluate(FullProgFee.RDAP, GetValueAtCell(RowNo, 2));
        Evaluate(FullProgFee.RDBL, GetValueAtCell(RowNo, 3));
        Evaluate(FullProgFee.NIC, GetValueAtCell(RowNo, 4));
        Evaluate(FullProgFee."Learner ID", GetValueAtCell(RowNo, 5));

        Evaluate(FullProgFee."First Name", GetValueAtCell(RowNo, 6));
        Evaluate(FullProgFee."Last Name", GetValueAtCell(RowNo, 7));
        Evaluate(FullProgFee."Maiden Name", GetValueAtCell(RowNo, 8));

        //Shortcut Dimension
        //EVALUATE(FullProgFee."Shortcut Dimension 1 Code", GetValueAtCell(RowNo, 12));

        if GetValueAtCell(RowNo, 9) <> '' then begin
            grecGenLedgSetup.get;
            Evaluate(gdateDim2, GetValueAtCell(RowNo, 10));

            grecDimValue.Reset();
            grecDimValue.SetRange("Dimension Code", grecGenLedgSetup."Global Dimension 2 Code");
            grecDimValue.SetFilter("Starting Date", '>=%1', gdateDim2);
            if grecDimValue.Findfirst then begin
                repeat
                    if gdateDim2 <= grecDimValue."Ending Date" then
                        FullProgFee.Intake := grecDimValue.Code;
                until (grecDimValue.Next = 0) or (FullProgFee.Intake <> '');
            end;
        End;

        Evaluate(FullProgFee."Login Email", GetValueAtCell(RowNo, 11));
        Evaluate(FullProgFee."Contact Email", GetValueAtCell(RowNo, 12));

        Evaluate(FullProgFee."Prog. Name", GetValueAtCell(RowNo, 13));
        Evaluate(FullProgFee."Prog. Code", GetValueAtCell(RowNo, 14));

        Evaluate(FullProgFee."Phone No.", GetValueAtCell(RowNo, 15));
        Evaluate(FullProgFee."Mobile No.", GetValueAtCell(RowNo, 16));
        Evaluate(FullProgFee.Address, GetValueAtCell(RowNo, 17));
        Evaluate(FullProgFee.Country, GetValueAtCell(RowNo, 18));
        Evaluate(FullProgFee.Status, GetValueAtCell(RowNo, 19));
        Evaluate(FullProgFee.Currency, GetValueAtCell(RowNo, 20));

        if GetValueAtCell(RowNo, 21) <> '' then
            Evaluate(FullProgFee.FullFees, GetValueAtCell(RowNo, 21));

        if GetValueAtCell(RowNo, 22) <> '' then
            Evaluate(FullProgFee.Discount, GetValueAtCell(RowNo, 22));

        if GetValueAtCell(RowNo, 23) <> '' then
            Evaluate(FullProgFee."Discount Amount", GetValueAtCell(RowNo, 23));

        if GetValueAtCell(RowNo, 24) <> '' then
            Evaluate(FullProgFee."Payment Amount", GetValueAtCell(RowNo, 24));

        Evaluate(FullProgFee."Payment Mode", GetValueAtCell(RowNo, 25));

        if GetValueAtCell(RowNo, 26) <> '' then
            Evaluate(FullProgFee."MyT Money Ref", GetValueAtCell(RowNo, 26));

        if GetValueAtCell(RowNo, 27) <> '' then
            Evaluate(FullProgFee."Payment Date", GetValueAtCell(RowNo, 27));

        FullProgFee."Imported By" := UserId;
        FullProgFee."Imported DateTime" := CurrentDateTime;

        FullProgFee.INSERT(TRUE);
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
        FullProgFee: Record "Full Prog. Fee From OU Protal";
        FullProgFee2: Record "Full Prog. Fee From OU Protal";
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

