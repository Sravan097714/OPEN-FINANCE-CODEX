page 50058 "Exemption Fee From OU Portal"
{
    PageType = List;
    //ApplicationArea = All;
    //UsageCategory = Lists;
    SourceTable = "Exemption/Resit Fee OU Portal";
    SourceTableView = where(Exemption = filter(true));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater("Exemption Fees")
            {
                field("User ID"; "User ID") { ApplicationArea = All; }
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
                field("Date Processed"; "Date Processed") { ApplicationArea = All; }
                field("Payment Mode"; "Payment Mode") { ApplicationArea = All; }
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
            action("Upload Exemption Fee")
            {
                ApplicationArea = All;
                Image = ImportExcel;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Report.Run(50089);
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
                    if Confirm('Do you want to delete all the lines.', true) then begin
                        grecExemptionFromOUPortal.Reset();
                        grecExemptionFromOUPortal.SetRange(Exemption, true);
                        if grecExemptionFromOUPortal.FindFirst() then
                            grecExemptionFromOUPortal.DeleteAll();
                    end;
                end;
            }
        }
    }


    local procedure ValidateData()
    var
        gintCounter2: Integer;
    begin
        grecSalesReceivableSetup.Get();
        grecExemptionFromOUPortal.Reset();
        if grecExemptionFromOUPortal.FindSet then begin
            repeat
                if grecExemptionFromOUPortal."Student ID" <> '' then begin
                    if not grecCustomer.get(grecExemptionFromOUPortal."Student ID") then
                        grecExemptionFromOUPortal.Error := 'Student ID does not exist on the Accounting System.';
                end;

                if grecExemptionFromOUPortal."No." <> '' then begin
                    IF not grecItem.Get(grecExemptionFromOUPortal."No.") THEN
                        grecExemptionFromOUPortal.Error := StrSubstNo(glblModuleError, grecExemptionFromOUPortal."No.");
                end;

                grecGenLedgSetup.Get();
                if grecExemptionFromOUPortal."Shortcut Dimension 1 Code" <> '' then begin
                    if not grecDimValue.Get(grecGenLedgSetup."Global Dimension 1 Code", grecExemptionFromOUPortal."Shortcut Dimension 1 Code") then
                        grecExemptionFromOUPortal.Error := StrSubstNo(glblDimError, grecExemptionFromOUPortal."Shortcut Dimension 1 Code");
                end;

                if grecExemptionFromOUPortal."Shortcut Dimension 2 Code" <> '' then begin
                    if not grecDimValue.Get(grecGenLedgSetup."Global Dimension 2 Code", grecExemptionFromOUPortal."Shortcut Dimension 2 Code") then
                        grecExemptionFromOUPortal.Error := StrSubstNo(glblDimError, grecExemptionFromOUPortal."Shortcut Dimension 2 Code");
                end;

                if grecExemptionFromOUPortal.Error = '' then begin
                    grecExemptionFromOUPortal.Validated := true;
                    gintCounter2 += 1;
                end;

                grecExemptionFromOUPortal.Modify();
            until grecExemptionFromOUPortal.Next = 0;
            Message('%1 lines have been validated out of %2', gintCounter2, grecExemptionFromOUPortal.Count);
        end;
    end;


    local procedure CreateSalesInvoice()
    var
        gintCounter: Integer;
        grecCustPostingGrp: Record "Customer Posting Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesReceivableSetup: Record "Sales & Receivables Setup";
    begin
        Clear(gdatePostingDate);
        Clear(gcodeCustomerno);
        SalesReceivableSetup.Get;
        grecExemptionFromOUPortal2.Reset();
        grecExemptionFromOUPortal2.SetCurrentKey("Line No.");
        grecExemptionFromOUPortal2.SetRange(Exemption, true);
        grecExemptionFromOUPortal2.SetRange(Validated, true);
        if grecExemptionFromOUPortal2.FindSet then begin
            repeat
                gintCounter += 1;
                grecSalesHeader.Init;
                grecSalesHeader."No." := NoSeriesMgt.GetNextNo(SalesReceivableSetup."Posted Inv Nos. for OU Portal", Today, TRUE);
                grecSalesHeader.Validate("Document Type", grecSalesHeader."Document Type"::Invoice);
                grecSalesHeader.validate("Sell-to Customer No.", grecExemptionFromOUPortal2."Student ID");
                grecSalesHeader.Validate("Posting Date", grecExemptionFromOUPortal2."Date Processed");
                grecSalesHeader.Insert(true);
                grecSalesHeader.Validate("Shortcut Dimension 1 Code", grecExemptionFromOUPortal2."Shortcut Dimension 1 Code");
                grecSalesHeader.Validate("Shortcut Dimension 2 Code", grecExemptionFromOUPortal2."Shortcut Dimension 2 Code");
                grecSalesHeader."First Name" := grecExemptionFromOUPortal2."First Name";
                grecSalesHeader."Last Name" := grecExemptionFromOUPortal2."Last Name";
                grecSalesHeader."Maiden Name" := grecExemptionFromOUPortal2."Maiden Name";
                grecSalesHeader.RDAP := grecExemptionFromOUPortal2.RDAP;
                grecSalesHeader."Payment Semester" := grecExemptionFromOUPortal2."Payment Semester";
                grecSalesHeader."From OU Portal" := true;
                grecSalesHeader."Portal Payment Mode" := grecExemptionFromOUPortal2."Payment Mode";
                grecSalesHeader."Payment Date" := grecExemptionFromOUPortal2."Date Processed";
                grecSalesHeader.Remark := grecExemptionFromOUPortal2.Remarks;

                grecCustPostingGrp.Reset();
                grecCustPostingGrp.SetRange(Code);
                if grecCustPostingGrp.FindSet then begin
                    repeat
                        if (grecCustPostingGrp."Start Date" >= Today) AND (grecCustPostingGrp."End Date" <= Today) then
                            grecSalesHeader.Validate("Customer Posting Group", grecCustPostingGrp.Code);
                    until grecCustPostingGrp.Next = 0;
                end;

                grecSalesHeader.Modify();

                if grecExemptionFromOUPortal2."No." <> '' then
                    CreateSalesInvoiceLine(grecSalesHeader."No.", grecExemptionFromOUPortal2."No.", grecExemptionFromOUPortal2."Common Module Code", grecExemptionFromOUPortal2."No." + ' - ' + grecExemptionFromOUPortal2."Module Description", grecExemptionFromOUPortal2."Module Credit", grecExemptionFromOUPortal2."Shortcut Dimension 1 Code");

                grecExemptionFromOUPortal2.Delete();
            until grecExemptionFromOUPortal2.Next = 0;
            Message('%1 Sales Invoices have been created for Exemption Fees.', gintCounter);
        end else
            Message('Please validate lines before creating sales invoices.');
    end;


    local procedure CreateSalesInvoiceLine(pcodeDocNo: Code[20]; pcodeModuleNo: Code[20]; pcodeCommonModuleCode: Code[20]; ptextDescription: Text[250]; pdecModuleCredit: Decimal; DimValue1: Code[20])
    var
        grecDimValue: Record "Dimension Value";
        grecSalesReceivableSetup2: Record "Sales & Receivables Setup";
    begin
        grecSalesReceivableSetup2.get;
        grecSalesLine.Init;
        grecSalesLine."Document No." := pcodeDocNo;
        grecSalesLine.Validate("Document Type", grecSalesLine."Document Type"::Invoice);
        grecSalesLine.Validate(Type, grecSalesLine.Type::"G/L Account");
        grecSalesLine.Validate("No.", grecSalesReceivableSetup2."G/L for Exemption Fee");
        grecSalesLine."Description 2" := ptextDescription;
        grecSalesLine.Validate("Unit Price", grecSalesReceivableSetup2."Exemption Amount");
        grecSalesLine.Validate(Quantity, 1);
        grecSalesLine."Common Module Code" := pcodeCommonModuleCode;
        //grecSalesLine.credit := pdecModuleCredit;

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
        grecExemptionFromOUPortal: Record "Exemption/Resit Fee OU Portal";
        grecExemptionFromOUPortal2: Record "Exemption/Resit Fee OU Portal";
        grecExemptionFromOUPortal3: Record "Exemption/Resit Fee OU Portal";
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
