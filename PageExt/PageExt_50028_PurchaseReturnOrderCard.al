pageextension 50028 PurchReturnOrderCardExt extends "Purchase Return Order"
{
    layout
    {
        modify("Buy-from Country/Region Code")
        {
            Visible = false;
        }
        modify("Vendor Authorization No.")
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
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Expected Receipt Date")
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
        modify("Payment Terms Code")
        {
            Visible = false;
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }
        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Pay-to Country/Region Code")
        {
            Visible = false;
        }
        addafter("Buy-from Vendor Name")
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