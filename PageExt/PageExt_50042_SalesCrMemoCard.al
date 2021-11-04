pageextension 50042 SalesCrMemoCardExt extends "Sales Credit Memo"
{
    layout
    {
        modify("Sell-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Document Date")
        {
            Visible = false;
        }
        modify("External Document No.")
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
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Work Description")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }
        modify("Sell-to Contact No.")
        {
            Visible = false;
        }
        modify("Sell-to Contact")
        {
            Visible = false;
        }
        modify(Billing)
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }
        modify("Payment Terms Code")
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
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Bill-to Country/Region Code")
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
        modify("Location Code")
        {
            Visible = false;
        }
        addbefore("Posting Date")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            field("Created By"; Rec."Created By")
            {
                ApplicationArea = All;
            }
            field("Our Ref"; "Our Ref") { ApplicationArea = All; }
            field("Your Ref"; "Your Ref") { ApplicationArea = All; }
        }
    }
    actions
    {
        addbefore(TestReport)
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