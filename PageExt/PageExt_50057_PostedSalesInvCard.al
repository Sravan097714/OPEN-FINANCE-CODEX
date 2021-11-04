pageextension 50057 PostedSalesInvCardExt extends "Posted Sales Invoice"
{
    layout
    {
        modify("Quote No.")
        {
            Visible = false;
        }
        modify("Work Description")
        {
            Visible = false;
        }
        addafter("Sell-to Customer Name")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify(Closed)
        {
            Visible = false;
        }
        modify(Corrective)
        {
            Visible = false;
        }
        modify("External Document No.")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            Visible = false;
        }
        modify("Direct Debit Mandate ID")
        {
            Visible = false;
        }
        modify("Payment Discount %")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Shipping Details")
        {
            Visible = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        modify(SelectedPayments)
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Shipping and Billing")
        {
            Caption = 'Billing';
            Visible = true;
        }
        modify("Sell-to County")
        {
            Visible = false;
        }
        modify("Sell-to Contact No.")
        {
            Visible = false;
        }
        modify("Sell-to Country/Region Code")
        {
            Visible = true;
        }
        modify("Ship-to")
        {
            Visible = false;
        }
        modify("Bill-to County")
        {
            Visible = false;
        }
        modify("Bill-to Contact No.")
        {
            Visible = false;
        }
        modify("Bill-to Country/Region Code")
        {
            Visible = true;
        }

        addafter("Shortcut Dimension 2 Code")
        {
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            field("Created By"; Rec."Created By")
            {
                ApplicationArea = All;
            }
            field("User ID"; "User ID")
            {
                ApplicationArea = All;
            }
            field(Amount; Amount)
            {
                ApplicationArea = All;
            }
            field("Amount Including VAT"; "Amount Including VAT")
            {
                ApplicationArea = All;
            }
            field("Customer Posting Group"; "Customer Posting Group") { ApplicationArea = All; }
            field("From OU Portal"; "From OU Portal")
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
            field("Gov Grant"; "Gov Grant") { ApplicationArea = All; }
            field(Instalment; Instalment) { ApplicationArea = All; }
            field("Portal Payment Mode"; "Portal Payment Mode") { ApplicationArea = All; }
            field("MyT Money Ref"; "MyT Money Ref") { ApplicationArea = All; }
            field("Payment Amount"; "Payment Amount") { ApplicationArea = All; }
            field("Payment Date"; "Payment Date") { ApplicationArea = All; }
            field(Remark; Remark) { ApplicationArea = All; }
        }
    }

    trigger OnOpenPage();
    begin
        CurrPage.EDITABLE(FALSE);
    end;
}