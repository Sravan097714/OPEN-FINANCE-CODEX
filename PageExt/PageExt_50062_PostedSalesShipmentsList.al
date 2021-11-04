pageextension 50062 PostedSalesShipments extends "Posted Sales Shipments"
{
    layout
    {
        modify("Sell-to Post Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Sell-to Country/Region Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Sell-to Contact")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Posting Date")
        {
            Visible = true;
            ApplicationArea = All;
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

        addlast(Control1)
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