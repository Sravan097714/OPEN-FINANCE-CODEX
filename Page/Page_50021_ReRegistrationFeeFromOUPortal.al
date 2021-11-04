page 50021 "ReReg. Fee From OU Portal"
{
    PageType = List;
    //ApplicationArea = All;
    //UsageCategory = Lists;
    SourceTable = "ReRegistration Fee OU Portal";
    Caption = 'ReRegistration Fee From OU Portal';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater("Re-Registration Fees")
            {
                field(PTN; PTN) { ApplicationArea = All; }
                field(Status; Status) { ApplicationArea = All; }
                field(RDAP; RDAP) { ApplicationArea = All; }
                field("Student ID"; "Student ID") { ApplicationArea = All; }
                field("First Name"; "First Name") { ApplicationArea = All; }
                field("Last Name"; "Last Name") { ApplicationArea = All; }
                field("Maiden Name"; "Maiden Name") { ApplicationArea = All; }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code") { ApplicationArea = All; }
                field("Payment Semester"; "Payment Semester") { ApplicationArea = All; }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code") { ApplicationArea = All; }

                field("Module Description"; "Module Description") { ApplicationArea = All; }
                field("No."; "No.") { ApplicationArea = All; }
                field("Common Module Code"; "Common Module Code") { ApplicationArea = All; }
                field("Module Credit"; "Module Credit") { ApplicationArea = All; }
                field("Module Amount"; "Module Amount") { ApplicationArea = All; }
                field("Module Fee Ins"; "Module Fee Ins") { ApplicationArea = All; }

                field(Currency; Currency) { ApplicationArea = All; }
                field(Total; Total) { ApplicationArea = All; }
                field("Penalty Fee"; "Penalty Fee") { ApplicationArea = All; }
                field("Net Total"; "Net Total") { ApplicationArea = All; }
                field("Payment For"; "Payment For") { ApplicationArea = All; }
                field("Payment Type"; "Payment Type") { ApplicationArea = All; }
                field("Date Paid On"; "Date Paid On") { ApplicationArea = All; }
                field("Date Processed"; "Date Processed") { ApplicationArea = All; }
                field("MyT Money Ref"; "MyT Money Ref") { ApplicationArea = All; }
                field("MyT Money Ref Staff"; "MyT Money Ref Staff") { ApplicationArea = All; }
                field(Remarks; Remarks) { ApplicationArea = All; }

                field(Error; Error)
                {
                    Style = Unfavorable;
                    ApplicationArea = All;
                }
                field(Validated; Validated) { ApplicationArea = All; }
                field("Imported By"; "Imported By") { ApplicationArea = All; }
                field("Imported On"; "Imported On") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Upload ReRegistration Fee")
            {
                ApplicationArea = All;
                Image = ImportExcel;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Report.Run(50034);
                end;
            }

            action("Validate")
            {
                ApplicationArea = All;
                Image = ValidateEmailLoggingSetup;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ValidateData();
                end;
            }

            action("Create Sales Invoice")
            {
                ApplicationArea = All;
                Image = CreateJobSalesInvoice;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CreateSalesInvoice();
                end;
            }

            action(Delete)
            {
                ApplicationArea = All;
                Image = Delete;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Do you want to delete all the lines.', true) then
                        Rec.DeleteAll();
                end;
            }
        }
    }


    local procedure ValidateData()
    var
        gintCounter2: Integer;
    begin
        grecSalesReceivableSetup.Get();
        grecReRegistrationFromOUPortal.Reset();
        if grecReRegistrationFromOUPortal.FindSet then begin
            repeat
                if grecReRegistrationFromOUPortal."Student ID" <> '' then begin
                    if not grecCustomer.get(grecReRegistrationFromOUPortal."Student ID") then
                        grecReRegistrationFromOUPortal.Error := 'Student ID does not exist on the Accounting System.';
                end;

                if grecReRegistrationFromOUPortal."No." <> '' then begin
                    IF not grecItem.Get(grecReRegistrationFromOUPortal."No.") THEN
                        grecReRegistrationFromOUPortal.Error := StrSubstNo(glblModuleError, grecReRegistrationFromOUPortal."No.");
                end;

                grecGenLedgSetup.Get();
                if grecReRegistrationFromOUPortal."Shortcut Dimension 1 Code" <> '' then begin
                    if not grecDimValue.Get(grecGenLedgSetup."Global Dimension 1 Code", grecReRegistrationFromOUPortal."Shortcut Dimension 1 Code") then
                        grecReRegistrationFromOUPortal.Error := StrSubstNo(glblDimError, grecReRegistrationFromOUPortal."Shortcut Dimension 1 Code");
                end;

                if grecReRegistrationFromOUPortal."Shortcut Dimension 2 Code" <> '' then begin
                    if not grecDimValue.Get(grecGenLedgSetup."Global Dimension 2 Code", grecReRegistrationFromOUPortal."Shortcut Dimension 2 Code") then
                        grecReRegistrationFromOUPortal.Error := StrSubstNo(glblDimError, grecReRegistrationFromOUPortal."Shortcut Dimension 2 Code");
                end;

                grecReRegistrationFromOUPortal3.reset;
                grecReRegistrationFromOUPortal3.SetRange(PTN, grecReRegistrationFromOUPortal.PTN);
                grecReRegistrationFromOUPortal3.SetFilter(Error, '<>%1', '');
                if grecReRegistrationFromOUPortal3.FindFirst() then
                    grecReRegistrationFromOUPortal.Error := 'One or more line with the same PTN Number has an error.';

                grecReRegistrationFromOUPortal3.reset;
                grecReRegistrationFromOUPortal3.SetRange(PTN, grecReRegistrationFromOUPortal.PTN);
                grecReRegistrationFromOUPortal3.SetFilter("No.", '<>%1', '');
                //grecReRegistrationFromOUPortal3.SetFilter(Error, '<>%1', '');
                if grecReRegistrationFromOUPortal3.Count = 0 then
                    grecReRegistrationFromOUPortal.Error := 'There are no module code on this line.';

                if grecReRegistrationFromOUPortal.Error = '' then begin
                    grecReRegistrationFromOUPortal.Validated := true;
                    gintCounter2 += 1;
                end;

                grecReRegistrationFromOUPortal.Modify();
            until grecReRegistrationFromOUPortal.Next = 0;
            Message('%1 lines have been validated out of %2', gintCounter2, grecReRegistrationFromOUPortal.Count);
        end;
    end;


    local procedure CreateSalesInvoice()
    var
        ltextPTN: Text[25];
        gintCounter: Integer;
        grecCustPostingGrp: Record "Customer Posting Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesReceivableSetup: Record "Sales & Receivables Setup";
    begin
        Clear(gdatePostingDate);
        Clear(gcodeCustomerno);
        clear(ltextPTN);
        SalesReceivableSetup.Get;
        grecReRegistrationFromOUPortal2.Reset();
        grecReRegistrationFromOUPortal2.SetCurrentKey("Line No.");
        grecReRegistrationFromOUPortal2.SetRange(Validated, true);
        if grecReRegistrationFromOUPortal2.FindSet then begin
            repeat
                if grecReRegistrationFromOUPortal2.PTN <> ltextPTN then begin
                    gintCounter += 1;
                    grecSalesHeader.Init;
                    grecSalesHeader."No." := NoSeriesMgt.GetNextNo(SalesReceivableSetup."Posted Inv Nos. for OU Portal", Today, TRUE);
                    grecSalesHeader.Validate("Document Type", grecSalesHeader."Document Type"::Invoice);
                    grecSalesHeader.validate("Sell-to Customer No.", grecReRegistrationFromOUPortal2."Student ID");
                    grecSalesHeader.Validate("Posting Date", grecReRegistrationFromOUPortal2."Date Processed");
                    grecSalesHeader.Insert(true);
                    grecSalesHeader.Validate("Shortcut Dimension 1 Code", grecReRegistrationFromOUPortal2."Shortcut Dimension 1 Code");
                    grecSalesHeader.Validate("Shortcut Dimension 2 Code", grecReRegistrationFromOUPortal2."Shortcut Dimension 2 Code");
                    grecSalesHeader."First Name" := grecReRegistrationFromOUPortal2."First Name";
                    grecSalesHeader."Last Name" := grecReRegistrationFromOUPortal2."Last Name";
                    grecSalesHeader."Maiden Name" := grecReRegistrationFromOUPortal2."Maiden Name";
                    grecSalesHeader.RDAP := grecReRegistrationFromOUPortal2.RDAP;
                    grecSalesHeader.PTN := grecReRegistrationFromOUPortal2.PTN;
                    grecSalesHeader."Payment Semester" := grecReRegistrationFromOUPortal2."Payment Semester";
                    grecSalesHeader."From OU Portal" := true;

                    if (grecReRegistrationFromOUPortal2.Currency <> '') and (grecReRegistrationFromOUPortal2.Currency <> 'Rs') then
                        grecSalesHeader."Currency Code" := 'USD';

                    grecSalesHeader."Gov Grant" := grecReRegistrationFromOUPortal2."Gov Grant";
                    grecSalesHeader.Instalment := grecReRegistrationFromOUPortal2.Instalment;
                    grecSalesHeader."Payment Amount" := grecReRegistrationFromOUPortal2."Net Total";
                    grecSalesHeader."Portal Payment Mode" := grecReRegistrationFromOUPortal2."Payment Type";
                    grecSalesHeader."MyT Money Ref" := grecReRegistrationFromOUPortal2."MyT Money Ref";
                    grecSalesHeader."MyT Merchant Trade No." := grecReRegistrationFromOUPortal2."MyT Money Ref Staff";
                    grecSalesHeader."Payment Date" := grecReRegistrationFromOUPortal2."Date Paid On";

                    grecCustPostingGrp.Reset();
                    grecCustPostingGrp.SetRange(Code);
                    if grecCustPostingGrp.FindSet then begin
                        repeat
                            if (grecCustPostingGrp."Start Date" >= Today) AND (grecCustPostingGrp."End Date" <= Today) then
                                grecSalesHeader.Validate("Customer Posting Group", grecCustPostingGrp.Code);
                        until grecCustPostingGrp.Next = 0;
                    end;

                    grecSalesHeader.Modify();
                end;

                if grecReRegistrationFromOUPortal2.PTN <> '' then
                    ltextPTN := grecReRegistrationFromOUPortal2.PTN;

                if grecReRegistrationFromOUPortal2."No." <> '' then
                    CreateSalesInvoiceLine(grecSalesHeader."No.", grecReRegistrationFromOUPortal2."No.", grecReRegistrationFromOUPortal2."Common Module Code", grecReRegistrationFromOUPortal2."Module Description", grecReRegistrationFromOUPortal2."Module Amount", grecReRegistrationFromOUPortal2."Shortcut Dimension 1 Code", grecReRegistrationFromOUPortal2.Instalment, grecReRegistrationFromOUPortal2."Module Fee Ins", grecReRegistrationFromOUPortal2."Penalty Fee");

                grecReRegistrationFromOUPortal2.Delete();
            until grecReRegistrationFromOUPortal2.Next = 0;
            Message('%1 Sales Invoices have been created for Re-registration Fees.', gintCounter);
        end else
            Message('Please validate lines before creating sales invoices.');
    end;


    local procedure CreateSalesInvoiceLine(pcodeDocNo: Code[20]; pcodeModuleNo: Code[20]; pcodeCommonModuleCode: Code[20]; ptextDescription: Text[250]; pdecAmount: Decimal; DimValue1: Code[20]; pboolInstalment: Boolean; pdecInstalmentAmt: Decimal; pdecPenaltyFee: Decimal)
    var
        grecDimValue: Record "Dimension Value";
    begin
        grecSalesLine.Init;
        grecSalesLine."Document No." := pcodeDocNo;
        grecSalesLine.Validate("Document Type", grecSalesLine."Document Type"::Invoice);
        grecSalesLine.Validate(Type, grecSalesLine.Type::Item);
        grecSalesLine.Validate("No.", pcodeModuleNo);
        grecSalesLine.Description := ptextDescription;

        if pboolInstalment then begin
            grecSalesLine.Validate("Unit Price", pdecInstalmentAmt);
            grecSalesLine.Instalment := pboolInstalment;
            grecSalesLine."Original Amount" := pdecAmount;
        end else
            grecSalesLine.Validate("Unit Price", pdecAmount);

        grecSalesLine.Validate(Quantity, 1);
        grecSalesLine."Common Module Code" := pcodeCommonModuleCode;

        grecSalesLine2.reset;
        grecSalesLine2.SetRange("Document No.", pcodeDocNo);
        if not grecSalesLine2.FindLast then
            grecSalesLine."Line No." := 10000
        else
            grecSalesLine."Line No." := grecSalesLine2."Line No." + 10000;


        /* grecDimValue.Reset();
        grecDimValue.SetRange(Code, DimValue1);
        if grecDimValue.FindFirst() then begin
            grecSalesLine.Validate("Gen. Prod. Posting Group", grecDimValue."Gen. Prod. Posting Group");
        end; */

        grecSalesLine.Insert(true);

        if pdecPenaltyFee > 0 then
            InsertPenaltyFee(pcodeDocNo, pdecPenaltyFee);
    end;


    local procedure InsertPenaltyFee(pcodeDocNo: Code[20]; pdecPenaltyFee: Decimal)
    begin
        grecSalesReceivableSetup.Get;

        grecSalesLine.Init;
        grecSalesLine."Document No." := pcodeDocNo;
        grecSalesLine.Validate("Document Type", grecSalesLine."Document Type"::Invoice);
        grecSalesLine.Validate(Type, grecSalesLine.Type::"G/L Account");
        grecSalesLine.Validate("No.", grecSalesReceivableSetup."G/L for Penalty Fee");
        grecSalesLine.Validate("Unit Price", pdecPenaltyFee);
        grecSalesLine.Validate(Quantity, 1);

        grecSalesLine2.reset;
        grecSalesLine2.SetRange("Document No.", pcodeDocNo);
        if not grecSalesLine2.FindLast then
            grecSalesLine."Line No." := 10000
        else
            grecSalesLine."Line No." := grecSalesLine2."Line No." + 10000;

        /* grecDimValue.Reset();
        grecDimValue.SetRange(Code, DimValue1);
        if grecDimValue.FindFirst() then begin
            grecSalesLine.Validate("Gen. Prod. Posting Group", grecDimValue."Gen. Prod. Posting Group");
        end; */

        grecSalesLine.Insert(true);
    end;



    var
        grecReRegistrationFromOUPortal: Record "ReRegistration Fee OU Portal";
        grecReRegistrationFromOUPortal2: Record "ReRegistration Fee OU Portal";
        grecReRegistrationFromOUPortal3: Record "ReRegistration Fee OU Portal";
        EntryNo: Integer;
        grecSalesHeader: Record "Sales Header";
        grecSalesLine: Record "Sales Line";
        grecSalesLine2: Record "Sales Line";
        gtextSalesOrderNo: Text[50];
        gcodeCustomerno: code[20];
        gdatePostingDate: Date;
        grecCustomer: Record Customer;
        grecItem: Record Item;
        grecSalesReceivableSetup: Record "Sales & Receivables Setup";
        grecGenLedgSetup: Record "General Ledger Setup";
        grecDimValue: Record "Dimension Value";
        glblDimError: Label '%1 does not exist.';
        glblModuleError: Label 'Module code %1 does not exist.';
}
