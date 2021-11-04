pageextension 50026 PurchCrMemoCardExt extends "Purchase Credit Memo"
{
    layout
    {
        modify("Buy-from Country/Region Code")
        {
            Visible = false;
        }
        modify("Document Date")
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Purchaser Code")
        {
            Visible = false;
        }
        modify("Expected Receipt Date")
        {
            Visible = false;
        }
        modify("Vendor Authorization No.")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Buy-from Contact No.")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Shipping and Payment")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Payment Terms Code")
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
        modify("Pay-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Posting Description")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        addafter("Vendor Cr. Memo No.")
        {
            field("Vendor Posting Group"; Rec."Vendor Posting Group")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            field("Created By"; Rec."Created By")
            {
                ApplicationArea = All;
            }
            field(BRN; BRN) { ApplicationArea = All; }
        }
        addlast(FactBoxes)
        {
            part("Purchase Line Details"; 9100)
            {
                ApplicationArea = All;
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = true;
            }
        }
    }
}