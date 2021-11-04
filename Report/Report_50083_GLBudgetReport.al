report 50083 "G/L Budget Report"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\OUGLBUDGET.rdl';


    dataset
    {
        dataitem(GLBudgetbyAccountCategory1; "G/L Budget by Account Category")
        {
            DataItemTableView = sorting("Entry No.") where("Budget Category" = filter('RB01..RB08'));
            column(Budget_Category; "Budget Category") { }
            column(Description; Description) { }
            column(Original_Budgeted_Amt_for_Year; "Original Budgeted Amt for Year") { }
            column(Revised_Amount_for_Year__1_; "Revised Amount for Year (1)") { }
            column(Revised_Amount_for_Year__2_; "Revised Amount for Year (2)") { }
            column(Revised_Amount_for_Year__3_; "Revised Amount for Year (3)") { }
            column(Revised_Amount_for_Year__4_; "Revised Amount for Year (4)") { }
            column(Revised_Amount_for_Year__5_; "Revised Amount for Year (5)") { }
            column(Revised_Amount_for_Year__6_; "Revised Amount for Year (6)") { }
            column(Final_Budgeted_Amount_for_Year; "Final Budgeted Amount for Year") { }
            column(Actual_Amount_used_for_Year; "Actual Amount used for Year") { }
            column(Remaining_Amount_for_the_Year; "Remaining Amount for the Year") { }

            trigger OnPreDataItem()
            begin
                SetRange("Budget Name", gtextBudgetName);
            end;
        }

        dataitem(GLBudgetbyAccountCategory2; "G/L Budget by Account Category")
        {
            DataItemTableView = sorting("Entry No.") where("Budget Category" = filter('CE01..CE15'));
            column(Budget_Category2; "Budget Category") { }
            column(Description2; Description) { }
            column(Original_Budgeted_Amt_for_Year2; "Original Budgeted Amt for Year") { }
            column(Revised_Amount_for_Year__1_2; "Revised Amount for Year (1)") { }
            column(Revised_Amount_for_Year__2_2; "Revised Amount for Year (2)") { }
            column(Revised_Amount_for_Year__3_2; "Revised Amount for Year (3)") { }
            column(Revised_Amount_for_Year__4_2; "Revised Amount for Year (4)") { }
            column(Revised_Amount_for_Year__5_2; "Revised Amount for Year (5)") { }
            column(Revised_Amount_for_Year__6_2; "Revised Amount for Year (6)") { }
            column(Final_Budgeted_Amount_for_Year2; "Final Budgeted Amount for Year") { }
            column(Actual_Amount_used_for_Year2; "Actual Amount used for Year") { }
            column(Remaining_Amount_for_the_Year2; "Remaining Amount for the Year") { }

            trigger OnPreDataItem()
            begin
                SetRange("Budget Name", gtextBudgetName);
            end;
        }

        dataitem(GLBudgetbyAccountCategory3; "G/L Budget by Account Category")
        {
            DataItemTableView = sorting("Entry No.") where("Budget Category" = filter('TT01..TT04'));
            column(Budget_Category3; "Budget Category") { }
            column(Description3; Description) { }
            column(Original_Budgeted_Amt_for_Year3; "Original Budgeted Amt for Year") { }
            column(Revised_Amount_for_Year__1_3; "Revised Amount for Year (1)") { }
            column(Revised_Amount_for_Year__2_3; "Revised Amount for Year (2)") { }
            column(Revised_Amount_for_Year__3_3; "Revised Amount for Year (3)") { }
            column(Revised_Amount_for_Year__4_3; "Revised Amount for Year (4)") { }
            column(Revised_Amount_for_Year__5_3; "Revised Amount for Year (5)") { }
            column(Revised_Amount_for_Year__6_3; "Revised Amount for Year (6)") { }
            column(Final_Budgeted_Amount_for_Year3; "Final Budgeted Amount for Year") { }
            column(Actual_Amount_used_for_Year3; "Actual Amount used for Year") { }
            column(Remaining_Amount_for_the_Year3; "Remaining Amount for the Year") { }

            trigger OnPreDataItem()
            begin
                SetRange("Budget Name", gtextBudgetName);
            end;
        }

        dataitem(GLBudgetbyAccountCategory4; "G/L Budget by Account Category")
        {
            DataItemTableView = sorting("Entry No.") where("Budget Category" = filter('CG01..CG28'));
            column(Budget_Category4; "Budget Category") { }
            column(Description4; Description) { }
            column(Original_Budgeted_Amt_for_Year4; "Original Budgeted Amt for Year") { }
            column(Revised_Amount_for_Year__1_4; "Revised Amount for Year (1)") { }
            column(Revised_Amount_for_Year__2_4; "Revised Amount for Year (2)") { }
            column(Revised_Amount_for_Year__3_4; "Revised Amount for Year (3)") { }
            column(Revised_Amount_for_Year__4_4; "Revised Amount for Year (4)") { }
            column(Revised_Amount_for_Year__5_4; "Revised Amount for Year (5)") { }
            column(Revised_Amount_for_Year__6_4; "Revised Amount for Year (6)") { }
            column(Final_Budgeted_Amount_for_Year4; "Final Budgeted Amount for Year") { }
            column(Actual_Amount_used_for_Year4; "Actual Amount used for Year") { }
            column(Remaining_Amount_for_the_Year4; "Remaining Amount for the Year") { }

            trigger OnPreDataItem()
            begin
                SetRange("Budget Name", gtextBudgetName);
            end;
        }

        dataitem(GLBudgetbyAccountCategory5; "G/L Budget by Account Category")
        {
            DataItemTableView = sorting("Entry No.") where("Budget Category" = filter('SI01'));
            column(Budget_Category5; "Budget Category") { }
            column(Description5; Description) { }
            column(Original_Budgeted_Amt_for_Year5; "Original Budgeted Amt for Year") { }
            column(Revised_Amount_for_Year__1_5; "Revised Amount for Year (1)") { }
            column(Revised_Amount_for_Year__2_5; "Revised Amount for Year (2)") { }
            column(Revised_Amount_for_Year__3_5; "Revised Amount for Year (3)") { }
            column(Revised_Amount_for_Year__4_5; "Revised Amount for Year (4)") { }
            column(Revised_Amount_for_Year__5_5; "Revised Amount for Year (5)") { }
            column(Revised_Amount_for_Year__6_5; "Revised Amount for Year (6)") { }
            column(Final_Budgeted_Amount_for_Year5; "Final Budgeted Amount for Year") { }
            column(Actual_Amount_used_for_Year5; "Actual Amount used for Year") { }
            column(Remaining_Amount_for_the_Year5; "Remaining Amount for the Year") { }

            trigger OnPreDataItem()
            begin
                SetRange("Budget Name", gtextBudgetName);
            end;
        }

        dataitem(GLBudgetbyAccountCategory6; "G/L Budget by Account Category")
        {
            DataItemTableView = sorting("Entry No.") where("Budget Category" = filter('AA01..AA06'));
            column(Budget_Category6; "Budget Category") { }
            column(Description6; Description) { }
            column(Original_Budgeted_Amt_for_Year6; "Original Budgeted Amt for Year") { }
            column(Revised_Amount_for_Year__1_6; "Revised Amount for Year (1)") { }
            column(Revised_Amount_for_Year__2_6; "Revised Amount for Year (2)") { }
            column(Revised_Amount_for_Year__3_6; "Revised Amount for Year (3)") { }
            column(Revised_Amount_for_Year__4_6; "Revised Amount for Year (4)") { }
            column(Revised_Amount_for_Year__5_6; "Revised Amount for Year (5)") { }
            column(Revised_Amount_for_Year__6_6; "Revised Amount for Year (6)") { }
            column(Final_Budgeted_Amount_for_Year6; "Final Budgeted Amount for Year") { }
            column(Actual_Amount_used_for_Year6; "Actual Amount used for Year") { }
            column(Remaining_Amount_for_the_Year6; "Remaining Amount for the Year") { }

            trigger OnPreDataItem()
            begin
                SetRange("Budget Name", gtextBudgetName);
            end;
        }

        dataitem(GLBudgetbyAccountCategory7; "G/L Budget by Account Category")
        {
            DataItemTableView = sorting("Entry No.") where("Budget Category" = filter('AE01..AE04'));
            column(Budget_Category7; "Budget Category") { }
            column(Description7; Description) { }
            column(Original_Budgeted_Amt_for_Year7; "Original Budgeted Amt for Year") { }
            column(Revised_Amount_for_Year__1_7; "Revised Amount for Year (1)") { }
            column(Revised_Amount_for_Year__2_7; "Revised Amount for Year (2)") { }
            column(Revised_Amount_for_Year__3_7; "Revised Amount for Year (3)") { }
            column(Revised_Amount_for_Year__4_7; "Revised Amount for Year (4)") { }
            column(Revised_Amount_for_Year__5_7; "Revised Amount for Year (5)") { }
            column(Revised_Amount_for_Year__6_7; "Revised Amount for Year (6)") { }
            column(Final_Budgeted_Amount_for_Year7; "Final Budgeted Amount for Year") { }
            column(Actual_Amount_used_for_Year7; "Actual Amount used for Year") { }
            column(Remaining_Amount_for_the_Year7; "Remaining Amount for the Year") { }

            trigger OnPreDataItem()
            begin
                SetRange("Budget Name", gtextBudgetName);
            end;
        }
    }


    var
        gtextBudgetName: text;


    procedure SetBudgetName(ptextBudgetName: Text)
    begin
        gtextBudgetName := ptextBudgetName;
    end;
}

