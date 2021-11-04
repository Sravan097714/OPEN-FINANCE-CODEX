pageextension 50030 PurchHdrArchiveCardExt extends "Purchase Order Archive"
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
        modify("Vendor Order No.")
        {
            Caption = 'Reason for Closing Purchase Order';
        }
        modify("Vendor Shipment No.")
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
        modify("Pay-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Order Address Code")
        {
            Visible = false;
        }
        modify(Status)
        {
            visible = false;
        }

        addlast(General)
        {
            field(BRN; Rec.BRN)
            {
                ApplicationArea = All;
            }
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
            field("Cancelled By"; Rec."Cancelled By")
            {
                ApplicationArea = All;
                //Caption = 'Closed By';
            }
            field("Date Cancelled"; Rec."Date Cancelled")
            {
                ApplicationArea = All;
                //Caption = 'Date Closed';
            }
            field("Time Cancelled"; Rec."Time Cancelled")
            {
                ApplicationArea = All;
                //Caption = 'Time Closed';
            }
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
        }

        addafter(PurchLinesArchive)
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
}
