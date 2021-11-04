pageextension 50033 SalesQuoteCard extends "Sales Quote"
{
    layout
    {
        modify("Sell-to Customer Template Code")
        {
            Visible = false;
        }
        modify("No. of Archived Versions")
        {
            Visible = false;
        }
        modify("Requested Delivery Date")
        {
            Visible = false;
        }
        modify("Your Reference")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("Opportunity No.")
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
        modify("Work Description")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify(SelectedPayments)
        {
            Visible = false;
        }
        modify("Transaction Type")
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
        modify("Location Code")
        {
            Visible = true;
        }
        modify("Shipment Method")
        {
            Visible = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }

        addafter("Shortcut Dimension 2 Code")
        {
            field("Customer Posting Group"; Rec."Customer Posting Group")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }
    }

}