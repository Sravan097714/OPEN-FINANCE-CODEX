pageextension 50118 BlanketPOCard extends "Blanket Purchase Order"
{
    layout
    {
        addlast(General)
        {
            field("PO Category"; "PO Category") { ApplicationArea = All; }
            field("Procurement Method"; "Procurement Method") { ApplicationArea = All; }
            field("Category of Successful Bidder"; "Category of Successful Bidder") { ApplicationArea = All; }
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
            field("Created By"; "Created By") { ApplicationArea = All; }
        }

        modify("Prices Including VAT")
        {
            Visible = true;
        }
        modify("Currency Code")
        {
            Visible = true;
        }

        movebefore("PO Category"; "Currency Code")
        movebefore("Currency Code"; "Prices Including VAT")

        modify("Invoice Details")
        {
            Visible = false;
        }
        modify("Shipping and Payment")
        {
            Visible = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        modify("Buy-from Contact") { Visible = false; }
        modify("Vendor Shipment No.") { Visible = false; }
        modify("Purchaser Code") { Visible = false; }
        modify("Campaign No.") { Visible = false; }
        modify("Responsibility Center") { Visible = false; }
        modify("Assigned User ID") { Visible = false; }
    }
}