pageextension 50039 SalesInvoiceCardExt extends "Sales Invoice"
{
    layout
    {
        modify("Sell-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Sell-to County")
        {
            Visible = false;
        }
        modify("Sell-to Contact No.")
        {
            Visible = false;
        }
        modify("Sell-to Contact")
        {
            Visible = true;
        }
        modify("Your Reference")
        {
            Visible = false;
        }
        modify("Shipping and Billing")
        {
            Caption = 'Billing';
            Visible = true;
        }
        modify(ShippingOptions)
        {
            Visible = false;
        }
        modify("Bill-to Country/Region Code")
        {
            Visible = true;
        }
        modify("Document Date")
        {
            Visible = false;
        }
        modify("External Document No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        movebefore(Status; "External Document No.")
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
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Shipment Date")
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
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Bill-to County")
        {
            Visible = false;
        }
        modify("Work Description")
        {
            Visible = false;
        }
        modify(SelectedPayments)
        {
            Visible = false;
        }
        modify("Shipment Method")
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
        addafter("Shortcut Dimension 2 Code")
        {
            field("Customer Posting Group"; Rec."Customer Posting Group")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        modify("Package Tracking No.")
        {
            Visible = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        modify("Bill-to Contact No.")
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
        addlast("Invoice Details")
        {
            field("Payment Service Set ID"; Rec."Payment Service Set ID")
            {
                Visible = false;
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
            field("Amount Tendered"; Rec."Amount Tendered") { ApplicationArea = all; }
            field("Amount Returned"; Rec."Amount Returned") { ApplicationArea = all; }

        }
        moveafter("Sell-to Address 2"; "Sell-to Contact")
    }

    actions
    {
        modify(Statistics)
        {
            trigger OnBeforeAction()
            var
                SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
            begin
                CalcInvDiscForHeader;
                Commit();
                PAGE.RunModal(PAGE::"Sales Statistics 2", Rec);
                SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
                Error('');
            end;
        }

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