codeunit 50004 ArchivePurchOrder
{

    SingleInstance = true;

    var
        gboolCheckCancel: Boolean;

    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, 5063, 'OnBeforePurchHeaderArchiveInsert', '', false, false)]
    local procedure InsertCancelledInfo(VAR PurchaseHeaderArchive: Record "Purchase Header Archive"; PurchaseHeader: Record "Purchase Header")
    begin
        if gboolCheckCancel then begin
            PurchaseHeaderArchive."Cancelled By" := UserId();
            PurchaseHeaderArchive."Date Cancelled" := WorkDate();
            PurchaseHeaderArchive."Time Cancelled" := Time;
        end;
    end;

    procedure CheckifCancelled(pboolCheckCancel: Boolean)
    begin
        gboolCheckCancel := pboolCheckCancel;
    end;

    procedure ClearCancelled()
    begin
        gboolCheckCancel := false;
    end;


}