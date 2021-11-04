report 50093 "List of Payments After Posting"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\ListofPaymentsAfterPosting.rdl';

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = where("Document Type" = filter('Payment'));
            RequestFilterFields = "Document Type", "Document No.", "Bank Account No.", "Bal. Account Type", "Bal. Account No.", "PV Number";
            column(CompanyName; grecCompanyInfo.Name) { }
            column(Posting_Date; format("Posting Date")) { }
            column(PV_No; "PV Number") { }
            column(PayeeName; payeenamevar) { }
            column(Amount__LCY_; "Amount (LCY)" * -1) { }
            column(ChequeNo; "Document No.") { }
            column(BankName; gtextBankName) { }
            column(Bank_Account_No_; "Bank Account No.") { }
            column(gtextDateFilter; gtextDateFilter) { }


            trigger OnPreDataItem()
            begin
                SetFilter("Posting Date", gtextDateFilter);
                if gintGLRegisterNo = 0 then
                    Error('Please select G/L Register No.');
                glregisterrec.Get(gintGLRegisterNo);
                SetRange("Entry No.", glregisterrec."From Entry No.", glregisterrec."To Entry No.");


            end;

            trigger OnAfterGetRecord()
            begin
                Clear(gtextBankName);
                if grecBankAccount.get("Bank Account No.") then
                    gtextBankName := grecBankAccount.Name;


                if "Payee Name" <> '' then
                    payeenamevar := "Payee Name"
                else begin
                    grecvendorledgerentry.Reset();
                    grecvendorledgerentry.SetRange("Document No.", "Document No.");
                    if grecvendorledgerentry.FindFirst then begin
                        grecvendorrec.Get(grecvendorledgerentry."Vendor No.");
                        payeenamevar := grecvendorrec.Name;
                    end;





                end;

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Date Filter ")
                {
                    field("Date Filter"; gtextDateFilter)
                    {
                        ApplicationArea = All;

                    }
                    field("G/L Register No."; gintGLRegisterNo)
                    {
                        ApplicationArea = All;
                        TableRelation = "G/L Register"."No." where("Source Code" = filter('PAYMENTJNL'));
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        grecCompanyInfo.get;
    end;

    var
        gtextDateFilter: Text;
        gtextBankName: Text;
        grecBankAccount: Record "Bank Account";
        grecCompanyInfo: Record "Company Information";
        gintGLRegisterNo: Integer;

        glregisterrec: Record "G/L Register";
        grecvendorledgerentry: Record "Vendor Ledger Entry";
        grecvendorrec: Record Vendor;
        payeenamevar: Text;
}