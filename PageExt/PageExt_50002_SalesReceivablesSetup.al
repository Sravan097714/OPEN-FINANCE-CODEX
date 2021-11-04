pageextension 50002 SalesReceivablesSetup extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(General)
        {
            field("Doc. Posting Date as WORKDATE"; rec."Doc. Posting Date as WORKDATE")
            {
                ApplicationArea = All;
            }
            field("Use Available Inventory Only"; rec."Use Available Inventory Only")
            {
                ApplicationArea = All;
            }
            field("Upload Customer Payments"; "Upload Customer Payments")
            {
                ApplicationArea = All;
            }
            field("VAT Product on OU Sales App"; "VAT Product on OU Sales App")
            {
                ApplicationArea = All;
            }
            field("Sales Invoice Signature Name"; "Sales Invoice Signature Name") { ApplicationArea = All; }
            field("Sign for Statement of Accounts"; "Sign for Statement of Accounts") { ApplicationArea = All; }
            field("Sign for Reminders"; "Sign for Reminders") { ApplicationArea = All; }
            field("Post Cash Receipts today"; "Post Cash Receipts today") { ApplicationArea = All; }
        }

        addlast(content)
        {
            group("Application Fee OU Portal")
            {
                field("Journal Batch Name OU Portal"; "Journal Batch Name OU Portal")
                {
                    ApplicationArea = All;
                }
                field("G/L Acc. for App Reg OU Portal"; "G/L Acc. for App Reg OU Portal")
                {
                    ApplicationArea = All;
                }
                field("Bank Acc. for Bank OU Portal"; "Bank Acc. No. for OU Portal")
                {
                    ApplicationArea = All;
                }
                field("No. Series for OU Portal"; "No. Series for OU Portal")
                {
                    ApplicationArea = All;
                }
            }

            group("Module Fee OU Portal")
            {
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    ApplicationArea = All;
                }
            }

            group("Re-registration Fee OU Portal")
            {
                field("G/L for Penalty Fee"; "G/L for Penalty Fee")
                {
                    ApplicationArea = All;
                }
            }

            group("Exemption Fee OU Portal")
            {
                field("G/L for Exemption Fee"; "G/L for Exemption Fee")
                {
                    ApplicationArea = All;
                }
                field("Exemption Amount"; "Exemption Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
        addlast("Number Series")
        {
            field("Posted Inv Nos. for OU Portal"; "Posted Inv Nos. for OU Portal")
            {
                ApplicationArea = All;
            }
            field("Bank Standing Order Nos."; "Bank Standing Order Nos.")
            {
                ApplicationArea = All;
            }
        }
    }
}