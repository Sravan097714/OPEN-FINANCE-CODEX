pageextension 50054 PostedPurchRcptCardExt extends "Posted Purchase Receipt"
{
    layout
    {
        modify("Buy-from Country/Region Code")
        {
            Visible = false;
        }
        modify("Requested Receipt Date")
        {
            Visible = false;
        }
        modify("Promised Receipt Date")
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
        modify("Quote No.")
        {
            Visible = false;
        }
        modify("Vendor Order No.")
        {
            Visible = false;
        }
        modify("Vendor Shipment No.")
        {
            Visible = false;
        }
        modify("Order Address Code")
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
        modify("Inbound Whse. Handling Time")
        {
            Visible = false;
        }
        modify("Lead Time Calculation")
        {
            Visible = false;
        }
        modify("Expected Receipt Date")
        {
            Visible = false;
        }
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        modify(Invoicing)
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
            field("Created By"; Rec."Created By")
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
            field("Category of Successful Bidder"; "Category of Successful Bidder") { ApplicationArea = All; }
            field(Price; Price) { ApplicationArea = All; }
            field(Quality; Quality) { ApplicationArea = All; }
            field(Responsiveness; Responsiveness) { ApplicationArea = All; }
            field(Delivery; Delivery) { ApplicationArea = All; }


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
        addafter(PurchReceiptLines)
        {
            group(Earmarking)
            {
                field("Earmark ID"; "Earmark ID") { ApplicationArea = All; }
                field(Earmarked; Earmarked) { ApplicationArea = All; }
                field("Date Earmarked"; "Date Earmarked") { ApplicationArea = All; }
                field("Amount Earmarked"; "Amount Earmarked") { ApplicationArea = All; }
            }
        }
    }
    trigger OnOpenPage();
    begin
        CurrPage.EDITABLE(FALSE);
    end;
}