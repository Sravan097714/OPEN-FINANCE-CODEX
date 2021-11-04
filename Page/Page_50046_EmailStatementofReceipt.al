page 50046 "Email Statement of Receipt"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            group("")
            {
                field("Date Filter"; gdateDateFilter) { ApplicationArea = All; }
            }
            repeater(GroupName)
            {
                field(Name; Name) { ApplicationArea = All; }
                field("E-Mail"; "E-Mail") { ApplicationArea = All; }
                field(Email; Email) { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Select All")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction();
                begin
                    grecCustomer.ModifyAll(Email, true);
                end;
            }
            action("Unselect All")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction();
                begin
                    grecCustomer.ModifyAll(Email, false);
                end;
            }
            action("Email Statement")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction();
                begin
                    if gdateDateFilter = 0D then
                        Error('Please insert date filter.');

                    grecCustomer.reset;
                    grecCustomer.SetRange(Email, true);
                    if grecCustomer.Count = 0 then
                        Error('Please select lines for emailing.');

                    if Confirm('System will email Statement of Receipts for lines selected. Do you want to proceed?', true) then begin
                        clear(gintCounter);
                        grecCustomer.reset;
                        grecCustomer.SetRange(Email, true);
                        if grecCustomer.FindFirst() then begin
                            repeat

                                gintCounter += 1;
                            until grecCustomer.Next = 0;
                            Message('%1 documents have been emailed.', gintCounter);
                        end;
                    end;
                end;
            }

            action("Preview statement of Receipt")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    grecCustomer.reset;
                    grecCustomer.SetRange(Email, true);
                    grecCustomer.SetAscending("No.", true);
                    if grecCustomer.FindSet then begin
                        repeat
                            if gtextCustomerNo <> grecCustomer."No." then begin
                                if gtextCustFilter = '' then
                                    gtextCustFilter := grecCustomer."No."
                                else
                                    gtextCustFilter += '|' + grecCustomer."No.";
                            end;
                        until grecCustomer.Next = 0;
                    end;

                    grecCustLedgerEntries.Reset();
                    grecCustLedgerEntries.SetFilter("Customer No.", gtextCustFilter);
                    if grecCustLedgerEntries.FindSet then begin
                        Clear(grepStatementofReceipt);
                        grepStatementofReceipt.SetTableView(grecCustLedgerEntries);
                        grepStatementofReceipt.SetDateFilter(gdateDateFilter);
                        grepStatementofReceipt.UseRequestPage(false);
                        grepStatementofReceipt.Run();
                    end;
                end;
            }
        }
    }

    var
        grecCustomer: Record Customer;
        gdateDateFilter: Date;
        gintCounter: Integer;
        grepStatementofReceipt: Report "Statement of Receipts";
        grecCustLedgerEntries: Record "Cust. Ledger Entry";
        gtextCustFilter: Text;
        gtextCustomerNo: Text;
}