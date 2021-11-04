pageextension 50069 CustomerLedgerEntries extends "Customer Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        modify("Message to Recipient")
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
            Visible = true;
            ApplicationArea = All;
        }
        modify("Salesperson Code")
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
        modify("Bal. Account Type")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Bal. Account No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Pmt. Disc. Tolerance Date")
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
        modify("Payment Method Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("On Hold")
        {
            Visible = false;
        }
        modify("Exported to Payment File")
        {
            Visible = false;
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
        modify("Reason Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(Reversed)
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Reversed by Entry No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Reversed Entry No.")
        {
            Visible = true;
            ApplicationArea = All;

        }
        modify("Dimension Set ID")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("External Document No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        addlast(Control1)
        {
            field("Customer Posting Group"; Rec."Customer Posting Group")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Created By"; "Created By")
            {
                ApplicationArea = All;
            }
            field("Customer Category"; "Customer Category")
            {
                ApplicationArea = All;
            }
            field("From OU Portal"; "From OU Portal")
            {
                ApplicationArea = All;
            }
        }
    }
}