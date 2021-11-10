pageextension 50064 CashReceiptJournal extends "Cash Receipt Journal"
{
    layout
    {
        modify("External Document No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Currency Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Amount (LCY)")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Debit Amount")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify(Correction)
        {
            Visible = false;
        }
        modify("Applies-to Doc. Type")
        {
            Visible = false;
        }
        modify("Applies-to Doc. No.")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        addfirst(Control1)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter(Description)
        {
            field("Posting Group"; Rec."Posting Group")
            {
                Visible = true;
                Editable = true;
                ApplicationArea = All;
            }
            field("Voucher No."; "Voucher No.")
            {
                ApplicationArea = All;
            }
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
            }
        }

        addbefore("Shortcut Dimension 1 Code")
        {
            field("Student ID"; "Student ID") { ApplicationArea = All; }
        }
        addafter(Description)
        {
            field(Payee; Payee) { ApplicationArea = All; }
        }
        addlast(Control1)
        {

            field("Created By"; "Created By") { ApplicationArea = All; }
            field(RDAP; RDAP) { ApplicationArea = ALL; }
            field(RDBL; RDBL) { ApplicationArea = ALL; }
            field(NIC; NIC) { ApplicationArea = ALL; }
            field("Student Name"; "Student Name") { ApplicationArea = ALL; }
            field("Login Email"; "Login Email") { ApplicationArea = ALL; }
            field("Contact Email"; "Contact Email") { ApplicationArea = ALL; }
            field(Phone; Phone) { ApplicationArea = ALL; }
            field(Mobile; Mobile) { ApplicationArea = ALL; }
            field(Address; Address) { ApplicationArea = ALL; }
            field(Country; Country) { ApplicationArea = ALL; }
        }
        addafter(CurrentJnlBatchName)
        {
            field(LastNoUsedPosted; GetLastUsedPostedNo())
            {
                ApplicationArea = all;
                Caption = 'Posted Last No. Used';
                Editable = false;
                ToolTip = 'Specifies the last number that was used from the number series.';
            }
        }
        modify("Account No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                GLAccount: Record "G/L Account";
                GLAccountList: Page "G/L Account List";

                Cust: Record Customer;
                CustList: Page "Customer List";

                FixedAsset: Record "Fixed Asset";
                FixedAssetList: Page "Fixed Asset List";

                Vendor: Record Vendor;
                VendorList: Page "Vendor Lookup";

                BankAcc: Record "Bank Account";
                BankAccList: Page "Bank Account List";

                ICPartner: Record "IC Partner";
                ICPartnerList: Page "IC Partner List";

                Employee: Record Employee;
                EmployeeList: Page "Employee List";
            begin
                case "Account Type" of
                    "Account Type"::"G/L Account":
                        begin
                            GLAccount.Reset();
                            GLAccount.SetRange(Income, true);
                            GLAccountList.SetTableView(GLAccount);
                            GLAccountList.LookupMode(true);
                            if GLAccountList.RunModal() = Action::LookupOK then begin
                                GLAccountList.GetRecord(GLAccount);
                                Rec.Validate("Account No.", GLAccount."No.");
                            end;
                        end;
                    "Account Type"::Customer:
                        begin
                            Cust.Reset();
                            CustList.SetTableView(Cust);
                            CustList.LookupMode(true);
                            if CustList.RunModal() = Action::LookupOK then begin
                                CustList.GetRecord(Cust);
                                Rec.Validate("Account No.", Cust."No.");
                            end;
                        end;
                    "Account Type"::Vendor:
                        begin
                            Vendor.Reset();
                            VendorList.SetTableView(Vendor);
                            VendorList.LookupMode(true);
                            if VendorList.RunModal() = Action::LookupOK then begin
                                VendorList.GetRecord(Vendor);
                                Rec.Validate("Account No.", Vendor."No.");
                            end;
                        end;
                    "Account Type"::"Bank Account":
                        begin
                            BankAcc.Reset();
                            BankAccList.SetTableView(BankAcc);
                            BankAccList.LookupMode(true);
                            if BankAccList.RunModal() = Action::LookupOK then begin
                                BankAccList.GetRecord(BankAcc);
                                Rec.Validate("Account No.", BankAcc."No.");
                            end;
                        end;
                    "Account Type"::"Fixed Asset":
                        begin
                            FixedAsset.Reset();
                            FixedAssetList.SetTableView(FixedAsset);
                            FixedAssetList.LookupMode(true);
                            if FixedAssetList.RunModal() = Action::LookupOK then begin
                                FixedAssetList.GetRecord(FixedAsset);
                                Rec.Validate("Account No.", FixedAsset."No.");
                            end;
                        end;
                    "Account Type"::"IC Partner":
                        begin
                            ICPartner.Reset();
                            ICPartnerList.SetTableView(ICPartner);
                            ICPartnerList.LookupMode(true);
                            if ICPartnerList.RunModal() = Action::LookupOK then begin
                                ICPartnerList.GetRecord(ICPartner);
                                Rec.Validate("Account No.", ICPartner.Code);
                            end;
                        end;
                    "Account Type"::Employee:
                        begin
                            Employee.Reset();
                            EmployeeList.SetTableView(Employee);
                            EmployeeList.LookupMode(true);
                            if EmployeeList.RunModal() = Action::LookupOK then begin
                                EmployeeList.GetRecord(Employee);
                                Rec.Validate("Account No.", Employee."No.");
                            end;
                        end;
                end;
            end;
        }
        modify("Bal. Account No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                GLAccount: Record "G/L Account";
                GLAccountList: Page "G/L Account List";

                Cust: Record Customer;
                CustList: Page "Customer List";

                FixedAsset: Record "Fixed Asset";
                FixedAssetList: Page "Fixed Asset List";

                Vendor: Record Vendor;
                VendorList: Page "Vendor Lookup";

                BankAcc: Record "Bank Account";
                BankAccList: Page "Bank Account List";

                ICPartner: Record "IC Partner";
                ICPartnerList: Page "IC Partner List";

                Employee: Record Employee;
                EmployeeList: Page "Employee List";
            begin
                case "Bal. Account Type" of
                    "Bal. Account Type"::"G/L Account":
                        begin
                            GLAccount.Reset();
                            GLAccount.SetRange(Income, true);
                            GLAccountList.SetTableView(GLAccount);
                            GLAccountList.LookupMode(true);
                            if GLAccountList.RunModal() = Action::LookupOK then begin
                                GLAccountList.GetRecord(GLAccount);
                                Rec.Validate("Bal. Account No.", GLAccount."No.");
                            end;
                        end;
                    "Bal. Account Type"::Customer:
                        begin
                            Cust.Reset();
                            CustList.SetTableView(Cust);
                            CustList.LookupMode(true);
                            if CustList.RunModal() = Action::LookupOK then begin
                                CustList.GetRecord(Cust);
                                Rec.Validate("Bal. Account No.", Cust."No.");
                            end;
                        end;
                    "Bal. Account Type"::Vendor:
                        begin
                            Vendor.Reset();
                            VendorList.SetTableView(Vendor);
                            VendorList.LookupMode(true);
                            if VendorList.RunModal() = Action::LookupOK then begin
                                VendorList.GetRecord(Vendor);
                                Rec.Validate("Bal. Account No.", Vendor."No.");
                            end;
                        end;
                    "Bal. Account Type"::"Bank Account":
                        begin
                            BankAcc.Reset();
                            BankAccList.SetTableView(BankAcc);
                            BankAccList.LookupMode(true);
                            if BankAccList.RunModal() = Action::LookupOK then begin
                                BankAccList.GetRecord(BankAcc);
                                Rec.Validate("Bal. Account No.", BankAcc."No.");
                            end;
                        end;
                    "Bal. Account Type"::"Fixed Asset":
                        begin
                            FixedAsset.Reset();
                            FixedAssetList.SetTableView(FixedAsset);
                            FixedAssetList.LookupMode(true);
                            if FixedAssetList.RunModal() = Action::LookupOK then begin
                                FixedAssetList.GetRecord(FixedAsset);
                                Rec.Validate("Bal. Account No.", FixedAsset."No.");
                            end;
                        end;
                    "Bal. Account Type"::"IC Partner":
                        begin
                            ICPartner.Reset();
                            ICPartnerList.SetTableView(ICPartner);
                            ICPartnerList.LookupMode(true);
                            if ICPartnerList.RunModal() = Action::LookupOK then begin
                                ICPartnerList.GetRecord(ICPartner);
                                Rec.Validate("Bal. Account No.", ICPartner.Code);
                            end;
                        end;
                    "Bal. Account Type"::Employee:
                        begin
                            Employee.Reset();
                            EmployeeList.SetTableView(Employee);
                            EmployeeList.LookupMode(true);
                            if EmployeeList.RunModal() = Action::LookupOK then begin
                                EmployeeList.GetRecord(Employee);
                                Rec.Validate("Bal. Account No.", Employee."No.");
                            end;
                        end;
                end;
            end;
        }
    }

    actions
    {
        /* addlast(processing)
        {
            action("Upload list of payments")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = UpdateXML;

                trigger OnAction()
                var
                    gpageListofUploadedPayments: Page "List of Uploaded Payments";
                begin
                    gpageListofUploadedPayments.Run();
                end;
            }
        } */
    }
    local procedure GetLastUsedPostedNo(): Code[20]
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        GenJnlBatch.Get(GetRangeMax("Journal Template Name"), GetRangeMax("Journal Batch Name"));
        if GenJnlBatch."Posting No. Series" = '' then
            exit('');
        NoSeriesMgt.SetNoSeriesLineFilter(NoSeriesLine, GenJnlBatch."Posting No. Series", 0D);
        exit(NoSeriesLine."Last No. Used");
    end;

    var
        LastUsedPostedNo: Code[20];
        GenJnlBatch: Record "Gen. Journal Batch";
        NoSeriesLine: Record "No. Series Line";
}