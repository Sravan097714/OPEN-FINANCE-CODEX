codeunit 50002 "Sales Posting"
{
    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostLines', '', false, false)]
    Procedure ValidateVATProdPostingGroup(VAR SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    begin
        if SalesLine.findset() then
            repeat
                IF (SalesLine.Type <> SalesLine.Type::" ") and (SalesLine."No." <> '') then
                    SalesLine.TestField("Vat Prod. Posting Group");

            until SalesLine.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostSalesDoc', '', false, false)]
    local procedure CheckPostingDesc(VAR Sender: Codeunit "Sales-Post"; VAR SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    var
        gtextPostingDescError: TextConst ENU = 'Please insert Posting Description.';
    begin
        IF SalesHeader."Posting Description" = '' then
            Error(gtextPostingDescError);

        if SalesHeader."Gov Grant" then
            Error('This is a Government Grant transaction. It cannot be posted. Please archive.');
    end;


    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostInvPostBuffer', '', false, false)]
    local procedure OnBeforePostInvPostBuffer(var GenJnlLine: Record "Gen. Journal Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer"; var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean)
    begin
        GenJnlLine."From OU Portal" := SalesHeader."From OU Portal";
    end;


    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostCustomerEntry', '', false, false)]
    local procedure OnBeforePostCustomerEntry(var GenJnlLine: Record "Gen. Journal Line"; var SalesHeader: Record "Sales Header"; var TotalSalesLine: Record "Sales Line"; var TotalSalesLineLCY: Record "Sales Line"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
        GenJnlLine."From OU Portal" := SalesHeader."From OU Portal";
    end;
}