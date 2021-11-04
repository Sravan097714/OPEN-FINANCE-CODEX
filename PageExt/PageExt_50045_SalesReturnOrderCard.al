pageextension 50045 SalesReturnOrderCardExt extends "Sales Return Order"
{
    layout
    {
        modify("No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Sell-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Document Date")
        {
            Visible = false;
        }
        modify("Your Reference")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("No. of Archived Versions")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
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
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Shipment Method")
        {
            Visible = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        addafter("Sell-to Customer Name")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = All;
            }
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
        }
    }

}