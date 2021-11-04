pageextension 50079 GeneralLedgerEntries extends "General Ledger Entries"
{
    layout
    {
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
        modify("Debit Amount")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Credit Amount")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("VAT Amount")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("User ID")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Source Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Dimension Set ID")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("G/L Account Name")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(Quantity)
        {
            Visible = true;
            ApplicationArea = All;
        }
        moveafter("G/L Account No."; "G/L Account Name")

        addafter("Source Code")
        {
            field("Source Type"; "Source Type") { ApplicationArea = All; }
            field("Source No."; "Source No.") { ApplicationArea = All; }
        }

        addlast(Control1)
        {
            field("Creation Date"; Rec."Creation Date")
            {
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
            field("Requested By"; "Requested By")
            {
                ApplicationArea = All;
            }
            field("Created By"; "Created By")
            {
                ApplicationArea = All;
            }

            field("Original PO Number"; "Original PO Number") { ApplicationArea = All; }

            field("TDS Code"; "TDS Code") { ApplicationArea = All; }
            field(VAT; VAT) { ApplicationArea = All; }
            field("Retention Fee"; "Retention Fee") { ApplicationArea = All; }

            field("Student ID"; "Student ID") { ApplicationArea = All; }
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

            field("Earmark ID"; "Earmark ID") { ApplicationArea = All; }
            field(Earmarked; Earmarked) { ApplicationArea = All; }
            field("Date Earmarked"; "Date Earmarked") { ApplicationArea = All; }
            field("Amount Earmarked"; "Amount Earmarked") { ApplicationArea = All; }

            field("Payment Journal No."; "Payment Journal No.") { ApplicationArea = All; }
            field(ReceiptPaymentRep; ReceiptPaymentRep) { ApplicationArea = All; }
            field("Vendor Category"; "Vendor Category") { ApplicationArea = All; }
            field("From OU Portal"; "From OU Portal") { ApplicationArea = All; }
            field("FA Revaluation"; "FA Revaluation") { ApplicationArea = All; }

            field("Account Category"; "Account Category") { ApplicationArea = All; }
        }

        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
            }
            field("Payee Name"; "Payee Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
}