pageextension 50006 CustomerList extends "Customer List"
{
    layout
    {
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Country/Region Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Payment Terms Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Currency Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(Contact)
        {
            Visible = false;
        }
        modify("Search Name")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Credit Limit (LCY)")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(Blocked)
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Balance Due (LCY)")
        {
            Visible = false;
        }
        modify("Balance (LCY)")
        {
            Visible = false;
        }
        modify("Sales (LCY)")
        {
            Visible = false;
        }
        modify("Payments (LCY)")
        {
            Visible = false;
        }
        modify("Customer Posting Group")
        {
            Visible = true;
            ApplicationArea = All;
        }
        /* addafter(Blocked)
        {
            field(Balance; Rec.Balance)
            {
                Editable = false;
            }
        } */
        addafter("VAT Bus. Posting Group")
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                Editable = false;

            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                Visible = false;
                Editable = false;
            }
        }
        addlast(Control1)
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
            }
            field(BRN; Rec.BRN)
            {
                ApplicationArea = All;
            }
            /* field("MRU Post Code"; Rec."Shipment Method Code")
            {
                Caption = 'MRU Post Code';
                ApplicationArea = All;
            } */
            field("Customer Category"; "Customer Category")
            {
                ApplicationArea = All;
            }
            field("First Name"; "First Name")
            {
                ApplicationArea = All;
            }
            field("Maiden Name"; "Maiden Name")
            {
                ApplicationArea = All;
            }
            field("Last Name"; "Last Name")
            {
                ApplicationArea = All;
            }
            field("Date Created"; "Date Created") { ApplicationArea = All; }
            field("Created By"; "Created By") { ApplicationArea = All; }
        }
        addafter("Credit Limit (LCY)")
        {
            field("Balance(LCY)"; "Balance (LCY)")
            {
                ApplicationArea = all;
            }
        }
    }
}