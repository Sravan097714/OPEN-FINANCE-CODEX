pageextension 50056 PostedSalesInvListExt extends "Posted Sales Invoices"
{
    layout
    {
        modify("Order No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(Closed)
        {
            Visible = false;
        }
        modify(Corrective)
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
            Visible = true;
            ApplicationArea = All;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(Amount)
        {
            Visible = true;
        }
        modify("Amount Including VAT")
        {
            Visible = true;
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Customer Name")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        modify("Location Code")
        {
            Visible = false;
            ApplicationArea = All;
        }


        addlast(Control1)
        {
            field("Pre-Assigned No."; Rec."Pre-Assigned No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("User ID"; Rec."User ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Customer Posting Group"; Rec."Customer Posting Group")
            {
                Editable = false;
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
            field("From OU Portal"; "From OU Portal")
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