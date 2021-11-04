codeunit 50012 PreviewPosting
{
    SingleInstance = true;

    trigger OnRun()
    begin

    end;

    procedure RunPreviewPostingInTheBackground(precSalesHeader: Record "Sales Header")
    begin
        grecSalesHeader := precSalesHeader;
        grecSalesHeader."Load G/L Entry" := true;
        grecGLEntry.DeleteAll;
        IF grecSalesHeader."No." <> '' then begin
            if grecSalesHeader."Document Type" = grecSalesHeader."Document Type"::Invoice then
                precSalesHeader.Invoice := true;
            SalesPost.SetPreviewMode(true);
            SalesPost.Run(precSalesHeader);
            SalesPostYesNo.Preview(precSalesHeader);
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInsertGlobalGLEntry', '', false, false)]
    local procedure MyProcedure(VAR GlobalGLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        IF grecSalesHeader."Load G/L Entry" then begin
            grecGLEntry.Init;
            grecGLEntry := GlobalGLEntry;
            IF NOT grecGLEntry.Insert then;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, 19, 'OnBeforeThrowError', '', false, false)]
    local procedure PreventPreviewError()
    begin
        IF grecSalesHeader."Load G/L Entry" then begin
            grecSalesHeader."Load G/L Entry" := false;
            error('');
        end;
    end;


    procedure GetGLEntry(var GLEntry: Record "G/L Entry" temporary)
    begin
        if grecGLEntry.findset then begin
            repeat
                GLEntry.Init;
                GLEntry := grecGLEntry;
                GLEntry.Insert;
            until grecGLEntry.Next = 0;
        end;
    end;


    procedure DeleteGLEntries()
    begin
        grecGLEntry.DeleteAll;
    end;

    var
        SalesPost: Codeunit 80;
        grecSalesHeader: Record 36;
        grecGLEntry: Record 17 temporary;
        SalesPostYesNo: Codeunit 81;
}