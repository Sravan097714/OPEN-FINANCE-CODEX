pageextension 50076 VendorLedgerEntries extends "Vendor Ledger Entries"
{
    layout
    {
        modify("Message to Recipient")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("Global Dimension 1 Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Global Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Payment Reference")
        {
            Visible = false;
        }
        modify("Original Amt. (LCY)")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(Amount)
        {
            Visible = false;
        }
        modify("Amount (LCY)")
        {
            Visible = false;
        }
        modify("Debit Amount")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Debit Amount (LCY)")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Credit Amount")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Credit Amount (LCY)")
        {
            Visible = true;
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
        modify("Pmt. Disc. Tolerance Date")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Original Pmt. Disc. Possible")
        {
            Visible = false;
        }
        modify("Remaining Pmt. Disc. Possible")
        {
            Visible = false;
        }
        modify("Max. Payment Tolerance")
        {
            Visible = false;
        }
        modify("On Hold")
        {
            Visible = false;
        }
        modify("Exported to Payment File")
        {
            Visible = false;
        }

        addlast(Control1)
        {
            field("Vendor Posting Group"; Rec."Vendor Posting Group")
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
            field("Created By"; "Created By")
            {
                ApplicationArea = All;
            }
            field("TDS Code"; "TDS Code") { ApplicationArea = All; }
            field(VAT; VAT) { ApplicationArea = All; }
            field("Retention Fee"; "Retention Fee") { ApplicationArea = All; }
            field(Payee; Payee) { ApplicationArea = All; }
            field("Vendor Category"; "Vendor Category") { ApplicationArea = All; }
            field("Vendor Type"; "Vendor Type") { ApplicationArea = All; }
            field("Payment Journal No."; "Payment Journal No.") { ApplicationArea = All; }
        }
    }
}