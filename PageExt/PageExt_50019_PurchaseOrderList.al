pageextension 50019 PurchOrderListExt extends "Purchase Order List"
{
    layout
    {
        modify("No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Vendor Authorization No.")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Document Date")
        {
            Visible = false;
        }
        modify(Amount)
        {
            Visible = false;
        }
        modify("Amount Including VAT")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        moveafter("Shortcut Dimension 1 Code"; "Currency Code")
        moveafter("Buy-from Vendor Name"; "Posting Description")

        modify("Shortcut Dimension 2 Code")
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
        modify("Posting Description")
        {
            Visible = true;
            ApplicationArea = All;
        }
        addafter("Buy-from Vendor Name")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
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
            field("Released By"; Rec."Released By")
            {
                ApplicationArea = All;
            }
            field("Date Time Released"; Rec."Date Time Released")
            {
                ApplicationArea = All;
            }
            field("Reopened By"; Rec."Reopened By")
            {
                ApplicationArea = All;
            }
            field("Date Time Reopened"; Rec."Date Time Reopened")
            {
                ApplicationArea = All;
            }
            /*field("Earmark ID"; "Earmark ID") { ApplicationArea = All; }
            field("Date Earmarked"; "Date Earmarked") { ApplicationArea = All; }*/
            field("Amount Earmarked"; "Amount Earmarked") { ApplicationArea = All; }
            field("Validated By"; "Validated By") { ApplicationArea = All; }
            field("Validated On"; "Validated On") { ApplicationArea = ALl; }
        }

    }


    actions
    {
        modify(Print)
        {
            trigger OnBeforeAction()
            var
                gtextError: TextConst ENU = 'Purchase Order should be released before printing.';
            begin
                if Rec.Status <> Rec.Status::Released then
                    error(gtextError);

                if ("Validated By" = '') or ("Validated On" = 0DT) then
                    Error('Please validate purchase order to be able to proceed.');
            end;
        }
        modify(AttachAsPDF)
        {
            trigger OnBeforeAction()
            begin
                if ("Validated By" = '') or ("Validated On" = 0DT) then
                    Error('Please validate purchase order to be able to proceed.');
            end;
        }
        modify(Send)
        {
            trigger OnBeforeAction()
            begin
                if ("Validated By" = '') or ("Validated On" = 0DT) then
                    Error('Please validate purchase order to be able to proceed.');
            end;
        }

        modify(Release)
        {
            trigger OnBeforeAction()
            var
                grecPurchLine: Record "Purchase Line";
            begin
                grecPurchLine.Reset();
                grecPurchLine.SetRange("Document No.", "No.");
                grecPurchLine.SetFilter(Type, '<>%1', grecPurchLine.Type::" ");
                grecPurchLine.SetFilter("No.", '<>%1', '');
                if grecPurchLine.FindFirst() then begin
                    repeat
                        if (grecPurchLine."Gen. Prod. Posting Group" = '') or (grecPurchLine."VAT Prod. Posting Group" = '') then
                            Error('Gen. Prod. Posting Group and VAT Prod. Posting Group must have a value on line %1.', grecPurchLine."Line No.");
                    until grecPurchLine.Next = 0;
                end;
            end;
        }
    }

    trigger OnOpenPage()
    begin
        //Rec.SetRange("Prices Including VAT", false);
    end;

    var
        grecUserSetup: Record "User Setup";
}