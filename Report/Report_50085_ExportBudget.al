report 50085 "Export Budget"
{
    ProcessingOnly = true;
    //UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = All;

    dataset
    {
        dataitem("G/L Budget by Account Category"; "G/L Budget by Account Category")
        {
            trigger OnAfterGetRecord()
            begin
                ExcelBuf.NewRow;
                ExcelBuf.AddColumn("Budget Name", FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Budget Category", FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Description, FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(FORMAT("Date From", 10, '<Year4><Month,2><Day,2>'), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(FORMAT("Date To", 10, '<Year4><Month,2><Day,2>'), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(genumBudgetToUse, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                case genumBudgetToUse of
                    genumBudgetToUse::"Original Budgeted Amount for the Year":
                        gdecAmount := "Original Budgeted Amt for Year";

                    genumBudgetToUse::"Revised Amount for the Year (1)":
                        gdecAmount := "Revised Amount for Year (1)";

                    genumBudgetToUse::"Revised Amount for the Year (2)":
                        gdecAmount := "Revised Amount for Year (2)";

                    genumBudgetToUse::"Revised Amount for the Year (3)":
                        gdecAmount := "Revised Amount for Year (3)";

                    genumBudgetToUse::"Revised Amount for the Year (4)":
                        gdecAmount := "Revised Amount for Year (4)";

                    genumBudgetToUse::"Revised Amount for the Year (5)":
                        gdecAmount := "Revised Amount for Year (5)";

                    genumBudgetToUse::"Revised Amount for the Year (6)":
                        gdecAmount := "Revised Amount for Year (6)";

                    genumBudgetToUse::"Final Budgeted Amount for the Year":
                        gdecAmount := "Final Budgeted Amount for Year";
                end;
                ExcelBuf.AddColumn(gdecAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Budget Name", gtextBudgetName);
            end;
        }

    }

    trigger OnPostReport()
    begin
        CreateExcelBook;
    end;

    var
        gtextBudgetName: Text;
        ExcelBuf: Record "Excel Buffer" temporary;
        genumBudgetToUse: Enum "Budget Account Category";
        gdecAmount: Decimal;


    local procedure MakeExcelDataHeader()
    begin

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Budget Name', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Budget Category', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Description', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Date From', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Date To', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Budget Column to use', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Amount', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
    end;


    local procedure CreateExcelBook()
    begin
        ExcelBuf.CreateBookAndOpenExcel('', 'Budget Export', '', COMPANYNAME, USERID);
    end;

    procedure SetBudgetName(ptextBudgetName: Text; penumBudgetToUse: Enum "Budget Account Category")
    begin
        gtextBudgetName := ptextBudgetName;
        genumBudgetToUse := penumBudgetToUse;
    end;
}

