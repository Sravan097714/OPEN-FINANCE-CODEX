report 50025 "Bank Transfer"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\Bank Transfer Report.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            RequestFilterFields = "Posting Date", "Document No.";

            column(BankLetterFor; BankLetterFor) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(PostingDate; "Posting Date") { }
            column(BankName; BankAccount.Name) { }
            column(BankAddress; BankAccount.Address) { }
            column(BankAddress2; BankAccount."Address 2") { }
            column(BankAccNo; BankAccount."Bank Account No.") { }
            column(BankAccount_No; BankAccount."No.") { }
            column(AmountInWords; TextInWords[1] + '  ' + TextInWords[2]) { }
            column(NoText; TextInWords[1]) { }
            column(Amt; Amt) { }
            column(BankAccName; BankAccName) { }
            column(CurrentAccNo; CurrentAccNo) { }
            column(CompanyInfo_BRN; 'MPL Business Registration Number : ' + ' ' + CompanyInfo.BRN) { }
            column(DateofTransfer; '') { }
            column(CurrencyCode; CurrencyCode) { }
            column(JobTitle1; '') { }
            column(JobTitle2; '') { }
            column(Desig1; '') { }
            column(Desig2; '') { }

            trigger OnAfterGetRecord()
            begin
                grecGeneralLedgerSetup.get;
                Amt := ROUND(Abs("Credit Amount"), 0.01);
                if "Currency Code" <> '' then
                    CurrencyCode := "Currency Code"
                else
                    CurrencyCode := grecGeneralLedgerSetup."LCY Code";

                IF Amt <> 0 THEN BEGIN
                    IF "Bal. Account Type" = "Bal. Account Type"::"Bank Account" THEN BEGIN
                        IF BankAccount.GET("Bal. Account No.") THEN
                            BankAccName := BankAccount.Name + ' ' + BankAccount."Bank Account No.";
                        IF BankAccount.GET("Bank Account No.") THEN
                            CurrentAccNo := BankAccount.Name + ' - ' + BankAccount."Bank Account No.";
                    END;
                    Amt := ROUND(Abs("Credit Amount"), 0.01);
                    Check.InitTextVariable;
                    Check.FormatNoText(TextInWords, Abs("Credit Amount"), "Currency Code");
                END ELSE
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                //SETRANGE("Entry No.", "G/L Register"."From Entry No.", "G/L Register"."To Entry No.");
                BankLetterFor := 'Bank Transfer';
            end;
        }

    }

    trigger OnInitReport()
    begin
        CLEAR(Amt);
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        BankAccount: Record 270;
        TextInWords: array[2] of Text;
        Amt: Decimal;
        CurrencyCode: Text;
        CompanyInfo: Record 79;
        BankAccName: Text[250];
        CurrentAccNo: Text[250];
        BankLetterFor: Text[250];
        Language: Record 8;
        Check: Report 50021;
        grecGeneralLedgerSetup: Record "General Ledger Setup";
}

