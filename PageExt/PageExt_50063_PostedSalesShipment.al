pageextension 50063 PostedSalesShipment extends "Posted Sales Shipment"
{
    layout
    {
        modify("Requested Delivery Date")
        {
            Visible = false;
        }
        modify("Promised Delivery Date")
        {
            Visible = false;
        }
        modify("Sell-to Contact No.")
        {
            Visible = false;
        }
        modify("Sell-to County")
        {
            Visible = false;
        }
        modify("Quote No.")
        {
            Visible = false;
        }
        modify(Shipping)
        {
            Visible = false;
        }
        modify("Bill-to Country/Region Code") { Visible = true; }
        modify("Sell-to Country/Region Code") { Visible = true; }
        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Work Description")
        {
            Visible = false;
        }
        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Outbound Whse. Handling Time")
        {
            Visible = false;
        }
        modify("Shipping Time")
        {
            Visible = false;
        }
        modify("Shipment Method")
        {
            Visible = false;
        }
        addlast(General)
        {
            field(BRN; Rec.BRN)
            {
                ApplicationArea = All;
            }
            field("Delivery Date"; Rec."Delivery Date")
            {
                ApplicationArea = All;
            }
            field("Created By"; Rec."Created By")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnOpenPage();
    begin
        CurrPage.EDITABLE(FALSE);
    end;
}