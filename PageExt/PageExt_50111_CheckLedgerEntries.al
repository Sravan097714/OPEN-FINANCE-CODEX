pageextension 50111 CheckLedgerEntries extends "Check Ledger Entries"
{

    actions
    {
        modify("Void Check")
        {
            trigger OnBeforeAction()
            begin
                if grecUserSetup.Get(UserId) then begin
                    if not grecUserSetup."Void Check on Chk Led Entries" then
                        Error(gtextErrorAccess);
                end else
                    Error(gtextErrorAccess);
            end;
        }
    }

    var
        grecUserSetup: Record "User Setup";
        gtextErrorAccess: Label 'You do not have access to this option.';
}