Pageextension 50060 PostedSalesCrMemoCardExt extends "Posted Sales Credit Memo"
{
    layout
    {
        modify("Sell-to Country/Region Code")
        {
            Visible = false;
        }
        modify("External Document No.")
        {
            Visible = false;
        }
        addafter("Sell-to Customer Name")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                Editable = false;
            }
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Work Description")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                Editable = false;
            }
        }
        modify("Salesperson Code")
        {
            Visible = false;
        }

        modify(Cancelled)
        {
            Visible = false;
        }
        modify(Corrective)
        {
            Visible = false;
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Bill-to")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Shipping and Billing")
        {
            Visible = false;
        }

        addlast(General)
        {
            field("User ID"; Rec."User ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
            }
            field("Customer Posting Group"; "Customer Posting Group") { ApplicationArea = All; }
            field("Created By"; Rec."Created By")
            {
                ApplicationArea = All;
            }
            field("First Name"; "First Name") { ApplicationArea = All; }
            field("Last Name"; "Last Name") { ApplicationArea = All; }
            field("Middle Name"; "Middle Name") { ApplicationArea = All; }
            field(RDAP; RDAP) { ApplicationArea = All; }
            field(RDBL; RDBL) { ApplicationArea = All; }
            field(PTN; PTN) { ApplicationArea = All; }
            field("Payment Semester"; "Payment Semester") { ApplicationArea = All; }
            field(NIC; NIC) { ApplicationArea = All; }
            field("Login Email"; "Login Email") { ApplicationArea = All; }
            field("Contact Email"; "Contact Email") { ApplicationArea = All; }
            field("Our Ref"; "Our Ref") { ApplicationArea = All; }
            field("Your Ref"; "Your Ref") { ApplicationArea = All; }
        }
    }
    trigger OnOpenPage();
    begin
        CurrPage.EDITABLE(FALSE);
    end;

}