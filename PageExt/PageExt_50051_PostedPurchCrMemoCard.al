Pageextension 50051 PostedPurchCrMemoCardExt extends "Posted Purchase Credit Memo"
{
    layout
    {
        modify("Buy-from Country/Region Code")
        {
            Visible = false;
        }
        modify("Order Address Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Buy-from Contact No.")
        {
            Visible = false;
        }
        modify("Buy-from Contact")
        {
            Visible = false;
        }
        modify("Purchaser Code")
        {
            Visible = false;
        }
        modify(Cancelled)
        {
            Visible = false;
        }
        modify(Corrective)
        {
            Visible = false;
        }
        modify("No. Printed")
        {
            Visible = false;
        }
        modify("Applies-to Doc. No.")
        {
            Visible = false;
        }
        modify("Applies-to Doc. Type")
        {
            Visible = false;
        }
        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Pay-to Name")
        {
            Visible = false;
        }
        modify("Pay-to Address")
        {
            Visible = false;
        }
        modify("Pay-to Address 2")
        {
            Visible = false;
        }
        modify("Pay-to City")
        {
            Visible = false;
        }
        modify("Pay-to Contact No.")
        {
            Visible = false;

        }
        modify("Pay-to Post Code")
        {
            Visible = false;

        }
        modify("Pay-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Pay-to Contact")
        {
            Visible = false;
        }
        addafter("Currency Code")
        {
            field("Prices Including VAT"; Rec."Prices Including VAT")
            {
                Editable = false;
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
            field("User ID"; "User ID")
            {
                ApplicationArea = All;
            }
            field(Amount; Amount)
            {
                ApplicationArea = All;
            }
            field("Amount Including VAT"; "Amount Including VAT")
            {
                ApplicationArea = All;
            }
            field("Vendor Posting Group"; "Vendor Posting Group") { ApplicationArea = All; }
        }
    }

    trigger OnOpenPage();
    begin
        CurrPage.EDITABLE(FALSE);
    end;

}