pageextension 50075 BankAccLedgerEntries extends "Bank Account Ledger Entries"
{
    layout
    {
        modify("User ID")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Global Dimension 1 Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Global Dimension 2 Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Dimension Set ID")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Remaining Amount")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Amount (LCY)")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Bal. Account No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Bal. Account Type")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Currency Code")
        {
            Visible = true;
        }
        modify("Source Code")
        {
            Visible = true;
        }

        addlast(Control1)
        {
            field("Bank Acc. Posting Group"; "Bank Acc. Posting Group") { ApplicationArea = All; }
            field(Positive; Rec.Positive)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Statement Status"; Rec."Statement Status")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Statement No."; Rec."Statement No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Statement Line No."; Rec."Statement Line No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Check Ledger Entries"; Rec."Check Ledger Entries")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("External Document No."; Rec."External Document No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("PV Number"; Rec."PV Number")
            {
                ApplicationArea = All;
            }
            field("Payment Type"; "Payment Type")
            {
                ApplicationArea = All;
            }
            field("OR No. Printed"; "OR No. Printed") { ApplicationArea = All; }
            field("TDS Code"; "TDS Code") { ApplicationArea = All; }
            field(VAT; VAT) { ApplicationArea = All; }
            field("Retention Fee"; "Retention Fee") { ApplicationArea = All; }

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
            field(Payee; Payee) { ApplicationArea = All; }
            field("Vendor Type"; "Vendor Type") { ApplicationArea = All; }
            field("Payment Method Code"; "Payment Method Code") { ApplicationArea = All; }
            field("Payment Journal No."; "Payment Journal No.") { ApplicationArea = All; }
            field(ReceiptPaymentRep; ReceiptPaymentRep) { ApplicationArea = All; }
            field("Vendor Category"; "Vendor Category") { ApplicationArea = All; }
        }
        addafter(Description)
        {
            field("Payee Name"; "Payee Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addbefore(Amount)
        {
            field("Amount Tendered"; "Amount Tendered")
            {
                ApplicationArea = all;
            }
        }
        addafter(Amount)
        {
            field("Amount to Remit"; "Amount to Remit")
            {
                ApplicationArea = all;
            }
        }
    }
}