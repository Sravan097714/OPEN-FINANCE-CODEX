page 50059 "Resit Fee From OU Portal"
{
    PageType = List;
    //ApplicationArea = All;
    //UsageCategory = Lists;
    SourceTable = "Exemption/Resit Fee OU Portal";
    SourceTableView = where(Resit = filter(true));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater("Resit Fees")
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
            action("Upload Resit Fee")
            {
                ApplicationArea = All;
                Image = ImportExcel;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Report.Run(50090);
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
                        grecResitFromOUPortal.Reset();
                        grecResitFromOUPortal.SetRange(Resit, true);
                        if grecResitFromOUPortal.FindFirst() then
                            grecResitFromOUPortal.DeleteAll();
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
        grecResitFromOUPortal.Reset();
        if grecResitFromOUPortal.FindSet then begin
            repeat
                if grecResitFromOUPortal."Student ID" <> '' then begin
                    if not grecCustomer.get(grecResitFromOUPortal."Student ID") then
                        grecResitFromOUPortal.Error := 'Student ID does not exist on the Accounting System.';
                end;

                if grecResitFromOUPortal."No." <> '' then begin
                    IF not grecItem.Get(grecResitFromOUPortal."No.") THEN
                        grecResitFromOUPortal.Error := StrSubstNo(glblModuleError, grecResitFromOUPortal."No.");
                end;

                grecGenLedgSetup.Get();
                if grecResitFromOUPortal."Shortcut Dimension 1 Code" <> '' then begin
                    if not grecDimValue.Get(grecGenLedgSetup."Global Dimension 1 Code", grecResitFromOUPortal."Shortcut Dimension 1 Code") then
                        grecResitFromOUPortal.Error := StrSubstNo(glblDimError, grecResitFromOUPortal."Shortcut Dimension 1 Code");
                end;

                if grecResitFromOUPortal."Shortcut Dimension 2 Code" <> '' then begin
                    if not grecDimValue.Get(grecGenLedgSetup."Global Dimension 2 Code", grecResitFromOUPortal."Shortcut Dimension 2 Code") then
                        grecResitFromOUPortal.Error := StrSubstNo(glblDimError, grecResitFromOUPortal."Shortcut Dimension 2 Code");
                end;

                if grecResitFromOUPortal.Error = '' then begin
                    grecResitFromOUPortal.Validated := true;
                    gintCounter2 += 1;
                end;

                grecResitFromOUPortal.Modify();
            until grecResitFromOUPortal.Next = 0;
            Message('%1 lines have been validated out of %2', gintCounter2, grecResitFromOUPortal.Count);
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
        grecResitFromOUPortal2.Reset();
        grecResitFromOUPortal2.SetRange(Resit, true);
        grecResitFromOUPortal2.SetCurrentKey("Line No.");
        grecResitFromOUPortal2.SetRange(Validated, true);
        if grecResitFromOUPortal2.FindSet then begin
            repeat
                gintCounter += 1;
                grecSalesHeader.Init;
                grecSalesHeader."No." := NoSeriesMgt.GetNextNo(SalesReceivableSetup."Posted Inv Nos. for OU Portal", Today, TRUE);
                grecSalesHeader.Validate("Document Type", grecSalesHeader."Document Type"::Invoice);
                grecSalesHeader.validate("Sell-to Customer No.", grecResitFromOUPortal2."Student ID");
                grecSalesHeader.Validate("Posting Date", grecResitFromOUPortal2."Date Processed");
                grecSalesHeader.Insert(true);
                grecSalesHeader.Validate("Shortcut Dimension 1 Code", grecResitFromOUPortal2."Shortcut Dimension 1 Code");
                grecSalesHeader.Validate("Shortcut Dimension 2 Code", grecResitFromOUPortal2."Shortcut Dimension 2 Code");
                grecSalesHeader."First Name" := grecResitFromOUPortal2."First Name";
                grecSalesHeader."Last Name" := grecResitFromOUPortal2."Last Name";
                grecSalesHeader."Maiden Name" := grecResitFromOUPortal2."Maiden Name";
                grecSalesHeader.RDAP := grecResitFromOUPortal2.RDAP;
                grecSalesHeader."Payment Semester" := grecResitFromOUPortal2."Payment Semester";
                grecSalesHeader."From OU Portal" := true;
                //grecSalesHeader."Portal Payment Mode" := grecResitFromOUPortal2."Payment Mode";
                grecSalesHeader."Payment Date" := grecResitFromOUPortal2."Date Processed";
                grecSalesHeader.Remark := grecResitFromOUPortal2.Remarks;

                grecCustPostingGrp.Reset();
                grecCustPostingGrp.SetRange(Code);
                if grecCustPostingGrp.FindSet then begin
                    repeat
                        if (grecCustPostingGrp."Start Date" >= Today) AND (grecCustPostingGrp."End Date" <= Today) then
                            grecSalesHeader.Validate("Customer Posting Group", grecCustPostingGrp.Code);
                    until grecCustPostingGrp.Next = 0;
                end;

                grecSalesHeader.Modify();

                if grecResitFromOUPortal2."No." <> '' then
                    CreateSalesInvoiceLine(grecSalesHeader."No.", grecResitFromOUPortal2."No.", grecResitFromOUPortal2."Common Module Code", grecResitFromOUPortal2."No." + ' - ' + grecResitFromOUPortal2."Module Description", grecResitFromOUPortal2."Module Credit", grecResitFromOUPortal2."Shortcut Dimension 1 Code");

                grecResitFromOUPortal2.Delete();
            until grecResitFromOUPortal2.Next = 0;
            Message('%1 Sales Invoices have been created for Resit Fees.', gintCounter);
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
        grecResitFromOUPortal: Record "Exemption/Resit Fee OU Portal";
        grecResitFromOUPortal2: Record "Exemption/Resit Fee OU Portal";
        grecResitFromOUPortal3: Record "Exemption/Resit Fee OU Portal";
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
