page 50009 "Manage Budget by Department"
{
    PageType = List;
    SourceTable = Budget_By_Department;
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("G/L Account No."; "G/L Account No.")
                {
                    ApplicationArea = all;
                }
                field("G/L Description"; "G/L Description")
                {
                    ApplicationArea = all;
                }
                field(Department; Department)
                {
                    ApplicationArea = all;
                }
                field("Budgeted Amount"; "Budgeted Amount")
                {
                    ApplicationArea = all;
                }
                field("Budgeted Amt for Current Year"; "Budgeted Amt for Current Year")
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    var
                        grecGLBudgetEntry: Record "G/L Budget Entry";
                        gpageGLBudgetEntry: Page "G/L Budget Entries";
                        gdecBudgetAmt: Decimal;
                    begin
                        Clear(gdecBudgetAmt);
                        grecGLBudgetEntry.Reset();
                        grecGLBudgetEntry.SetRange("G/L Account No.", "G/L Account No.");
                        grecGLBudgetEntry.SetRange("Global Dimension 1 Code", Department);
                        grecGLBudgetEntry.SetRange("Include on Budget Matrix", true);
                        grecGLBudgetEntry.SetRange(Date, CALCDATE('<-CY>', Today), CALCDATE('<CY>', Today));
                        if grecGLBudgetEntry.FindSet() then;

                        gpageGLBudgetEntry.SetTableView(grecGLBudgetEntry);
                        gpageGLBudgetEntry.Run;
                    end;
                }
                field("Remaining Amount"; "Remaining Amount")
                {
                    ApplicationArea = all;
                    Caption = 'Remaining Amount for this Year';
                }
                field("R. Amt for Last Year (Closing)"; "R. Amt for Last Year (Closing)")
                {
                    ApplicationArea = all;
                }
                field("Additions for Current Year"; "Additions for Current Year")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Update Remaining Amount for Current Year")
            {
                Image = UpdateDescription;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction();
                var
                    grecManageBudget: Record Budget_By_Department;
                begin
                    grecManageBudget.Reset();
                    if grecManageBudget.FindSet then begin
                        repeat
                            grecManageBudget."Remaining Amount" := grecManageBudget."R. Amt for Last Year (Closing)" + grecManageBudget."Additions for Current Year";
                            grecManageBudget.Modify();
                        until grecManageBudget.Next = 0;
                        Message('Remaining Amount for Current Year has been updated.');
                    end;
                end;
            }

            action("Update Remaining Amount for Last Year")
            {
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction();
                var
                    grecManageBudget: Record Budget_By_Department;
                begin
                    grecManageBudget.Reset();
                    if grecManageBudget.FindSet then begin
                        repeat
                            grecManageBudget."R. Amt for Last Year (Closing)" := grecManageBudget."Remaining Amount";
                            grecManageBudget.Modify();
                        until grecManageBudget.Next = 0;
                        Message('Remaining Amount for Last Year has been updated.');
                    end;
                end;
            }

            action("Upload Additions for Current Year")
            {
                Image = Loaner;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Rec_ExcelBuffer.DeleteAll();
                    Rows := 0;
                    Columns := 0;
                    FileUploaded := UploadIntoStream('Select File to Upload', '', '', Filename, Instr);

                    if Filename <> '' then
                        Sheetname := Rec_ExcelBuffer.SelectSheetsNameStream(Instr)
                    else
                        exit;


                    Rec_ExcelBuffer.Reset;
                    Rec_ExcelBuffer.OpenBookStream(Instr, Sheetname);
                    Rec_ExcelBuffer.ReadSheet();

                    Commit();
                    Rec_ExcelBuffer.Reset();
                    Rec_ExcelBuffer.SetRange("Column No.", 1);
                    if Rec_ExcelBuffer.FindFirst() then
                        repeat
                            Rows := Rows + 1;
                        until Rec_ExcelBuffer.Next() = 0;
                    //Message(Format(Rows));

                    Rec_ExcelBuffer.Reset();
                    Rec_ExcelBuffer.SetRange("Row No.", 1);
                    if Rec_ExcelBuffer.FindFirst() then
                        repeat
                            Columns := Columns + 1;
                        until Rec_ExcelBuffer.Next() = 0;
                    //Message(Format(Columns));

                    //Modify or Insert
                    for RowNo := 2 to Rows do begin
                        grecBudgetByDept.Reset();
                        grecBudgetByDept.SetRange("G/L Account No.", GetValueAtIndex(RowNo, 1));
                        grecBudgetByDept.SetRange(Department, GetValueAtIndex(RowNo, 2));
                        if grecBudgetByDept.FindFirst() then begin
                            evaluate(grecBudgetByDept."Additions for Current Year", GetValueAtIndex(RowNo, 3));
                            grecBudgetByDept.Modify();
                        end else begin
                            grecBudgetByDept.Init();
                            grecBudgetByDept."G/L Account No." := GetValueAtIndex(RowNo, 1);
                            if grecGLAccount.get(GetValueAtIndex(RowNo, 1)) then
                                grecBudgetByDept."G/L Description" := grecGLAccount.Name
                            else
                                Error('G/L Account %1 does not exist.', GetValueAtIndex(RowNo, 1));


                            if grecDimensionValue.Get('DEPARTMENT', GetValueAtIndex(RowNo, 2)) then
                                grecBudgetByDept.Department := GetValueAtIndex(RowNo, 2)
                            else
                                Error('Department %1 does not exist.', GetValueAtIndex(RowNo, 2));

                            evaluate(grecBudgetByDept."Additions for Current Year", GetValueAtIndex(RowNo, 3));
                            grecBudgetByDept.Insert();
                        end;
                    end;
                    Message('Additions for Current Year have been uploaded. %1 Rows Imported Successfully!!', Rows - 1);
                end;
            }
        }
    }

    var
        Rec_ExcelBuffer: Record "Excel Buffer";
        Rows: Integer;
        Columns: Integer;
        Filename: Text;
        FileMgmt: Codeunit "File Management";
        ExcelFile: File;
        Instr: InStream;
        Sheetname: Text;
        FileUploaded: Boolean;
        RowNo: Integer;
        ColNo: Integer;
        Rec_GenJnl: Record "Gen. Journal Line";
        grecBudgetByDept: Record Budget_By_Department;
        grecGLAccount: Record "G/L Account";
        grecDimensionValue: Record "Dimension Value";



    trigger OnAfterGetRecord()
    var
        grecGLBudgetEntry2: Record "G/L Budget Entry";
        gdecBudgetAmt2: Decimal;
    begin
        grecGLBudgetEntry2.Reset();
        grecGLBudgetEntry2.SetRange("G/L Account No.", "G/L Account No.");
        grecGLBudgetEntry2.SetRange("Global Dimension 1 Code", Department);
        grecGLBudgetEntry2.SetRange(Date, CALCDATE('<-CY>', Today), CALCDATE('<CY>', Today));
        grecGLBudgetEntry2.SetRange("Include on Budget Matrix", true);
        if grecGLBudgetEntry2.FindSet() then begin
            repeat
                gdecBudgetAmt2 += grecGLBudgetEntry2.Amount;
            until grecGLBudgetEntry2.Next = 0;
        end;
        "Budgeted Amt for Current Year" := gdecBudgetAmt2;
        Modify();
    end;


    local procedure GetValueAtIndex(RowNo: Integer; ColNo: Integer): Text
    var
    begin
        Rec_ExcelBuffer.Reset();
        IF Rec_ExcelBuffer.Get(RowNo, ColNo) then
            exit(Rec_ExcelBuffer."Cell Value as Text");
    end;
}