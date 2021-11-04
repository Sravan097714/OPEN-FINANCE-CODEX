pageextension 50022 PurchInvoiceListExt extends "Purchase Invoices"
{
    layout
    {
        modify("Vendor Invoice No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Posting Date")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(Amount)
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify(Status)
        {
            Visible = true;
            ApplicationArea = All;
        }
        addafter("Buy-from Vendor Name")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                Visible = true;
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Vendor Invoice No.")
        {
            field("Vendor Posting Group"; Rec."Vendor Posting Group")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Buy-from Vendor Name")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }

        }
        addlast(Control1)
        {
            field("Created By"; Rec."Created By")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("Prices Including VAT", false);
        Rec.SetRange(Claim, false);
    end;


}