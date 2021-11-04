pageextension 50032 SalesQuotesList extends "Sales Quotes"
{
    layout
    {
        modify("External Document No.")
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
        modify("Currency Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Requested Delivery Date")
        {
            Visible = false;
        }
        modify(Amount)
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Quote Valid Until Date")
        {
            Visible = false;
        }
        addafter("Sell-to Customer Name")
        {
            field("Order Date"; Rec."Order Date")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        modify(Status)
        {
            Visible = false;
        }
    }
}