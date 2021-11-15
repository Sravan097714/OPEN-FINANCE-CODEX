page 50030 "Uploads from OU Portal"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    actions
    {
        area(Processing)
        {
            action("Upload Application Fees")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = ImportExcel;

                trigger OnAction()
                begin
                    Report.Run(50031);
                end;
            }

            action("Upload Module Fees")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = ImportExcel;

                trigger OnAction()
                begin
                    Page.Run(50018);
                end;
            }

            action("Upload Re-Registration Fees")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = ImportExcel;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Page.Run(50021);
                end;
            }

            action("Upload Application Submission")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = ImportExcel;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Page.Run(50056);
                end;
            }

            action("Upload Exemption Fees")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = ImportExcel;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Page.Run(50058);
                end;
            }

            action("Upload Resit Fees")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = ImportExcel;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Page.Run(50059);
                end;
            }
        }


        area(Navigation)
        {
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
                    grecGenJnlBatch.SetRange(Name, grecSalesReceivableSetup."Journal Batch Name OU Portal");
                    if grecGenJnlBatch.FindSet then begin
                        Page.Run(251, grecGenJnlBatch);
                    end;
                end;
            }

            action("Sales Invoices from OU Portal")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = SalesInvoice;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Page.Run(50019);
                end;
            }
        }
    }
}