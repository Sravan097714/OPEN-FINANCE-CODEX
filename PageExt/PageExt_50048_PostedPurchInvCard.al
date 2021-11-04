pageextension 50048 PostedPurchInvCardExt extends "Posted Purchase Invoice"
{
    layout
    {
        modify("Buy-from Country/Region Code")
        {
            Visible = false;
        }
        modify("Quote No.")
        {
            Visible = false;
        }
        modify("Buy-from Contact No.")
        {
            Visible = false;
        }
        modify("Buy-from County")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify(Cancelled)
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Vendor Order No.")
        {
            Visible = false;
        }
        modify("No. Printed")
        {
            Visible = false;
        }

        modify("Purchaser Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify(Corrective)
        {
            Visible = false;
        }
        modify("Expected Receipt Date")
        {
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            Visible = false;
        }
        modify("Payment Method Code")
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
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        modify("Payment Reference")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("Shipping and Payment")
        {
            Visible = false;
        }
        addafter("Currency Code")
        {
            field("Prices Including VAT"; Rec."Prices Including VAT")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Buy-from Vendor Name")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                Visible = true;
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
            field("Released By"; Rec."Released By")
            {
                ApplicationArea = All;
            }
            field("Date Time Released"; Rec."Date Time Released")
            {
                ApplicationArea = All;
            }
            field("Reopened By"; Rec."Reopened By")
            {
                ApplicationArea = All;
            }
            field("Date Time Reopened"; Rec."Date Time Reopened")
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
            field("PO Category"; "PO Category")
            {
                ApplicationArea = All;
            }
            field("Procurement Method"; "Procurement Method")
            {
                ApplicationArea = All;
            }
            field("Category of Successful Bidder"; "Category of Successful Bidder")
            {
                ApplicationArea = All;
            }
            field(Price; Price) { ApplicationArea = All; }
            field(Quality; Quality) { ApplicationArea = All; }
            field(Responsiveness; Responsiveness) { ApplicationArea = All; }
            field(Delivery; Delivery) { ApplicationArea = All; }
            field("Vendor Posting Group"; "Vendor Posting Group") { ApplicationArea = All; }

            field("Procurement Reference No."; "Procurement Reference No.") { ApplicationArea = All; }
            field("Updated Estimated Cost (Rs)"; "Updated Estimated Cost (Rs)") { ApplicationArea = All; }
            field("Date Bidding Document Issued"; "Date Bidding Document Issued") { ApplicationArea = All; }
            field("Closing Date of Bids"; "Closing Date of Bids") { ApplicationArea = All; }
            field("Bidders Invited"; "Bidders Invited") { ApplicationArea = All; }
            field("No of SMEs Invited"; "No of SMEs Invited") { ApplicationArea = All; }
            field("No. of Bids Received"; "No. of Bids Received") { ApplicationArea = All; }
            field("No of Bids Received from SMEs"; "No of Bids Received from SMEs") { ApplicationArea = All; }
            field("No. of Responsive Bids"; "No. of Responsive Bids") { ApplicationArea = All; }
            field("Challenge  (Y/N)"; "Challenge  (Y/N)") { ApplicationArea = All; }
            field("Date Contract Awarded"; "Date Contract Awarded") { ApplicationArea = All; }
            field("Type of Procurement"; "Type of Procurement") { ApplicationArea = All; }
            field("Margin Preference benefitted"; "Margin Preference benefitted") { ApplicationArea = All; }
            field("Contract Amount Approved (Rs)"; "Contract Amount Approved (Rs)") { ApplicationArea = All; }
            field("Request for Purchase No."; "Request for Purchase No.") { ApplicationArea = All; }
            field("Request Dated"; "Request Dated") { ApplicationArea = All; }
            field("Validated By"; "Validated By") { ApplicationArea = All; }
            field("Validated On"; "Validated On") { ApplicationArea = All; }
        }
        modify("Order Address Code")
        {
            Visible = true;
        }
        moveafter("Buy-from Address"; "Order Address Code")
        addafter(PurchInvLines)
        {
            group(Earmarking)
            {
                field("Earmark ID"; "Earmark ID") { ApplicationArea = All; }
                field(Earmarked; Earmarked) { ApplicationArea = All; }
                field("Date Earmarked"; "Date Earmarked") { ApplicationArea = All; }
                field("Amount Earmarked"; "Amount Earmarked") { ApplicationArea = All; }
            }

            group(Information)
            {
                field("Shipping Instructions"; "Shipping Instructions") { ApplicationArea = All; }
                field("Special Instruction"; "Special Instruction") { ApplicationArea = All; }
                field("Terms and Conditions"; "Terms and Conditions") { ApplicationArea = All; }
                field("Requested Delivery Date"; "Requested Delivery Date") { ApplicationArea = All; }
                field("Actual Delivery Date"; "Actual Delivery Date") { ApplicationArea = All; }
            }
        }

    }

    trigger OnOpenPage();
    begin
        CurrPage.EDITABLE(FALSE);
    end;

}