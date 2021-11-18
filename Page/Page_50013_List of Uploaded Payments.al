page 50013 "List of Uploaded Payments"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "List of Uploaded Payments";
    SourceTableView = where("Updated To Nav" = const(false));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Line No."; "Entry No.") { ApplicationArea = All; }
                field("Posting Date"; "Posting Date") { ApplicationArea = All; }
                field("Student Code"; "Student Code") { ApplicationArea = All; }
                field("First Name"; "First Name") { }
                field("Last Name"; "Last Name") { }
                field(Name; Name) { ApplicationArea = All; }
                field(Amount; Amount) { ApplicationArea = All; }
                field("Posted Invoice No."; "Posted Invoice No.") { ApplicationArea = All; }
                field(Error; Error) { ApplicationArea = All; }
                field("Error Message"; "Error Message") { ApplicationArea = All; }
                field(Validated; Validated) { ApplicationArea = All; }
                field("Imported by"; "Imported by") { ApplicationArea = All; }
                field("Imported On"; "Imported On") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Upload list of payments")
            {
                Image = PaymentJournal;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction();
                var
                    ImportfromExcel: Report "Import List of Payment";
                begin
                    ImportfromExcel.RUN;
                    CurrPage.UPDATE(TRUE);
                end;
            }

            action("Validate List")
            {
                Image = CheckList;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction();
                var
                    grecCustomer: Record Customer;
                    gintNumValidated: Integer;
                    RecCount: Integer;
                begin
                    Clear(gintNumValidated);
                    grecUploadedPayments.Reset();
                    grecUploadedPayments.SetCurrentKey("Entry No.");
                    grecUploadedPayments.SetRange("Entry No.");
                    grecUploadedPayments.SetRange("Updated to NAV", false);
                    RecCount := grecUploadedPayments.Count;

                    grecUploadedPayments.Reset();
                    grecUploadedPayments.SetCurrentKey("Entry No.");
                    grecUploadedPayments.SetRange("Entry No.");
                    grecUploadedPayments.SetRange("Updated to NAV", false);
                    grecUploadedPayments.SetRange(Validated, false);
                    if grecUploadedPayments.FindFirst() then begin
                        repeat
                            if not grecCustomer.get(grecUploadedPayments."Student Code") then begin
                                grecUploadedPayments.Error := true;
                                grecUploadedPayments."Error Message" := 'Student does not exist on the customer list of the system.';
                            end else begin
                                grecUploadedPayments."First Name" := grecCustomer."First Name";
                                grecUploadedPayments."Last Name" := grecCustomer."Last Name";
                                grecUploadedPayments.Name := grecCustomer.Name;
                            end;

                            if not grecUploadedPayments.Error then begin
                                grecCustLdgEntry.Reset();
                                grecCustLdgEntry.SetCurrentKey("Entry No.");
                                grecCustLdgEntry.SetRange("Customer No.", grecUploadedPayments."Student Code");
                                grecCustLdgEntry.SetRange(Amount, grecUploadedPayments.Amount);
                                grecCustLdgEntry.SetRange("Document No.", grecUploadedPayments."Posted Invoice No.");
                                if not grecCustLdgEntry.FindFirst() then begin
                                    grecUploadedPayments.Error := true;
                                    grecUploadedPayments."Error Message" := 'The combination of student with this voucher no. and amount does not exist on the system.';
                                end;
                            end;

                            if not grecUploadedPayments.Error then begin
                                grecUploadedPayments.Validated := true;
                                gintNumValidated += 1;
                            end;

                            grecUploadedPayments.Modify();
                        until grecUploadedPayments.Next() = 0;
                        Message('%1 out of %2 lines have been validated.', gintNumValidated, RecCount);
                    end;
                end;
            }



            action("Create Payment Lines")
            {
                Image = Payment;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction();
                var
                    grecGenJnlLine: Record "Gen. Journal Line";
                    grecGenJnlLine2: Record "Gen. Journal Line";
                    grecSalesReceivableSetup: Record "Sales & Receivables Setup";
                    gtextDocNo: Text[20];
                    gintEntryNo: Integer;
                    gintCountEntry: Integer;
                    grecGenJnlBatch: Record "Gen. Journal Batch";
                    Noseriesmgt: Codeunit NoSeriesManagement;
                begin

                    clear(gintCountEntry);
                    grecGenJnlLine2.Reset();
                    grecGenJnlLine2.SetRange("Journal Template Name", JournalTemplateName);
                    grecGenJnlLine2.SetRange("Journal Batch Name", JournalBatchName);
                    if grecGenJnlLine2.Findlast then
                        gintEntryNo += grecGenJnlLine2."Line No." + 10000
                    else
                        gintEntryNo := 10000;

                    grecSalesReceivableSetup.Get();

                    if not grecGenJnlBatch.Get(JournalTemplateName, JournalBatchName) then
                        Clear(grecGenJnlBatch);
                    grecUploadedPayments.Reset();
                    grecUploadedPayments.SetCurrentKey("Entry No.");
                    grecUploadedPayments.SetRange(Validated, true);
                    grecUploadedPayments.SetRange("Updated to NAV", false);
                    if grecUploadedPayments.FindFirst() then begin
                        repeat
                            clear(gtextDocNo);
                            grecGenJnlLine.Init();
                            grecGenJnlLine.validate("Journal Template Name", JournalTemplateName);
                            grecGenJnlLine.validate("Journal Batch Name", JournalBatchName);
                            Clear(NoSeriesMgt);
                            grecGenJnlLine."Document No." := NoSeriesMgt.TryGetNextNo(grecGenJnlBatch."No. Series", WorkDate());
                            grecGenJnlLine.Validate("Document No.");
                            grecGenJnlLine.validate("Line No.", gintEntryNo);
                            grecGenJnlLine.validate("Account Type", grecGenJnlLine."Account Type"::Customer);
                            grecGenJnlLine.validate("Account No.", grecUploadedPayments."Student Code");
                            grecGenJnlLine.validate("Posting Date", grecUploadedPayments."Posting Date");
                            grecGenJnlLine.validate("Document Type", grecGenJnlLine."Document Type"::Payment);
                            grecGenJnlLine.validate(Amount, grecUploadedPayments.Amount * -1);
                            grecGenJnlLine.validate("Bal. Account Type", grecGenJnlBatch."Bal. Account Type");
                            grecGenJnlLine.validate("Bal. Account No.", grecGenJnlBatch."Bal. Account No.");
                            gtextDocNo := grecGenJnlLine."Document No.";
                            grecGenJnlLine.Insert(true);

                            grecCustLdgEntry.Reset();
                            grecCustLdgEntry.SetCurrentKey("Entry No.");
                            grecCustLdgEntry.SetRange("Customer No.", grecUploadedPayments."Student Code");
                            grecCustLdgEntry.SetRange(Amount, grecUploadedPayments.Amount);
                            grecCustLdgEntry.SetRange("Document No.", grecUploadedPayments."Posted Invoice No.");
                            if grecCustLdgEntry.FindFirst() then begin
                                grecCustLdgEntry.validate("Applies-to ID", gtextDocNo);
                                grecCustLdgEntry.validate("Amount to Apply", grecUploadedPayments.Amount);
                                grecCustLdgEntry.Modify(true);
                            end;
                            grecGenJnlLine.validate("Posting Group", grecCustLdgEntry."Customer Posting Group");
                            grecGenJnlLine.Modify();

                            gintEntryNo += 10000;
                            gintCountEntry += 1;
                            grecUploadedPayments."Updated to NAV" := true;
                            grecUploadedPayments.Modify();
                        until grecUploadedPayments.Next() = 0;
                        Message('%1 lines have been created on Template %2 , batch %3.', gintCountEntry, JournalTemplateName, JournalBatchName);
                        CurrPage.Update(true);
                    end;
                end;
            }

            action("Delete Lines")
            {
                Image = Delete;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction();
                begin
                    If Confirm('Do you want to delete all the lines?', true) then begin
                        grecUploadedPayments.DeleteAll();
                        Message('All lines have been cleared.');
                    end;
                end;
            }

            /*
            action("Cash Receipt Journal")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = CashReceiptJournal;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    grecGenJnlBatch: Record "Gen. Journal Batch";
                    gpageGenJnlBatch: Page 256;
                    grecSalesReceivableSetup: Record "Sales & Receivables Setup";
                begin
                    grecSalesReceivableSetup.Get;
                    grecGenJnlBatch.Reset();
                    grecGenJnlBatch.SetRange("Journal Template Name", 'CASH RECE');
                    grecGenJnlBatch.SetRange(Name, grecSalesReceivableSetup."Upload Customer Payments");
                    if grecGenJnlBatch.FindSet then begin
                        Page.Run(251, grecGenJnlBatch);
                    end;
                end;            
            }
            */
        }
    }
    procedure SetJournal(JnlTemplate: Code[10]; JnlBatch: Code[10])
    var
        myInt: Integer;
    begin
        JournalTemplateName := JnlTemplate;
        JournalBatchName := JnlBatch;
    end;

    var
        grecUploadedPayments: Record "List of Uploaded Payments";
        grecCustLdgEntry: Record "Cust. Ledger Entry";

        JournalTemplateName: Code[10];
        JournalBatchName: Code[10];
}