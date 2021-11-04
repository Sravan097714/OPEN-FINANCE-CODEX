pageextension 50065 PaymentJournal extends "Payment Journal"
{
    layout
    {
        modify("Document No.")
        {
            trigger OnAfterValidate()
            begin
                if not "Check Printed" then
                    "Payment Journal No." := "Document No.";
            end;
        }
        modify("Recipient Bank Account")
        {
            Visible = false;
        }
        modify("Message to Recipient")
        {
            Visible = false;
        }
        modify("Payment Reference")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("Amount (LCY)")
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
        modify("Applies-to Doc. Type")
        {
            Visible = false;
        }
        modify(AppliesToDocNo)
        {
            Visible = false;
        }
        modify(Correction)
        {
            Visible = false;
        }
        modify("Exported to Payment File")
        {
            Visible = false;
        }
        modify(TotalExportedAmount)
        {
            Visible = false;
        }
        modify(GetAppliesToDocDueDate)
        {
            Visible = false;
        }
        modify("Has Payment Export Error")
        {
            Visible = false;
        }
        modify("Bank Payment Type")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Check Printed")
        {
            Visible = true;
            ApplicationArea = All;
        }
        movebefore("Bal. Account Type"; "Bank Payment Type")

        addfirst(Control1)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }

        addlast(Control1)
        {
            field("Payment Discount %"; "Payment Discount %") { ApplicationArea = All; }
            field("Posting Group"; Rec."Posting Group") { ApplicationArea = All; }
            field("Created By"; "Created By") { ApplicationArea = All; }
            field("Payment Type"; "Payment Type") { ApplicationArea = All; }
            field("TDS Code"; "TDS Code") { ApplicationArea = All; }
            field(VAT; VAT) { ApplicationArea = All; }
            field("Retention Fee"; "Retention Fee") { ApplicationArea = All; }
            field(Payee; Payee) { ApplicationArea = All; }
            field("Payment Journal No."; "Payment Journal No.") { ApplicationArea = All; }
        }
    }
    actions
    {
        modify("Void Check")
        {
            trigger OnBeforeAction()
            begin
                if grecUserSetup.Get(UserId) then begin
                    if not grecUserSetup."Void Check" then
                        Error(gtextErrorAccess);
                end else
                    Error(gtextErrorAccess);
            end;
        }
        modify("Void &All Checks")
        {
            trigger OnBeforeAction()
            begin
                if grecUserSetup.Get(UserId) then begin
                    if not grecUserSetup."Void Check" then
                        Error(gtextErrorAccess);
                end else
                    Error(gtextErrorAccess);
            end;
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        Rec.TESTFIELD("Check Printed", FALSE);
    end;

    var
        grecUserSetup: Record "User Setup";
        gtextErrorAccess: Label 'You do not have access to this option.';
}