report 50031 "Import App Fee from OU Portal"
{
    ProcessingOnly = true;
    //UsageCategory = Administration;
    //ApplicationArea = All;
    Caption = 'Import Application Fee from OU Portal';

    RequestPage
    {
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            gtextFilename: Text[50];
        begin
            gtextFilename := 'C:\Users\';
            gtextFilename += 'app_fee_' + FORMAT(20210222D, 0, '<Year4><Month,2><Day,2>') + '.xlsx';

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
        MESSAGE('%1 lines have been uploaded in the system for Application Fees.', gintCounter);
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
        grecSalesReceivableSetup.Get;
        clear(grecGenJnlLine);

        grecGenJnlLine2.Reset();
        grecGenJnlLine2.SetRange("Journal Template Name", 'CASH RECE');
        grecGenJnlLine2.SetRange("Journal Batch Name", grecSalesReceivableSetup."Journal Batch Name OU Portal");
        if grecGenJnlLine2.FindLast then
            grecGenJnlLine."Line No." := grecGenJnlLine2."Line No." + 10000
        else
            grecGenJnlLine."Line No." := 10000;

        grecGenJnlLine.Init();
        grecGenJnlLine."From OU Portal" := true;
        grecGenJnlLine."Journal Template Name" := 'CASH RECE';
        grecGenJnlLine."Journal Batch Name" := grecSalesReceivableSetup."Journal Batch Name OU Portal";
        grecGenJnlLine."Document Type" := grecGenJnlLine."Document Type"::Payment;

        NoSeries.RESET;
        NoSeries.SETRANGE("Series Code", grecSalesReceivableSetup."No. Series for OU Portal");
        IF NoSeries.FINDLAST THEN
            grecGenJnlLine."Document No." := NoSeriesMgt.GetNextNo(grecSalesReceivableSetup."No. Series for OU Portal", Today, false);

        EVALUATE(grecGenJnlLine."Posting Date", GetValueAtCell(RowNo, 23));
        grecGenJnlLine."Account Type" := grecGenJnlLine."Account Type"::"G/L Account";
        grecGenJnlLine.Validate("Account No.", grecSalesReceivableSetup."G/L Acc. for App Reg OU Portal");
        grecGenJnlLine."Payment Method Code" := GetValueAtCell(RowNo, 21);
        EVALUATE(grecGenJnlLine.Amount, GetValueAtCell(RowNo, 20));
        grecGenJnlLine."Bal. Account Type" := grecGenJnlLine."Bal. Account Type"::"Bank Account";
        grecGenJnlLine.Validate("Bal. Account No.", grecSalesReceivableSetup."Bank Acc. No. for OU Portal");

        grecGenJnlLine."Student ID" := GetValueAtCell(RowNo, 2);
        grecGenJnlLine.RDAP := GetValueAtCell(RowNo, 4);
        grecGenJnlLine.RDBL := GetValueAtCell(RowNo, 5);
        grecGenJnlLine.NIC := GetValueAtCell(RowNo, 6);
        grecGenJnlLine."Student Name" := GetValueAtCell(RowNo, 7) + ' ' + GetValueAtCell(RowNo, 9) + ' ' + GetValueAtCell(RowNo, 8);

        if GetValueAtCell(RowNo, 10) <> '' then begin
            grecGenLedgSetup.get;
            Evaluate(gdateDim2, GetValueAtCell(RowNo, 10));

            grecDimValue.Reset();
            grecDimValue.SetRange("Dimension Code", grecGenLedgSetup."Global Dimension 2 Code");
            grecDimValue.SetFilter("Starting Date", '>=%1', gdateDim2);
            if grecDimValue.Findfirst then begin
                repeat
                    if gdateDim2 <= grecDimValue."Ending Date" then
                        grecGenJnlLine."Shortcut Dimension 2 Code" := grecDimValue.Code;
                until (grecDimValue.Next = 0) or (grecGenJnlLine."Shortcut Dimension 2 Code" <> '');
            end;
        end;

        //grecGenJnlLine."Shortcut Dimension 2 Code" := GetValueAtCell(RowNo, 8);
        grecGenJnlLine."Login Email" := GetValueAtCell(RowNo, 12);
        grecGenJnlLine."Contact Email" := GetValueAtCell(RowNo, 13);
        grecGenJnlLine.Phone := GetValueAtCell(RowNo, 14);
        grecGenJnlLine.Mobile := GetValueAtCell(RowNo, 15);
        grecGenJnlLine.Address := GetValueAtCell(RowNo, 16);
        grecGenJnlLine.Country := GetValueAtCell(RowNo, 17);

        if (GetValueAtCell(RowNo, 19) <> '') AND (GetValueAtCell(RowNo, 19) <> 'Rs') then
            grecGenJnlLine."Currency Code" := 'USD';
        grecGenJnlLine.Insert();
        gintCounter += 1;
    END;


    var
        ExcelBuf: Record "Excel Buffer";
        ServerFileName: Text[250];
        SheetName: Text[250];
        grecGenLedgSetup: Record "General Ledger Setup";
        gdateDim2: Date;
        grecDimValue: Record "Dimension Value";
        TotalRows: Integer;
        TotalColumns: Integer;
        FileMgt: Codeunit 419;
        Text006: Label 'Import Excel File';
        ExcelExtensionTok: Label '.xlsx';
        X: Integer;
        EntryNo: Integer;
        grecGenJnlLine: Record "Gen. Journal Line";
        grecGenJnlLine2: Record "Gen. Journal Line";
        grecSalesReceivableSetup: Record "Sales & Receivables Setup";
        NoSeries: Record "No. Series Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        gintCounter: Integer;

}

