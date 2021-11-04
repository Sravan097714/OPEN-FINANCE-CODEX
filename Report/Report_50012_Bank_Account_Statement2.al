report 50012 "Bank Account Statement 2"
{
    // version NAVW113.01

    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\Bank Account Statement.rdl';
    Caption = 'Bank Account Statement';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {
            DataItemTableView = SORTING("Bank Account No.", "Statement No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Bank Account No.", "Statement No.";
            column(ComanyName; COMPANYPROPERTY.DISPLAYNAME) { }
            column(BankAccStmtTableCaptFltr; TABLECAPTION + ': ' + BankAccStmtFilter) { }
            column(BankAccStmtFilter; BankAccStmtFilter) { }
            column(StmtNo_BankAccStmt; "Statement No.")
            {
                IncludeCaption = true;
            }
            column(Amt_BankAccStmtLineStmt; "Bank Account Statement Line"."Statement Amount") { }
            column(AppliedAmt_BankAccStmtLine; "Bank Account Statement Line"."Applied Amount") { }
            column(BankAccNo_BankAccStmt; "Bank Account No.") { }
            column(BankAccStmtCapt; BankAccStmtCaptLbl) { }
            column(CurrReportPAGENOCapt; CurrReportPAGENOCaptLbl) { }
            column(BnkAccStmtLinTrstnDteCapt; BnkAccStmtLinTrstnDteCaptLbl) { }
            column(BnkAcStmtLinValDteCapt; BnkAcStmtLinValDteCaptLbl) { }
            column(Statement_Date; format("Statement Date")) { }
            column(Balance_Last_Statement; "Balance Last Statement") { }
            column(Statement_Ending_Balance; "Statement Ending Balance") { }

            dataitem("Bank Account Statement Line"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."),
                               "Statement No." = FIELD("Statement No.");
                DataItemTableView = SORTING("Bank Account No.", "Statement No.", "Statement Line No.") where("Statement Amount" = filter(<> 0));
                column(TrnsctnDte_BnkAcStmtLin; FORMAT("Transaction Date")) { }
                column(Type_BankAccStmtLine; Type)
                {
                    IncludeCaption = true;
                }
                column(LineDocNo_BankAccStmt; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(AppliedEntr_BankAccStmtLine; "Applied Entries")
                {
                    IncludeCaption = true;
                }
                column(Amt1_BankAccStmtLineStmt; "Statement Amount")
                {
                    IncludeCaption = true;
                }
                column(AppliedAmt1_BankAccStmtLine; "Applied Amount")
                {
                    IncludeCaption = true;
                }
                column(Desc_BankAccStmtLine; Description)
                {
                    IncludeCaption = true;
                }
                column(ValueDate_BankAccStmtLine; FORMAT("Value Date")) { }

                dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
                {
                    DataItemTableView = sorting("Bank Account No.", "Posting Date") where("Statement Status" = const(Closed));
                    DataItemLink = "Bank Account No." = field("Bank Account No."),
                                    "Statement No." = field("Statement No.");

                    column(Posting_Date; format("Posting Date")) { }
                    column(Document_Type; "Document Type") { }
                    column(Document_No_; "Document No.") { }
                    column(Description; Description) { }
                    column(Currency_Code; "Currency Code") { }
                    column(Amount; Amount) { }
                    column(Amount__LCY_; "Amount (LCY)") { }
                }

                trigger OnPreDataItem()
                begin
                    //CurrReport.CREATETOTALS("Statement Amount", "Applied Amount");
                end;
            }

            trigger OnPreDataItem()
            begin
                /* CurrReport.CREATETOTALS(
                  "Bank Account Statement Line"."Statement Amount",
                  "Bank Account Statement Line"."Applied Amount"); */
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        TotalCaption = 'Total';
    }

    trigger OnPreReport()
    begin
        BankAccStmtFilter := "Bank Account Statement".GETFILTERS;
    end;

    var
        BankAccStmtFilter: Text;
        BankAccStmtCaptLbl: Label 'Bank Account Statement';
        CurrReportPAGENOCaptLbl: Label 'Page';
        BnkAccStmtLinTrstnDteCaptLbl: Label 'Transaction Date';
        BnkAcStmtLinValDteCaptLbl: Label 'Value Date';
}

