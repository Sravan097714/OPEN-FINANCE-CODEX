codeunit 50000 Miscellaneous
{
    SingleInstance = true;
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterCopySellToCustomerAddressFieldsFromCustomer', '', false, false)]
    local procedure OnAfterCopySellToCustomerAddressFieldsFromCustomer(VAR SalesHeader: Record "Sales Header"; SellToCustomer: Record Customer; CurrentFieldNo: Integer)
    var
        grecCustomer: Record Customer;
    begin
        if grecCustomer.get(SellToCustomer."No.") then
            SalesHeader.BRN := grecCustomer.BRN;
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterCopyBuyFromVendorFieldsFromVendor', '', false, false)]
    local procedure OnAfterCopyBuyFromVendorFieldsFromVendor(VAR PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor)
    var
        grecVendor: Record Vendor;
    begin
        if grecVendor.get(Vendor."No.") then
            PurchaseHeader.BRN := grecVendor.BRN;
    end;


    [EventSubscriber(ObjectType::Table, 83, 'OnBeforeVerifyReservedQty', '', false, false)]
    local procedure OnBeforeVerifyReservedQty(var ItemJournalLine: Record "Item Journal Line"; xItemJournalLine: Record "Item Journal Line"; CalledByFieldNo: Integer)
    var
        grecItemJnlBatch: Record "Item Journal Batch";
    begin
        if grecItemJnlBatch.Get(ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name") then begin
            if grecItemJnlBatch."Gen. Prod Posting Group" <> '' then
                ItemJournalLine."Gen. Prod. Posting Group" := grecItemJnlBatch."Gen. Prod Posting Group";
        end;


        if ItemJournalLine."Item No." = '' then
            ItemJournalLine."Gen. Prod. Posting Group" := '';
    end;

    procedure CheckHashQty(var precItemJnlLine: Record "Item Journal Line"; pdecHashQty: Decimal)
    var
        gdecTotalQty: Integer;
        gtextError1: Label 'The total quantity on the lines is not equal to the Hash Quantity. Kindly review.';
        grecItemJnlLine: Record "Item Journal Line";
        ItemJnlBatch: Record "Item Journal Batch";
    begin
        Clear(gdecTotalQty);
        grecItemJnlLine.Reset();
        grecItemJnlLine.SetRange("Journal Template Name", precItemJnlLine."Journal Template Name");
        grecItemJnlLine.SetRange("Journal Batch Name", precItemJnlLine."Journal Batch Name");
        //grecItemJnlLine.SetRange("Created By", UserId);
        if grecItemJnlLine.FindFirst() then begin
            repeat
                gdecTotalQty += grecItemJnlLine.Quantity;
                if grecItemJnlLine."Requested By" = '' then
                    Error('Please fill up field "Requested By" on Line No. %1 before posting.', grecItemJnlLine."Line No.");
            until grecItemJnlLine.Next = 0;
        end;


        ItemJnlBatch.Reset();
        ItemJnlBatch.SetRange("Journal Template Name", 'ITEM');
        ItemJnlBatch.SetRange(Name, precItemJnlLine."Journal Batch Name");
        if ItemJnlBatch.FindFirst() then
            pdecHashQty := ItemJnlBatch."Hash Quantity";

        if gdecTotalQty <> pdecHashQty then
            Error(gtextError1);
    end;


    procedure ClearHashQty(ptextBatchName: Text[50])
    var
        gdecTotalQty: Integer;
        ItemJnlBatch: Record "Item Journal Batch";
    begin
        ItemJnlBatch.Reset();
        ItemJnlBatch.SetRange("Journal Template Name", 'ITEM');
        ItemJnlBatch.SetRange(Name, ptextBatchName);
        if ItemJnlBatch.FindFirst() then begin
            ItemJnlBatch."Hash Quantity" := 0;
            ItemJnlBatch.Modify;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, 22, 'OnBeforeInsertItemLedgEntry', '', false, false)]
    local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry")
    begin
        ItemLedgerEntry."Requested By" := ItemJournalLine."Requested By";
        ItemLedgerEntry."Created By" := ItemJournalLine."Created By";
        ItemLedgerEntry."Vendor No." := ItemJournalLine."Vendor No.";
    end;


    [EventSubscriber(ObjectType::Table, 83, 'OnAfterCopyItemJnlLineFromPurchHeader', '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromPurchHeader(var ItemJnlLine: Record "Item Journal Line"; PurchHeader: Record "Purchase Header")
    begin
        ItemJnlLine."Original PO Number" := PurchHeader."No.";
    end;


    [EventSubscriber(ObjectType::Codeunit, 22, 'OnBeforeInsertValueEntry', '', false, false)]
    local procedure OnBeforeInsertValueEntry(var ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry"; var ValueEntryNo: Integer; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; CalledFromAdjustment: Boolean)
    begin
        ValueEntry."Requested By" := ItemJournalLine."Requested By";
        ValueEntry."Created By" := ItemJournalLine."Created By";
        ValueEntry."Original PO Number" := ItemJournalLine."Original PO Number";
        ValueEntry."Vendor No." := ItemJournalLine."Vendor No.";
    end;


    [EventSubscriber(ObjectType::Codeunit, 5802, 'OnPostInvtPostBufOnAfterInitGenJnlLine', '', false, false)]
    local procedure OnPostInvtPostBufOnAfterInitGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var ValueEntry: Record "Value Entry")
    begin
        GenJournalLine."Requested By" := ValueEntry."Requested By";
        GenJournalLine."Original PO Number" := ValueEntry."Original PO Number";
    end;


    [EventSubscriber(ObjectType::Table, 17, 'OnAfterCopyGLEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry."Requested By" := GenJournalLine."Requested By";
        GLEntry."Original PO Number" := GenJournalLine."Original PO Number";
    end;


    [EventSubscriber(ObjectType::Codeunit, 5604, 'OnAfterCopyFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyFromGenJnlLine(var FALedgerEntry: Record "FA Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        FALedgerEntry."Created By" := GenJournalLine."Created By";
        FALedgerEntry."Description 2" := GenJournalLine."Description 2";
    end;


    [EventSubscriber(ObjectType::Codeunit, 23, 'OnAfterPostLines', '', false, false)]
    local procedure OnAfterPostLines(var ItemJournalLine: Record "Item Journal Line"; var ItemRegNo: Integer)
    var
        grecItem: Record Item;
        grecItemJnlLine: Record "Item Journal Line";
    begin
        grecItemJnlLine.Reset();
        grecItemJnlLine.SetRange("Entry Type", ItemJournalLine."Entry Type");
        grecItemJnlLine.SetRange("Journal Template Name", ItemJournalLine."Journal Template Name");
        grecItemJnlLine.SetRange("Journal Batch Name", ItemJournalLine."Journal Batch Name");
        grecItemJnlLine.SetRange("Created By", UserId);
        if grecItemJnlLine.FindFirst() then begin
            repeat
                if grecItem.get(grecItemJnlLine."Item No.") then begin
                    grecItem.CalcFields(Inventory);
                    if grecItem.Inventory <= grecItem."Reorder Quantity" then
                        Message('The Quantity in Stock for Item No. %1 is less or equal to its Reorder Quantity. Please check.', grecItemJnlLine."Item No.");
                end;
            until grecItemJnlLine.Next = 0;
        end;
    end;


    [EventSubscriber(ObjectType::Page, 291, 'OnBeforeCarryOutActionMsg', '', false, false)]
    local procedure OnBeforeCarryOutActionMsg(var RequisitionLine: Record "Requisition Line"; var IsHandled: Boolean);
    var
        grecReqLine: Record "Requisition Line";
    begin
        grecReqLine.Reset();
        grecReqLine := RequisitionLine;
        grecReqLine.SetRange(Approved, true);
        if grecReqLine.FindFirst() then
            RequisitionLine := grecReqLine
        else
            Error('There is no requisition line that has been approved.');
    end;


    [EventSubscriber(ObjectType::Codeunit, 333, 'OnAfterCode', '', false, false)]
    local procedure DisplayPONumber()
    begin
        gfuncPrintPONumber();
    end;


    [EventSubscriber(ObjectType::Codeunit, 333, 'OnAfterInsertPurchOrderHeader', '', false, false)]
    local procedure OnAfterInsertPurchOrderHeader(var RequisitionLine: Record "Requisition Line"; var PurchaseOrderHeader: Record "Purchase Header"; CommitIsSuppressed: Boolean)
    var
        grecArchiveRequisition: Record "Requisition Line Archive";
    begin
        with RequisitionLine do begin
            grecArchiveRequisition.Init();
            grecArchiveRequisition.TransferFields(RequisitionLine);
            grecArchiveRequisition."Archive Type" := 'PO Created';
            grecArchiveRequisition."PO Number" := PurchaseOrderHeader."No.";
            grecArchiveRequisition.Insert(true);

            if gtextPONumber = '' then
                gtextPONumber := PurchaseOrderHeader."No."
            else
                gtextPONumber += '|' + PurchaseOrderHeader."No.";
            Message(gtextPONumber);
        end;
    end;

    local procedure gfuncPrintPONumber()
    var
        grecPurchaseHdr: Record "Purchase Header";
    begin
        if gtextPONumber <> '' then begin
            grecPurchaseHdr.Reset();
            grecPurchaseHdr.SetFilter("No.", gtextPONumber);
            if grecPurchaseHdr.FindFirst() then begin
                repeat
                    Message('Purchase order %1 has been created.', grecPurchaseHdr."No.");
                until grecPurchaseHdr.Next = 0;
            end;
            Clear(gtextPONumber);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 392, 'OnBeforeReminderLineInsert', '', false, false)]
    local procedure OnBeforeReminderLineInsert(var ReminderLine: Record "Reminder Line"; ReminderHeader: Record "Reminder Header"; ReminderLevel: Record "Reminder Level"; CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        grecReminderHdr: Record "Reminder Header";
    begin
        ReminderLine."Global Dimension 1" := CustLedgerEntry."Global Dimension 1 Code";
        ReminderLine."Global Dimension 2" := CustLedgerEntry."Global Dimension 2 Code";
    end;


    [EventSubscriber(ObjectType::Table, 49, 'OnAfterInvPostBufferPreparePurchase', '', false, false)]
    local procedure OnAfterInvPostBufferPreparePurchase(var PurchaseLine: Record "Purchase Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer")
    begin
        InvoicePostBuffer.VAT := PurchaseLine.VAT;
        InvoicePostBuffer."TDS Code" := PurchaseLine."TDS Code";
        InvoicePostBuffer."Retention Fee" := PurchaseLine."Retention Fee";
    end;

    [EventSubscriber(ObjectType::Table, 49, 'OnAfterInvPostBufferPrepareSales', '', false, false)]
    local procedure OnAfterInvPostBufferPrepareSales(var SalesLine: Record "Sales Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer")
    var
        grecSalesHeader: Record "Sales Header";
    begin
        if grecSalesHeader.get(SalesLine."Document Type", SalesLine."Document No.") then
            InvoicePostBuffer."From Ou Portal" := grecSalesHeader."From OU Portal";
    end;



    //Attachment
    [EventSubscriber(ObjectType::Page, 1174, 'OnBeforeDrillDown', '', false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        grecCurrency: Record Currency;
        grecBankAccRecon: Record "Bank Acc. Reconciliation";
    begin
        begin
            case DocumentAttachment."Table ID" of
                DATABASE::Currency:
                    begin
                        RecRef.Open(DATABASE::Currency);
                        if grecCurrency.Get('EUR') then
                            RecRef.GetTable(grecCurrency);
                    end;
                Database::"Bank Acc. Reconciliation":
                    begin
                        RecRef.Open(DATABASE::"Bank Acc. Reconciliation");
                        if grecBankAccRecon.Get(grecBankAccRecon."Statement Type"::"Bank Reconciliation", gtextBankAccNo, gtextStatementNo) then
                            RecRef.GetTable(grecBankAccRecon);
                    end;
            end;
        end;
    end;


    [EventSubscriber(ObjectType::Page, 1173, 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    var
        grecCurrency: Record Currency;
        grecBankAccRecon: Record "Bank Acc. Reconciliation";
        gtextField1: Text;
        gtextField2: Text;
        fieldRef: FieldRef;
    begin
        case RecRef.Number of
            DATABASE::"Bank Acc. Reconciliation":
                begin
                    FieldRef := RecRef.Field(1);
                    gtextField1 := FieldRef.Value;
                    DocumentAttachment.SetRange("Bank Account No.", gtextField1);

                    FieldRef := RecRef.Field(2);
                    gtextField2 := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", gtextField2);

                    FlowFieldsEditable := false;
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Table, 1173, 'OnBeforeInsertAttachment', '', false, false)]
    local procedure OnBeforeInsertAttachment(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        BankAccNo: Code[20];
        StatementNo: Code[20];
        grecDocAttach: Record "Document Attachment";
    begin
        case RecRef.Number of
            DATABASE::"Bank Acc. Reconciliation":
                begin
                    FieldRef := RecRef.Field(1);
                    BankAccNo := FieldRef.Value;
                    DocumentAttachment.Validate("Bank Account No.", BankAccNo);

                    FieldRef := RecRef.Field(2);
                    StatementNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", StatementNo);


                    grecDocAttach.Reset();
                    grecDocAttach.SetRange("No.");
                    DocumentAttachment."Line No." := grecDocAttach."Line No." + 1;
                end;
        end;
    end;


    procedure SetMainRecValue(ptextBankAccNo: Text; ptextStatementNo: text)
    begin
        gtextBankAccNo := ptextBankAccNo;
        gtextStatementNo := ptextStatementNo;
    end;
    //Attachment


    /*  [EventSubscriber(ObjectType::Codeunit, 392, 'OnBeforeCustLedgerEntryFind', '', false, false)]
     local procedure OnBeforeCustLedgerEntryFind(var CustLedgerEntry: Record "Cust. Ledger Entry"; ReminderHeader: Record "Reminder Header"; Customer: Record Customer)
     begin
         CustLedgerEntry.SetFilter("Global Dimension 1 Code", '');
     end; */


    [EventSubscriber(ObjectType::Report, 5685, 'OnAfterFixedAssetCopied', '', false, false)]
    local procedure OnAfterFixedAssetCopied(var FixedAsset2: Record "Fixed Asset"; var FixedAsset: Record "Fixed Asset")
    begin
        Message('Fixed Asset with no. %1 has been created.', FixedAsset2."No.");
    end;


    [EventSubscriber(ObjectType::Table, 38, 'OnBeforeInitInsert', '', false, false)]
    local procedure OnBeforeInitRecord(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean; xPurchaseHeader: Record "Purchase Header")
    var
        grecPurchPayableSetup: Record "Purchases & Payables Setup";
        gcuNoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if PurchaseHeader.Claim then begin
            grecPurchPayableSetup.Get;
            PurchaseHeader."No." := gcuNoSeriesMgt.GetNextNo(grecPurchPayableSetup."Claim No. Series", Today, TRUE);
            IsHandled := true;
        end;
    end;


    [EventSubscriber(ObjectType::report, 292, 'OnBeforeLookupSalesDoc', '', false, false)]
    local procedure OnBeforeLookupSalesDoc(var FromSalesHeader: Record "Sales Header"; var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."Sell-to Customer No." <> '' then
            FromSalesHeader.SetRange("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
    end;


    [EventSubscriber(ObjectType::Report, 292, 'OnBeforeLookupPostedShipment', '', false, false)]
    local procedure OnBeforeLookupPostedShipment(var FromSalesShptHeader: Record "Sales Shipment Header"; var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."Sell-to Customer No." <> '' then
            FromSalesShptHeader.SetRange("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
    end;


    [EventSubscriber(ObjectType::Report, 292, 'OnBeforeLookupPostedInvoice', '', false, false)]
    local procedure OnBeforeLookupPostedInvoice(var FromSalesInvHeader: Record "Sales Invoice Header"; var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."Sell-to Customer No." <> '' then
            FromSalesInvHeader.SetRange("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
    end;


    [EventSubscriber(ObjectType::Report, 292, 'OnBeforeLookupPostedReturn', '', false, false)]
    local procedure OnBeforeLookupPostedReturn(var FromReturnRcptHeader: Record "Return Receipt Header"; var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."Sell-to Customer No." <> '' then
            FromReturnRcptHeader.SetRange("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
    end;


    [EventSubscriber(ObjectType::Report, 292, 'OnBeforeLookupPostedCrMemo', '', false, false)]
    local procedure OnBeforeLookupPostedCrMemo(var FromSalesCrMemoHeader: Record "Sales Cr.Memo Header"; var SalesHeader: Record "Sales Header");
    begin
        if SalesHeader."Sell-to Customer No." <> '' then
            FromSalesCrMemoHeader.SetRange("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
    end;


    [EventSubscriber(ObjectType::Report, 292, 'OnLookupSalesArchiveOnBeforeSetFilters', '', false, false)]
    local procedure OnLookupSalesArchiveOnBeforeSetFilters(var FromSalesHeaderArchive: Record "Sales Header Archive"; var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."Sell-to Customer No." <> '' then
            FromSalesHeaderArchive.SetRange("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
    end;




    [EventSubscriber(ObjectType::report, 492, 'OnBeforeLookupPurchDoc', '', false, false)]
    local procedure OnBeforeLookupPurchDoc(var FromPurchaseHeader: Record "Purchase Header"; PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."Buy-from Vendor No." <> '' then
            FromPurchaseHeader.SetRange("Buy-from Vendor No.", PurchaseHeader."Buy-from Vendor No.");
    end;


    [EventSubscriber(ObjectType::Report, 492, 'OnBeforeLookupPostedReceipt', '', false, false)]
    local procedure OnBeforeLookupPostedReceipt(var PurchRcptHeader: Record "Purch. Rcpt. Header"; PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."Buy-from Vendor No." <> '' then
            PurchRcptHeader.SetRange("Buy-from Vendor No.", PurchaseHeader."Buy-from Vendor No.");
    end;


    [EventSubscriber(ObjectType::Report, 492, 'OnBeforeLookupPostedInvoice', '', false, false)]
    local procedure OnBeforeLookupPostedInvoice2(var FromPurchInvHeader: Record "Purch. Inv. Header"; PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."Buy-from Vendor No." <> '' then
            FromPurchInvHeader.SetRange("Buy-from Vendor No.", PurchaseHeader."Buy-from Vendor No.");
    end;


    [EventSubscriber(ObjectType::Report, 492, 'OnBeforeLookupPostedReturn', '', false, false)]
    local procedure OnBeforeLookupPostedReturn2(var FromReturnShptHeader: Record "Return Shipment Header"; PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."Buy-from Vendor No." <> '' then
            FromReturnShptHeader.SetRange("Buy-from Vendor No.", PurchaseHeader."Buy-from Vendor No.");
    end;


    [EventSubscriber(ObjectType::Report, 492, 'OnBeforeLookupPostedCrMemo', '', false, false)]
    local procedure OnBeforeLookupPostedCrMemo2(var FromPurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."Buy-from Vendor No." <> '' then
            FromPurchCrMemoHdr.SetRange("Buy-from Vendor No.", PurchaseHeader."Buy-from Vendor No.");
    end;


    [EventSubscriber(ObjectType::Report, 492, 'OnLookupPurchArchiveOnBeforeSetFilters', '', false, false)]
    local procedure OnLookupPurchArchiveOnBeforeSetFilters(var FromPurchHeaderArchive: Record "Purchase Header Archive"; var PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."Buy-from Vendor No." <> '' then
            FromPurchHeaderArchive.SetRange("Buy-from Vendor No.", PurchaseHeader."Buy-from Vendor No.");
    end;


    var
        gtextPONumber: Text;

        gtextBankAccNo: Text;
        gtextStatementNo: Text;

        Reminder: Page "Reminder List";
        Rem: Page Reminder;

        grecFixedAsset: Page "Fixed Asset Card";
}