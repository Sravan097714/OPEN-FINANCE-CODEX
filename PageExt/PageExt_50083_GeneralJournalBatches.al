pageextension 50083 GeneralJournalBatches extends "General Journal Batches"
{
    layout
    {
        modify("Reason Code")
        {
            Visible = false;
        }
        modify("Copy VAT Setup to Jnl. Lines")
        {
            Visible = false;
        }
        modify("Allow VAT Difference")
        {
            Visible = false;
        }
        modify("Suggest Balancing Amount")
        {
            Visible = false;
        }

        modify("Allow Payment Export")
        {
            Visible = false;
        }
        modify(BackgroundErrorCheck)
        {
            Visible = false;
        }
        modify("Copy to Posted Jnl. Lines")
        {
            Visible = false;
        }

        /* addlast(Control1)
        {
            field("PV No. Series"; Rec."PV No. Series")
            {
                ApplicationArea = All;
            }
            field("Vendor Type"; "Vendor Type")
            {
                ApplicationArea = All;
            }
        } */

        modify("No. Series") { Editable = true; }
        modify("Posting No. Series") { Editable = true; }
    }

    trigger OnOpenPage()
    var
        grecUserforCashRcptJnl: Record "Users for Cash Receipt Journal";
        gtextfilter: Text[250];
    begin
        Clear(gtextfilter);
        if "Journal Template Name" = 'CASH RECE' then begin
            grecUserforCashRcptJnl.Reset();
            grecUserforCashRcptJnl.SetRange(UserID, UserId);
            grecUserforCashRcptJnl.SetRange("Jnl Template Name", 'CASH RECE');
            if grecUserforCashRcptJnl.FindFirst() then begin
                repeat
                    if gtextfilter = '' then
                        gtextfilter := grecUserforCashRcptJnl."Jnl Batch Name"
                    else
                        gtextfilter += '|' + grecUserforCashRcptJnl."Jnl Batch Name";
                until grecUserforCashRcptJnl.Next = 0;
            end;

            if gtextfilter <> '' then begin
                SetRange("Journal Template Name", 'CASH RECE');
                SetFilter(Name, gtextfilter);
            end else
                Error('You do not have access to any batch on this journal.');
        end;
    end;
}