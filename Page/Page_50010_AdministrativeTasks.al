page 50010 "Adminstrative Tasks"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Permissions = tabledata "Sales Invoice Header" = rim, tabledata "Accounting Period" = rim;


    layout
    {
        area(Content)
        {
            group("Filter")
            {
                field("Posted Sales Invoice No."; gtextDocNo)
                {
                    ApplicationArea = All;
                }
                field("Bank Account Ledger Document No."; gtextDocNo2)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Update Payment terms Code - Customer")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    grecCustomer: Record Customer;
                begin
                    grecCustomer.Reset();
                    grecCustomer.SetRange("No.");
                    if grecCustomer.FindSet then begin
                        repeat
                            grecCustomer."Payment Terms Code" := '30D';
                            grecCustomer.Modify();
                        until grecCustomer.Next = 0;
                        Message('Payment Terms Code updated for all customers.');
                    end;
                end;
            }


            action("Update Payment terms Code - Vendor")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    grecVendor: Record Vendor;
                begin
                    grecVendor.Reset();
                    grecVendor.SetRange("No.");
                    if grecVendor.FindSet then begin
                        repeat
                            grecVendor."Payment Terms Code" := '30D';
                            grecVendor.Modify();
                        until grecVendor.Next = 0;
                        Message('Payment Terms Code updated for all vendors.');
                    end;
                end;
            }


            action("Update Global Dimension - HO")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    grecGLEntry: Record "G/L Entry";
                    grecCustLedgEntry: Record "Cust. Ledger Entry";
                    grecDetailedCustLedgerEntry: Record "Detailed Cust. Ledg. Entry";
                    grecBankAccLedgEntry: Record "Bank Account Ledger Entry";
                begin
                    grecGLEntry.Reset();
                    grecGLEntry.SetFilter("Document No.", gtextDocNo);
                    grecGLEntry.ModifyAll("Global Dimension 2 Code", 'HO');

                    grecCustLedgEntry.Reset();
                    grecCustLedgEntry.SetFilter("Document No.", gtextDocNo);
                    grecCustLedgEntry.ModifyAll("Global Dimension 2 Code", 'HO');

                    grecDetailedCustLedgerEntry.Reset();
                    grecDetailedCustLedgerEntry.SetFilter("Document No.", gtextDocNo);
                    grecDetailedCustLedgerEntry.ModifyAll("Initial Entry Global Dim. 2", 'HO');

                    grecBankAccLedgEntry.Reset();
                    grecBankAccLedgEntry.SetFilter("Document No.", gtextDocNo);
                    grecBankAccLedgEntry.ModifyAll("Global Dimension 2 Code", 'HO');

                    Message('Global Dimension 2 code has been updated.');
                end;
            }


            action("Update Global Dimension - MEMBER SUBSCRIP")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    grecGLEntry: Record "G/L Entry";
                    grecCustLedgEntry: Record "Cust. Ledger Entry";
                    grecDetailedCustLedgerEntry: Record "Detailed Cust. Ledg. Entry";
                    grecBankAccLedgEntry: Record "Bank Account Ledger Entry";
                begin
                    grecGLEntry.Reset();
                    grecGLEntry.SetFilter("Document No.", gtextDocNo);
                    grecGLEntry.ModifyAll("Global Dimension 2 Code", 'MEMBER SUBSCRIP');

                    grecCustLedgEntry.Reset();
                    grecCustLedgEntry.SetFilter("Document No.", gtextDocNo);
                    grecCustLedgEntry.ModifyAll("Global Dimension 2 Code", 'MEMBER SUBSCRIP');

                    grecDetailedCustLedgerEntry.Reset();
                    grecDetailedCustLedgerEntry.SetFilter("Document No.", gtextDocNo);
                    grecDetailedCustLedgerEntry.ModifyAll("Initial Entry Global Dim. 2", 'MEMBER SUBSCRIP');

                    grecBankAccLedgEntry.Reset();
                    grecBankAccLedgEntry.SetFilter("Document No.", gtextDocNo);
                    grecBankAccLedgEntry.ModifyAll("Global Dimension 2 Code", 'MEMBER SUBSCRIP');

                    Message('Global Dimension 2 code has been updated.');
                end;
            }


            action("Clear Cancelled Info")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    grecPurchHdrArchives: Record "Purchase Header Archive";
                begin
                    grecPurchHdrArchives.Reset();
                    grecPurchHdrArchives.SetRange("No.");
                    if grecPurchHdrArchives.FindFirst() then begin
                        grecPurchHdrArchives.ModifyAll("Cancelled By", '');
                        grecPurchHdrArchives.ModifyAll("Date Cancelled", 0D);
                        grecPurchHdrArchives.ModifyAll("Time Cancelled", 0T);
                    end;
                    Message('Done.');
                end;
            }

            action("Accounting Periods Admin")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = AccountingPeriods;

                trigger OnAction()
                var
                    gpageAccPeriodAdmin: Page "Accounting Periods Admin";
                begin
                    gpageAccPeriodAdmin.Run();
                end;
            }

            action("Payment Journal Admin")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = PaymentJournal;

                trigger OnAction()
                var
                    gpagePaymentJnlAdmin: Page "Payment Journal Admin";
                begin
                    gpagePaymentJnlAdmin.Run();
                end;
            }

            action("Clear No. Printed on Posted Sales Invoices")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = ClearLog;

                trigger OnAction()
                var
                    grecSalesInvHdr: Record "Sales Invoice Header";
                begin
                    if Confirm('Do you want to proceed with deletion?', true) then begin
                        grecSalesInvHdr.Reset();
                        grecSalesInvHdr.SetCurrentKey("No.");
                        grecSalesInvHdr.SetFilter("No.", gtextDocNo);
                        if grecSalesInvHdr.FindSet then begin
                            repeat
                                grecSalesInvHdr."No. Printed" := 0;
                                grecSalesInvHdr.Modify;
                            until grecSalesInvHdr.Next = 0;
                            Message('Field "No. Printed" has been cleared on the posted sales invoices.');
                        end;
                    end;
                end;
            }

            action("Clear OR No. Printed from Bank Account Ledger")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = ClearLog;

                trigger OnAction()
                var
                    grecBankAccLedgerEntry: Record "Bank Account Ledger Entry";
                begin
                    if Confirm('Do you want to proceed with deletion?', true) then begin
                        grecBankAccLedgerEntry.Reset();
                        grecBankAccLedgerEntry.SetCurrentKey("Entry No.");
                        if gtextDocNo2 <> '' then
                            grecBankAccLedgerEntry.SetFilter("Entry No.", gtextDocNo);
                        if grecBankAccLedgerEntry.FindSet then begin
                            repeat
                                grecBankAccLedgerEntry."OR No. Printed" := 0;
                                grecBankAccLedgerEntry.Modify;
                            until grecBankAccLedgerEntry.Next = 0;
                            Message('Field OR No. Printed has been cleared from Bank Account Ledger for Document No. %1', gtextDocNo2);
                        end;
                    end;
                end;
            }
            action("Insert VAT for Item not Module")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = VATLedger;

                trigger OnAction()
                begin
                    grecItem.Reset();
                    grecItem.SetRange("No.");
                    grecItem.SetRange(Module, false);
                    if grecItem.FindSet() then begin
                        grecItem.ModifyAll("VAT Prod. Posting Group", 'VAT');
                        Message('Update done.');
                    end;
                end;
            }

            action("Update Vendor")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Vendor;

                trigger OnAction()
                var
                    grecVendor: Record Vendor;
                begin
                    grecVendor.Reset();
                    grecVendor.SetRange("No.");
                    if grecVendor.FindFirst() then
                        grecVendor.ModifyAll("Prices Including VAT", true);
                    Message('Done');
                end;
            }
        }
    }

    var
        gtextDocNo: Text[250];
        gtextDocNo2: Text[250];
        grecItem: Record Item;
}
