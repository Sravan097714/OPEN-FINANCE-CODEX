pageextension 50036 SalesOrderCardExt extends "Sales Order"
{
    layout
    {
        modify("Sell-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Sell-to Phone No.")
        {
            Visible = false;
        }
        modify("Sell-to E-Mail")
        {
            Visible = false;
        }
        modify("Document Date")
        {
            Visible = false;
        }
        modify("No. of Archived Versions")
        {
            Visible = false;
        }
        modify("Sell-to County")
        {
            Visible = false;
        }
        modify("Sell-to Contact")
        {
            Visible = false;
        }
        modify("Sell-to Contact No.")
        {
            Visible = false;
        }
        modify(SelectedPayments)
        {
            Visible = false;
        }

        modify("Shipping and Billing")
        {
            Visible = false;
        }
        modify(Control1900201301)
        {
            Visible = false;
        }
        modify("Requested Delivery Date")
        {
            Visible = false;
        }
        modify("Promised Delivery Date")
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
        modify("Campaign No.")
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
        modify("Payment Discount %")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Direct Debit Mandate ID")
        {
            Visible = false;
        }
        modify("Shipping Agent Code")
        {
            Visible = false;
        }
        modify("Shipping Agent Service Code")
        {
            Visible = false;
        }
        modify("Package Tracking No.")
        {
            Visible = false;
        }
        modify("Bill-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }
        modify("Late Order Shipping")
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
        modify("Shipping Advice")
        {
            Visible = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        modify("Posting Description")
        {
            Visible = true;
            ApplicationArea = All;
        }
        moveafter("Sell-to Customer Name"; "Posting Description")

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

    actions
    {
        addbefore("Test Report")
        {
            action("Load G/L Entries")
            {
                ApplicationArea = All;
                ToolTip = 'Load G/L Entries before Test Report';
                Image = GetEntries;

                trigger OnAction()
                var
                    PreviewPostingCU: Codeunit 50012;
                begin
                    PreviewPostingCU.RunPreviewPostingInTheBackground(Rec);
                end;
            }
        }
    }
}