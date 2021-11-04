pageextension 50020 PurchOrderCardExt extends "Purchase Order"
{
    layout
    {
        modify("Buy-from Country/Region Code")
        {
            Visible = false;
        }
        modify("Document Date")
        {
            Visible = false;
        }
        modify("Purchaser Code")
        {
            Visible = false;
        }
        modify("No. of Archived Versions")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Shipping and Payment")
        {
            Visible = false;
        }
        modify("Vendor Order No.")
        {
            Caption = 'Reason for Cancelling Purchase Order';
        }
        modify("Vendor Shipment No.")
        {
            Visible = false;
        }
        modify("Order Address Code")
        {
            Visible = true;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Expected Receipt Date")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = true;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Payment Terms Code")
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
        modify("Shipment Method Code")
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
        modify("On Hold")
        {
            Visible = false;
        }
        modify("Inbound Whse. Handling Time")
        {
            Visible = false;
        }
        modify("Lead Time Calculation")
        {
            Visible = false;
        }
        modify("Requested Receipt Date")
        {
            Visible = false;
        }
        modify("Promised Receipt Date")
        {
            Visible = false;
        }
        modify("Posting Description")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        modify(Prepayment)
        {
            Visible = false;
        }
        modify("Transaction Specification")
        {
            Visible = false;
        }
        modify("Buy-from Contact No.")
        {
            Visible = false;
        }
        modify("Buy-from Contact")
        {
            Visible = false;
        }
        modify("Buy-from County")
        {
            Visible = false;
        }
        modify("Transaction Type")
        {
            Visible = false;
        }
        modify("Transport Method")
        {
            Visible = false;
        }
        modify("Entry Point")
        {
            Visible = false;
        }
        modify("Area")
        {
            Visible = false;
        }
        modify("Payment Method Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Quote No.")
        {
            Visible = false;
        }
        moveafter("Buy-from Address"; "Order Address Code")
        modify("Buy-from Vendor No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                grecVendor: Record Vendor;
                gpageVendorList: Page "Vendor List";
            begin
                Clear(gpageVendorList);
                grecVendor.Reset();
                grecVendor.SetFilter("Vendor Category", '<>%1', 'TUTOR');
                if grecVendor.FindFirst() then begin
                    gpageVendorList.SetRecord(grecVendor);
                    gpageVendorList.SetTableView(grecVendor);
                    gpageVendorList.LookupMode(true);
                    if gpageVendorList.RunModal() = Action::LookupOK then begin
                        gpageVendorList.GetRecord(grecVendor);
                        Rec."VAT Bus. Posting Group" := grecVendor."No.";
                    end;
                end;
            end;
        }

        addlast(General)
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
            field("PO Category"; "PO Category")
            {
                ApplicationArea = All;
            }
            field("Procurement Method"; "Procurement Method")
            {
                ApplicationArea = All;
            }
            field("Category of Successful Bidder"; "Category of Successful Bidder")
            {
                ApplicationArea = All;
            }
            field(Price; Price) { ApplicationArea = All; }
            field(Quality; Quality) { ApplicationArea = All; }
            field(Responsiveness; Responsiveness) { ApplicationArea = All; }
            field(Delivery; Delivery) { ApplicationArea = All; }

            field("Procurement Reference No."; "Procurement Reference No.") { ApplicationArea = All; }
            field("Updated Estimated Cost (Rs)"; "Updated Estimated Cost (Rs)") { ApplicationArea = All; }
            field("Date Bidding Document Issued"; "Date Bidding Document Issued") { ApplicationArea = All; }
            field("Closing Date of Bids"; "Closing Date of Bids") { ApplicationArea = All; }
            field("Bidders Invited"; "Bidders Invited") { ApplicationArea = All; }
            field("No of SMEs Invited"; "No of SMEs Invited") { ApplicationArea = All; }
            field("No. of Bids Received"; "No. of Bids Received") { ApplicationArea = All; }
            field("No of Bids Received from SMEs"; "No of Bids Received from SMEs") { ApplicationArea = All; }
            field("No. of Responsive Bids"; "No. of Responsive Bids") { ApplicationArea = All; }
            field("Challenge  (Y/N)"; "Challenge  (Y/N)") { ApplicationArea = All; }
            field("Date Contract Awarded"; "Date Contract Awarded") { ApplicationArea = All; }
            field("Type of Procurement"; "Type of Procurement") { ApplicationArea = All; }
            field("Margin Preference benefitted"; "Margin Preference benefitted") { ApplicationArea = All; }
            field("Contract Amount Approved (Rs)"; "Contract Amount Approved (Rs)") { ApplicationArea = All; }
            field(BRN; BRN) { ApplicationArea = All; }
            field("Request for Purchase No."; "Request for Purchase No.") { ApplicationArea = All; }
            field("Request Dated"; "Request Dated") { ApplicationArea = All; }
            field("Validated By"; "Validated By") { ApplicationArea = All; }
            field("Validated On"; "Validated On") { ApplicationArea = All; }

        }

        addafter(PurchLines)
        {
            group(Earmarking)
            {
                //field("Earmark ID"; "Earmark ID") { ApplicationArea = All; }
                field(Earmarked; Earmarked) { ApplicationArea = All; }
                //field("Date Earmarked"; "Date Earmarked") { ApplicationArea = All; }
                field("Amount Earmarked"; "Amount Earmarked") { ApplicationArea = All; }
            }

            group(Information)
            {
                field("Shipping Instructions"; "Shipping Instructions") { ApplicationArea = All; }
                field("Special Instruction"; "Special Instruction") { ApplicationArea = All; }
                field("Terms and Conditions"; "Terms and Conditions") { ApplicationArea = All; }
                field("Requested Delivery Date"; "Requested Delivery Date") { ApplicationArea = All; }
                field("Actual Delivery Date"; "Actual Delivery Date") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        modify("&Print")
        {
            trigger OnBeforeAction()
            var
                gtextError: TextConst ENU = 'Purchase Order should be released before printing.';
                grepPurchaseOrder: Report "Purchase Order";
                grecPurchHdr: Record "Purchase Header";
            begin
                if Rec.Status <> Rec.Status::Released then
                    error(gtextError);


                /*if ("Validated By" = '') or ("Validated On" = 0DT) then
                    Error('Please validate purchase order to be able to proceed.');*/

                /* grecPurchHdr.Reset();
                grecPurchHdr.SetRange("No.", "No.");
                if grecPurchHdr.FindFirst() then begin
                    grepPurchaseOrder.SetTableView(grecPurchHdr);
                    grepPurchaseOrder.SetTitle2('ORIGINAL');
                    grepPurchaseOrder.UseRequestPage := false;
                    grepPurchaseOrder.Run();

                    grepPurchaseOrder.SetTableView(grecPurchHdr);
                    grepPurchaseOrder.SetTitle2('DUPLICATE');
                    grepPurchaseOrder.UseRequestPage := false;
                    grepPurchaseOrder.Run();

                    grepPurchaseOrder.SetTableView(grecPurchHdr);
                    grepPurchaseOrder.SetTitle2('TRIPLICATE');
                    grepPurchaseOrder.UseRequestPage := false;
                    grepPurchaseOrder.Run();

                    grepPurchaseOrder.SetTableView(grecPurchHdr);
                    grepPurchaseOrder.SetTitle2('QUADRUPLICATE');
                    grepPurchaseOrder.UseRequestPage := false;
                    grepPurchaseOrder.Run();
                end;
                Error(''); */
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

        modify(SendCustom)
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

        addlast("O&rder")
        {

            action("Validate Purchase Order")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                Image = ValidateEmailLoggingSetup;

                trigger OnAction()
                var
                    grecUserSetup: Record "User Setup";
                begin
                    if grecUserSetup.Get(UserId) then begin
                        if grecUserSetup."Validate Purchase Orders" then begin
                            if Status = Status::Released then begin
                                "Validated By" := UserId;
                                "Validated On" := CurrentDateTime;
                                Modify();
                            end else
                                Error('Purchase order should be released before validation.');
                        end else
                            Error('You do not have access to this option.');
                    end else
                        Error('You do not have access to this option.');
                end;
            }


            action("Clear Validated Purchase Order")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                Image = ClearLog;

                trigger OnAction()
                var
                    grecUserSetup: Record "User Setup";
                begin
                    if grecUserSetup.Get(UserId) then begin
                        if grecUserSetup."Clear Validated Purchase Order" then begin
                            "Validated By" := '';
                            "Validated On" := 0DT;
                            Modify();
                        end else
                            Error('You do not have access to this option.');
                    end else
                        Error('You do not have access to this option.');
                end;
            }


            action("Cancel Purchase Order")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                Image = Cancel;

                trigger OnAction()
                var
                    gcuArchivePO: Codeunit ArchivePurchOrder;
                begin
                    if grecUserSetup.Get(UserId) then begin
                        if grecUserSetup."Can Close Purchase Order" then begin
                            IF Rec."Vendor Order No." = '' then
                                ERROR(gtextVendorOrderNo);
                            IF Confirm(gtextConfirm, true, Rec."No.") then begin
                                grecPurchLine.Reset();
                                grecPurchLine.SetRange("Document No.", Rec."No.");
                                if grecPurchLine.FindSet() then begin
                                    repeat
                                        if grecPurchLine."Quantity Received" <> grecPurchLine."Quantity Invoiced" then
                                            Error(gtextError1, grecPurchLine."Line No.");
                                    until grecPurchLine.Next() = 0;
                                end;

                                /* if Rec.Status = Rec.Status::Released then
                                    gCUCheckReleaseReopenOnPurchase.UpdateBudgetPlus(Rec); */

                                gcuArchivePO.CheckifCancelled(true);
                                gcuArchiveManagement.StorePurchDocument(Rec, false);
                                gcuArchivePO.ClearCancelled();
                                gcodePurchNo := Rec."No.";

                                grecPurchLine2.Reset();
                                grecPurchLine2.SetRange("Document No.", Rec."No.");
                                grecPurchLine2.DeleteAll();

                                if grecPurchHdr.get(grecPurchHdr."Document Type"::Order, Rec."No.") then
                                    grecPurchHdr.Delete();

                                Message(gtextArchive, Rec."No.");
                            end;
                        end else
                            Error('You do not have permission to cancel Purchase Order.');
                    end else
                        Error('You do not have permission to cancel Purchase Order.');
                end;
            }
        }
    }

    var
        grecPurchLine: Record "Purchase Line";
        gtextConfirm: TextConst ENU = 'Do you want to cancel Purchase Order No. %1?';
        gtextError1: TextConst ENU = 'Fields "Qty Received" and "Qty Invoiced" are not the same on Line No. %1.';
        gcuArchiveManagement: Codeunit ArchiveManagement;
        gtextArchive: TextConst ENU = 'The Purchase Order No. %1 has been cancelled.';
        gtextVendorOrderNo: TextConst ENU = 'Please insert Reason for cancelling Purchase Order.';
        gcodePurchNo: Code[20];
        grecPurchHdr: Record "Purchase Header";
        grecPurchLine2: Record "Purchase Line";
        grecUserSetup: Record "User Setup";
        gCUCheckReleaseReopenOnPurchase: Codeunit CheckReleaseReopenOnPurchase;
}