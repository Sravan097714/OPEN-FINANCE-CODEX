pageextension 50064 CashReceiptJournal extends "Cash Receipt Journal"
{
    layout
    {
        modify("External Document No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Currency Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Amount (LCY)")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Debit Amount")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify(Correction)
        {
            Visible = false;
        }
        modify("Applies-to Doc. Type")
        {
            Visible = false;
        }
        modify("Applies-to Doc. No.")
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
        addfirst(Control1)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter(Description)
        {
            field("Posting Group"; Rec."Posting Group")
            {
                Visible = true;
                Editable = true;
                ApplicationArea = All;
            }
            field("Voucher No."; "Voucher No.")
            {
                ApplicationArea = All;
            }
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
            }
        }

        addbefore("Shortcut Dimension 1 Code")
        {
            field("Student ID"; "Student ID") { ApplicationArea = All; }
        }
        addafter(Description)
        {
            field(Payee; Payee) { ApplicationArea = All; }
        }
        addlast(Control1)
        {

            field("Created By"; "Created By") { ApplicationArea = All; }
            field(RDAP; RDAP) { ApplicationArea = ALL; }
            field(RDBL; RDBL) { ApplicationArea = ALL; }
            field(NIC; NIC) { ApplicationArea = ALL; }
            field("Student Name"; "Student Name") { ApplicationArea = ALL; }
            field("Login Email"; "Login Email") { ApplicationArea = ALL; }
            field("Contact Email"; "Contact Email") { ApplicationArea = ALL; }
            field(Phone; Phone) { ApplicationArea = ALL; }
            field(Mobile; Mobile) { ApplicationArea = ALL; }
            field(Address; Address) { ApplicationArea = ALL; }
            field(Country; Country) { ApplicationArea = ALL; }
        }
        addafter(CurrentJnlBatchName)
        {
            field(LastNoUsedPosted; GetLastUsedPostedNo())
            {
                ApplicationArea = all;
                Caption = 'Posted Last No. Used';
                Editable = false;
                ToolTip = 'Specifies the last number that was used from the number series.';
            }
        }

    }

    actions
    {
        /* addlast(processing)
        {
            action("Upload list of payments")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = UpdateXML;

                trigger OnAction()
                var
                    gpageListofUploadedPayments: Page "List of Uploaded Payments";
                begin
                    gpageListofUploadedPayments.Run();
                end;
            }
        } */
    }
    local procedure GetLastUsedPostedNo(): Code[20]
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        GenJnlBatch.Get(GetRangeMax("Journal Template Name"), GetRangeMax("Journal Batch Name"));
        if GenJnlBatch."Posting No. Series" = '' then
            exit('');
        NoSeriesMgt.SetNoSeriesLineFilter(NoSeriesLine, GenJnlBatch."Posting No. Series", 0D);
        exit(NoSeriesLine."Last No. Used");
    end;

    var
        LastUsedPostedNo: Code[20];
        GenJnlBatch: Record "Gen. Journal Batch";
        NoSeriesLine: Record "No. Series Line";
}