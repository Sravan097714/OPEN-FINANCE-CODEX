pageextension 50129 AccountantRoleCenterExt extends "Accountant Role Center"
{
    layout
    {
    }

    actions
    {
        modify(SetupAndExtensions)
        {
            Visible = false;
        }
        modify(Action84)
        {
            Visible = false;
        }
        //movebefore(Inventory;fixed)

        addbefore(SetupAndExtensions)
        {
            group("Accounts Receivable")
            {
                action("Customer List")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer List";
                }
            }

            group("Accounts Payable")
            {
                action("Vendor List")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor List";
                }
            }

            group(Inventory)
            {
                action("Item List")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item List";
                }
            }

            group(Procurement)
            {
                action("Vendor List ")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor List";
                }
            }

            group("OU Portal")
            {
                action("Customer List ")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer List";
                }
            }

            group("General Ledger Reports")
            {
                action("Trial Balance")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = report "Trial Balance";
                }
            }

            group("Cash Management Reports")
            {
                action("Bank Reconciliation Report")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = report "Bank Reconciliation Report";
                }
            }

            group("Fixed Assets Reports")
            {
                action("Fixed Asset Register")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = report "Fixed Asset Register";
                }
            }

            group("Accounts Payable Reports")
            {
                action("Aged Accounts Payable")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = report "Aged Accounts Payable";
                }
            }

            group("Accounts Receivable Reports")
            {
                action("Aged Receivable Payable")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = report "Aged Accounts Receivable";
                }
            }

            group("Inventory Reports")
            {
                action("Stock Reorder Level")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = report "Stock Reorder Level";
                }
            }

            group("Procurement Reports")
            {
                action("Suppliers Appraisal ")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = report "Supplier's Appraisal";
                }
            }

            group(Administration)
            {
                action("Dimensions ")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Dimension List";
                }
            }

            group("Posted Sales Document")
            {
                action("Posted Sales Invoice")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Posted Sales Invoice";
                }
            }

            group("Posted Purchase Document")
            {
                action("Posted Purchase Invoice")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Posted Purchase Invoice";
                }
            }


            group("Posted Inventory")
            {
                action("Value Entries")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Value Entries";
                }
            }
        }
    }

    var
        myInt: Integer;
}