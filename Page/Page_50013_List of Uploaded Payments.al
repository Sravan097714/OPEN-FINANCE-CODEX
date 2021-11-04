page 50013 "List of Uploaded Payments"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "List of Uploaded Payments";

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
                field("Voucher No."; "Voucher No.") { ApplicationArea = All; }
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
                begin
                    Clear(gintNumValidated);
                    grecUploadedPayments.Reset();
                    grecUploadedPayments.SetCurrentKey("Entry No.");
                    grecUploadedPayments.SetRange("Entry No.");
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
                                grecCustLdgEntry.SetRange("Document No.", grecUploadedPayments."Voucher No.");
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
                        Message('%1 out of %2 lines have been validated.', gintNumValidated, grecUploadedPayments.Count);
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
                begin
                    grecUploadedPayments.Reset();
                    grecUploadedPayments.SetCurrentKey("Entry No.");
                    grecUploadedPayments.SetRange(Validated, true);
                    if grecUploadedPayments.FindFirst() then begin
                        grecSalesReceivableSetup.Get();

                        clear(gintCountEntry);
                        grecGenJnlLine2.Reset();
                        grecGenJnlLine2.SetRange("Journal Template Name", 'CASH RECE');
                        grecGenJnlLine2.SetRange("Journal Batch Name", grecSalesReceivableSetup."Upload Customer Payments");
                        if grecGenJnlLine2.Findlast then
                            gintEntryNo += grecGenJnlLine2."Line No." + 10000
                        else
                            gintEntryNo := 10000;

                        repeat
                            clear(gtextDocNo);
                            grecGenJnlLine.Init();
                            grecGenJnlLine.validate("Line No.", gintEntryNo);
                            grecGenJnlLine.validate("Journal Template Name", 'CASH RECE');
                            grecGenJnlLine.validate("Journal Batch Name", grecSalesReceivableSetup."Upload Customer Payments");
                            grecGenJnlLine.validate("Account Type", grecGenJnlLine."Account Type"::Customer);
                            grecGenJnlLine.validate("Account No.", grecUploadedPayments."Student Code");
                            grecGenJnlLine.validate("Posting Date", grecUploadedPayments."Posting Date");
                            grecGenJnlLine.validate("Document Type", grecGenJnlLine."Document Type"::Payment);
                            grecGenJnlLine.validate("Document No.", grecUploadedPayments."Voucher No.");
                            grecGenJnlLine.validate(Amount, grecUploadedPayments.Amount * -1);

                            grecGenJnlBatch.Reset();
                            grecGenJnlBatch.SetRange("Journal Template Name", 'CASH RECE');
                            grecGenJnlBatch.SetRange(Name, grecSalesReceivableSetup."Upload Customer Payments");
                            if grecGenJnlBatch.FindFirst() then begin
                                grecGenJnlLine."Bal. Account Type" := grecGenJnlBatch."Bal. Account Type";
                                grecGenJnlLine."Bal. Account No." := grecGenJnlBatch."Bal. Account No.";
                            end;

                            gtextDocNo := grecGenJnlLine."Document No.";
                            grecGenJnlLine.Insert(true);

                            grecCustLdgEntry.Reset();
                            grecCustLdgEntry.SetCurrentKey("Entry No.");
                            grecCustLdgEntry.SetRange("Customer No.", grecUploadedPayments."Student Code");
                            grecCustLdgEntry.SetRange(Amount, grecUploadedPayments.Amount);
                            grecCustLdgEntry.SetRange("Document No.", grecUploadedPayments."Voucher No.");
                            if grecCustLdgEntry.FindFirst() then begin
                                grecCustLdgEntry."Applies-to ID" := gtextDocNo;
                                grecCustLdgEntry."Amount to Apply" := grecUploadedPayments.Amount;
                                grecCustLdgEntry.Modify(true);
                            end;
                            gintEntryNo += 10000;
                            gintCountEntry += 1;
                        until grecUploadedPayments.Next() = 0;
                        Message('%1 lines have been created on Cash Receipt Journal, batch %2.', gintCountEntry, grecSalesReceivableSetup."Upload Customer Payments");
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
        }
    }

    var
        grecUploadedPayments: Record "List of Uploaded Payments";
        grecCustLdgEntry: Record "Cust. Ledger Entry";
}