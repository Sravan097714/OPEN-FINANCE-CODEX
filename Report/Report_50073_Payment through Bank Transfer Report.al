report 50073 "Payment through Bank Transfer"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\Bank Transfer Report_vendor2.rdl';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Payment through Bank Transfer Report';
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Register"; "G/L Register")
        {
            DataItemTableView = sorting("No.") where("Source Code" = filter('PAYMENTJNL'));
            //RequestFilterFields = "No.";
            column(gtextTypeofTransfer; gtextTypeofTransfer) { }
            column(gdatePaymentDate; format(gdatePaymentDate)) { }
            column(gtextPurposeofTransfer; gtextPurposeofTransfer) { }
            column(gtextMonth; gtextMonth) { }
            column(gdecCreditAmt; gdecCreditAmt) { }
            column(gintTransacNo; gintTransacNo) { }
            column(OurRefNo; OurRefNo) { }
            column(BankName; gtextBank) { }
            column(BankAccNo; BankAccount."Bank Account No.") { }

            column(Chairman; grecPurchPayableSetup."Bulk Bank Transfer – Chaiman") { }
            column(DirectorGeneral; grecPurchPayableSetup."Bank Trans – Director General") { }
            column(Enc; grecPurchPayableSetup."Bulk Bank Transfer – enc.") { }

            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                RequestFilterFields = "Document No.";

                column(BankLetterFor; BankLetterFor) { }
                column(CompanyInfo_Picture; CompanyInfo.Picture) { }
                column(Footer1; CompanyInfo.TAN) { }
                column(Footer2; CompanyInfo.BRN) { }
                column(Footer3; CompanyInfo."Payer Name") { }
                column(Footer4; CompanyInfo."Telephone Number") { }
                column(Footer5; CompanyInfo."Mobile Number") { }

                column(BankAddress; BankAccount.Address) { }
                column(BankAddress2; BankAccount."Address 2") { }

                column(BankAcc_IBAN; BankAccount.IBAN) { }
                column(BankAcc_SwiftCode; BankAccount."SWIFT Code") { }
                column(GenJnlLine_Comment; GenJnlLine.Comment) { }
                column(BankAcc_CurrencyCode; BankAccount."Currency Code") { }
                column(BankAccName; BankAccName) { }
                column(VendorSwiftCode; VendorSwiftCode) { }
                column(VendorIBAN; VendorIBAN) { }
                column(BankSwiftCode; BankSwiftCode) { }
                column(BankIBAN; BankIBAN) { }
                column(CurrCode; CurrCode) { }
                column(PostingDate; "Posting Date") { }
                column(CurrencyCode; "Currency Code") { }
                column(CurrentAccNo; Description) { }
                column(VendorAccNo; VendorAccNo) { }

                column(NoText; TextInWords[1]) { }
                column(Amt; Amt) { }
                column(DocNoCaption; DocNoCaption)
                {
                    Caption = 'Document No';
                }
                column(DocTypeCaption; DocTypeCaption)
                {
                    Caption = 'Document Type';
                }
                column(PostingDateCaption; PostingDateCaption)
                {
                    Caption = 'Posting Date';
                }
                column(DescCaption; DescCaption)
                {
                    Caption = 'Description';
                }
                column(MessageToRecipient; "Vendor Ledger Entry"."Message to Recipient") { }
                column(AmtCaption; AmtCaption)
                {
                    Caption = 'Amount';
                }
                column(DocumentNo; "Vendor Ledger Entry"."Document No.") { }
                column(BankLetterSign; Signature[1]) { }
                column(BankLetterSign1; Signature[2]) { }
                column(BankLetterSignTitle; Signature[3]) { }
                column(BankLetterSignTitle1; Signature[4]) { }
                column(bankaccnum; bankaccnum) { }
                dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Document No." = field("Document No.");
                    DataItemTableView = where("Entry Type" = filter('Application'), "Initial Document Type" = filter('Invoice'));
                    column(Amt_VLE; Amount) { }
                    column(sumamount; sumamount) { }
                    column(AmountInWords; TextInWords[1] + '  ' + TextInWords[2]) { }

                    dataitem(VendorLedgerEntry2; "Vendor Ledger Entry")
                    {
                        DataItemLink = "Entry No." = field("Vendor Ledger Entry No.");
                        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
                        {
                            DataItemLink = "No." = field("Document No.");

                            column(gtextBeneficiaryAccNo; gtextBeneficiaryAccNo) { }
                            column(gtextBankCode; gtextBankCode) { }
                            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
                            column(Amount; Amount) { }

                            trigger OnAfterGetRecord()
                            begin
                                clear(gtextBeneficiaryAccNo);
                                Clear(gtextBankCode);
                                /* grecVendorBankAcc.Reset();
                                grecVendorBankAcc.SetRange("Vendor No.", "Purch. Inv. Header"."No.");
                                if grecVendorBankAcc.FindFirst() then begin
                                    gtextBeneficiaryAccNo := grecVendorBankAcc."Bank Account No.";
                                    gtextBankCode := grecVendorBankAcc."Bank Branch No.";
                                end; */
                                if grecVendor.Get("Buy-from Vendor No.") then begin
                                    gtextBeneficiaryAccNo := grecVendor."Bank Accout No.";
                                    gtextBankCode := grecVendor."Bank Code"
                                end;

                            end;
                        }
                    }
                    trigger OnAfterGetRecord()
                    begin
                        sumamount += Amount;

                        "Vendor Ledger Entry".CALCFIELDS(Amount);
                        Amt := ROUND(sumamount, 0.01);
                        Check.InitTextVariable;
                        Check.FormatNoText(TextInWords, Amt, '');
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    if BankAccount.Get("Bal. Account No.") then bankaccnum := BankAccount."Bank Account No.";
                    /* sumamount += amount;

                    "Vendor Ledger Entry".CALCFIELDS(Amount);
                    Amt := ROUND(sumamount, 0.01);
                    Check.InitTextVariable;
                    Check.FormatNoText(TextInWords, Amt, ''); */


                end;

                trigger OnPreDataItem()
                begin
                    BankLetterFor := 'Vendor Payment/Transfer';
                    SetRange("Entry No.", "G/L Register"."From Entry No.", "G/L Register"."To Entry No.");


                    BankAccount.Reset();
                    BankAccount.SetRange(Name, gtextBank);
                    if BankAccount.FindFirst() then;

                    clear(gdecCreditAmt);
                    grecVendorLedgerEntry.Reset();
                    grecVendorLedgerEntry.SetRange("Entry No.", "G/L Register"."From Entry No.", "G/L Register"."To Entry No.");
                    if grecVendorLedgerEntry.FindFirst() then begin
                        grecVendorLedgerEntry.CalcFields("Original Amount");
                        gdecCreditAmt += grecVendorLedgerEntry."Original Amount";
                    end;

                    Clear(gintTransacNo);
                    grecVendorLedgerEntry.SetRange("Document Type", grecVendorLedgerEntry."Document Type"::Payment);
                    gintTransacNo := grecVendorLedgerEntry.Count;
                end;
            }

            trigger OnPreDataItem()
            begin
                SetRange("No.", gintGLRegisterNo);
            end;
        }
    }



    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filter)
                {
                    field("G/L Register No."; gintGLRegisterNo)
                    {
                        ApplicationArea = All;
                        TableRelation = "G/L Register"."No." where("Source Code" = filter('PAYMENTJNL'));
                    }
                    field(Month; gtextMonth) { ApplicationArea = All; }
                    field(Bank; gtextBank)
                    {
                        //TableRelation = "Bank Account";
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            grecBankAccount: Record "Bank Account";
                            gpageBankAccList: Page "Bank Account List";
                        begin
                            grecBankAccount.Reset();
                            grecBankAccount.SetRange("No.");
                            if grecBankAccount.FindFirst() then begin
                                gpageBankAccList.SetRecord(grecBankAccount);
                                gpageBankAccList.SetTableView(grecBankAccount);
                                gpageBankAccList.LookupMode(true);
                                if gpageBankAccList.RunModal() = action::LookupOK then begin
                                    gpageBankAccList.GetRecord(grecBankAccount);
                                    gtextBank := grecBankAccount.Name;
                                end;
                            end;
                            gtextBank := grecBankAccount.Name;
                        end;
                    }
                    field("Type of Transfer"; gtextTypeofTransfer) { ApplicationArea = All; }
                    field("Payment Date"; gdatePaymentDate) { ApplicationArea = All; }
                    field("Purpose of Transfer"; gtextPurposeofTransfer) { ApplicationArea = All; }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
        grecPurchPayableSetup.Get;

        /*
        IF CompanyInfo.Print1 THEN BEGIN
          Signature[1] := CompanyInfo."E-mail Payer";
          Signature[3] := CompanyInfo."Bank Letter Sign Title";
        END;

        IF CompanyInfo.Print2 THEN BEGIN
          IF (Signature[1] = '') THEN BEGIN
            Signature[1] := CompanyInfo."Bank Letter Sign 1";
            Signature[3] := CompanyInfo."Bank Letter Sign 1 Title";
          END ELSE BEGIN
            Signature[2] := CompanyInfo."Bank Letter Sign 1";
            Signature[4] := CompanyInfo."Bank Letter Sign 1 Title";
          END;
        END;

        IF CompanyInfo.Print3 THEN BEGIN
          IF Signature[1] = '' THEN BEGIN
            Signature[1] := CompanyInfo."Business Registration No.";
            Signature[3] := CompanyInfo."Bank Address";
          END ELSE BEGIN
            Signature[2] := CompanyInfo."Business Registration No.";
            Signature[4] := CompanyInfo."Bank Address";
          END;
        END;

        IF CompanyInfo.Print4 THEN BEGIN
          Signature[2] := CompanyInfo."Bank Address 2";
          Signature[4] := CompanyInfo."Bank City";
        END;
        */
    end;

    var
        BankAccount: Record 270;
        CheckBase: Report 1401;
        //TextInWords: array[2] of Text;
        Amt: Decimal;
        CompanyInfo: Record 79;
        BankAccName: Text[250];
        Vendor: Record 23;
        CurrentAccNo: Text[250];
        BankLetterFor: Text[250];
        VendorAccNo: Text[250];
        PostingDateCaption: Label 'Posting Date';
        DocNoCaption: Label 'Document No.';
        DocTypeCaption: Label 'Document Type';
        DescCaption: Label 'Description';
        AmtCaption: Label 'Amount';
        OurRefNo: Label 'OU/F/3/1.1';
        Language: Record 8;
        Vendor2: Record 23;
        CurrCode: Text;
        VendorBankAccount: Record 288;
        VendorSwiftCode: Text[250];
        VendorIBAN: Text[250];
        BankSwiftCode: Text[250];
        BankIBAN: Text[250];
        GenJnlLine: Record 81;
        Comment: Text[250];
        Signature: array[4] of Text;


        gintGLRegisterNo: Integer;
        gtextMonth: Text[15];
        gtextBank: Text;
        gtextTypeofTransfer: Text[50];
        gdatePaymentDate: Date;
        gtextPurposeofTransfer: Text[50];
        grecVendorLedgerEntry: Record "Vendor Ledger Entry";
        gdecCreditAmt: Decimal;
        gintTransacNo: Integer;

        grecVendorBankAcc: Record "Vendor Bank Account";
        gtextBeneficiaryAccNo: Text;
        gtextBankCode: Text;
        grecVendor: Record Vendor;

        grecPurchPayableSetup: Record "Purchases & Payables Setup";
        bankaccnum: Text;
        CheckAmountText: Text[30];
        Check: Report 50021;
        TextInWords: array[2] of Text;

        sumamount: Decimal;
}

