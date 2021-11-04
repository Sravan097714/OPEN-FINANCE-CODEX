page 50018 "Module Fee from OU Portal"
{
    PageType = List;
    //ApplicationArea = All;
    SourceTable = "Module Fee From OU Portal";
    //UsageCategory = Administration;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater("Module Fees")
            {
                field("Line No."; "Line No.") { ApplicationArea = All; }
                field("Posting Date"; "Posting Date") { ApplicationArea = All; }
                field("Learner ID"; "Learner ID") { ApplicationArea = All; }

                field("No. 1"; "No. 1") { ApplicationArea = All; }
                field("Common Module Code 1"; "Common Module Code 1") { ApplicationArea = All; }
                field("Module Description 1"; "Module Description 1") { ApplicationArea = All; }
                field("Module Amount 1"; "Module Amount 1") { ApplicationArea = All; }
                field("Module 1 Fee Ins"; "Module 1 Fee Ins") { ApplicationArea = All; }
                field("Module Credit 1"; "Module Credit 1") { ApplicationArea = All; }

                field("No. 2"; "No. 2") { ApplicationArea = All; }
                field("Common Module Code 2"; "Common Module Code 2") { ApplicationArea = All; }
                field("Module Description 2"; "Module Description 2") { ApplicationArea = All; }
                field("Module Amount 2"; "Module Amount 2") { ApplicationArea = All; }
                field("Module 2 Fee Ins"; "Module 2 Fee Ins") { ApplicationArea = All; }
                field("Module Credit 2"; "Module Credit 2") { ApplicationArea = All; }

                field("No. 3"; "No. 3") { ApplicationArea = All; }
                field("Common Module Code 3"; "Common Module Code 3") { ApplicationArea = All; }
                field("Module Description 3"; "Module Description 3") { ApplicationArea = All; }
                field("Module Amount 3"; "Module Amount 3") { ApplicationArea = All; }
                field("Module 3 Fee Ins"; "Module 3 Fee Ins") { ApplicationArea = All; }
                field("Module Credit 3"; "Module Credit 3") { ApplicationArea = All; }

                field("No. 4"; "No. 4") { ApplicationArea = All; }
                field("Common Module Code 4"; "Common Module Code 4") { ApplicationArea = All; }
                field("Module Description 4"; "Module Description 4") { ApplicationArea = All; }
                field("Module Amount 4"; "Module Amount 4") { ApplicationArea = All; }
                field("Module 4 Fee Ins"; "Module 4 Fee Ins") { ApplicationArea = All; }
                field("Module Credit 4"; "Module Credit 4") { ApplicationArea = All; }

                field("No. 5"; "No. 5") { ApplicationArea = All; }
                field("Common Module Code 5"; "Common Module Code 5") { ApplicationArea = All; }
                field("Module Description 5"; "Module Description 5") { ApplicationArea = All; }
                field("Module Amount 5"; "Module Amount 5") { ApplicationArea = All; }
                field("Module 5 Fee Ins"; "Module 5 Fee Ins") { ApplicationArea = All; }
                field("Module Credit 5"; "Module Credit 5") { ApplicationArea = All; }

                field("No. 6"; "No. 6") { ApplicationArea = All; }
                field("Common Module Code 6"; "Common Module Code 6") { ApplicationArea = All; }
                field("Module Description 6"; "Module Description 6") { ApplicationArea = All; }
                field("Module Amount 6"; "Module Amount 6") { ApplicationArea = All; }
                field("Module 6 Fee Ins"; "Module 6 Fee Ins") { ApplicationArea = All; }
                field("Module Credit 6"; "Module Credit 6") { ApplicationArea = All; }


                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code") { ApplicationArea = All; }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code") { ApplicationArea = All; }
                field(RDAP; RDAP) { ApplicationArea = All; }
                field(RDBL; RDBL) { ApplicationArea = All; }
                field(NIC; NIC) { ApplicationArea = All; }
                field("First Name"; "First Name") { ApplicationArea = All; }
                field("Last Name"; "Last Name") { ApplicationArea = All; }
                field("Maiden Name"; "Maiden Name") { ApplicationArea = All; }
                field("Login Email"; "Login Email") { ApplicationArea = All; }
                field("Contact Email"; "Contact Email") { ApplicationArea = All; }
                field("Phone No."; "Phone No.") { ApplicationArea = All; }
                field("Mobile No."; "Mobile No.") { ApplicationArea = All; }
                field(Address; Address) { ApplicationArea = All; }
                field(Country; Country) { ApplicationArea = All; }
                field(Status; Status) { ApplicationArea = All; }
                field(Currency; Currency) { ApplicationArea = All; }


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
            action("Upload Module Fee")
            {
                ApplicationArea = All;
                Image = ImportExcel;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Report.Run(50030);
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
        grecSalesReceivableSetup: Record "Sales & Receivables Setup";
        grecModuleFromOUPortal: Record "Module Fee From OU Portal";
        grecModuleFromOUPortal2: Record "Module Fee From OU Portal";
        grecCustomer: Record Customer;
        grecCustomer2: Record Customer;
        grecDimValue: Record "Dimension Value";
        glblDimError: Label 'Programme %1 does not exist.';
        glblModuleError: Label 'Module code %1 does not exist.';
        grecItem: Record Item;
        grecGenLedgSetup: Record "General Ledger Setup";
        gintCounter2: Integer;
        gintCountModule: Integer;
    begin
        grecSalesReceivableSetup.Get();
        grecModuleFromOUPortal.Reset();
        if grecModuleFromOUPortal.FindSet then begin
            repeat
                gintCountModule := 0;
                if not grecCustomer.get(grecModuleFromOUPortal."Learner ID") then begin
                    grecCustomer2.Init();
                    grecCustomer2."No." := grecModuleFromOUPortal."Learner ID";
                    grecCustomer2.Name := grecModuleFromOUPortal."First Name" + ' ' + grecModuleFromOUPortal."Last Name";
                    grecCustomer2."First Name" := grecModuleFromOUPortal."First Name";
                    grecCustomer2."Last Name" := grecModuleFromOUPortal."Last Name";
                    grecCustomer2."Maiden Name" := grecModuleFromOUPortal."Maiden Name";
                    grecCustomer2.Address := grecModuleFromOUPortal.Address;
                    grecCustomer2."Phone No." := grecModuleFromOUPortal."Phone No.";
                    grecCustomer2."Mobile Phone No." := grecModuleFromOUPortal."Mobile No.";
                    grecCustomer2."Country/Region Code" := grecModuleFromOUPortal.Country;
                    grecCustomer2."VAT Bus. Posting Group" := grecSalesReceivableSetup."VAT Bus. Posting Group";
                    grecCustomer2."Gen. Bus. Posting Group" := grecSalesReceivableSetup."Gen. Bus. Posting Group";
                    grecCustomer2."Customer Posting Group" := grecSalesReceivableSetup."Customer Posting Group";
                    //grecCustomer2."Customer Category" := grecCustomer2."Customer Category";
                    grecCustomer2.Insert();
                end;
                //grecModuleFromOUPortal.Error := 'Student Number does not exist.';

                if grecModuleFromOUPortal."No. 1" <> '' then begin
                    IF not grecItem.Get(grecModuleFromOUPortal."No. 1") THEN
                        grecModuleFromOUPortal.Error := StrSubstNo(glblModuleError, grecModuleFromOUPortal."No. 1");
                    gintCountModule += 1;
                end;

                if grecModuleFromOUPortal."No. 2" <> '' then begin
                    IF not grecItem.Get(grecModuleFromOUPortal."No. 2") THEN
                        grecModuleFromOUPortal.Error := StrSubstNo(glblModuleError, grecModuleFromOUPortal."No. 2");
                    gintCountModule += 1;
                end;

                if grecModuleFromOUPortal."No. 3" <> '' then begin
                    IF not grecItem.Get(grecModuleFromOUPortal."No. 3") THEN
                        grecModuleFromOUPortal.Error := StrSubstNo(glblModuleError, grecModuleFromOUPortal."No. 3");
                    gintCountModule += 1;
                end;

                if grecModuleFromOUPortal."No. 4" <> '' then begin
                    IF not grecItem.Get(grecModuleFromOUPortal."No. 4") THEN
                        grecModuleFromOUPortal.Error := StrSubstNo(glblModuleError, grecModuleFromOUPortal."No. 4");
                    gintCountModule += 1;
                end;

                if grecModuleFromOUPortal."No. 5" <> '' then begin
                    IF not grecItem.Get(grecModuleFromOUPortal."No. 5") THEN
                        grecModuleFromOUPortal.Error := StrSubstNo(glblModuleError, grecModuleFromOUPortal."No. 5");
                end;

                if grecModuleFromOUPortal."No. 6" <> '' then begin
                    IF not grecItem.Get(grecModuleFromOUPortal."No. 6") THEN
                        grecModuleFromOUPortal.Error := StrSubstNo(glblModuleError, grecModuleFromOUPortal."No. 6");
                    gintCountModule += 1;
                end;

                grecGenLedgSetup.Get();
                if grecModuleFromOUPortal."Shortcut Dimension 1 Code" <> '' then begin
                    if not grecDimValue.Get(grecGenLedgSetup."Global Dimension 1 Code", grecModuleFromOUPortal."Shortcut Dimension 1 Code") then
                        grecModuleFromOUPortal.Error := StrSubstNo(glblDimError, grecModuleFromOUPortal."Shortcut Dimension 1 Code");
                end;

                if grecModuleFromOUPortal."Shortcut Dimension 2 Code" <> '' then begin
                    if not grecDimValue.Get(grecGenLedgSetup."Global Dimension 2 Code", grecModuleFromOUPortal."Shortcut Dimension 2 Code") then
                        grecModuleFromOUPortal.Error := StrSubstNo(glblDimError, grecModuleFromOUPortal."Shortcut Dimension 2 Code");
                end;

                if gintCountModule = 0 then
                    grecModuleFromOUPortal.Error := 'There are no module code on this line.';

                if grecModuleFromOUPortal.Error = '' then begin
                    grecModuleFromOUPortal.Validated := true;
                    gintCounter2 += 1;
                end;

                grecModuleFromOUPortal.Modify();
            until grecModuleFromOUPortal.Next = 0;
            Message('%1 lines have been validated out of %2', gintCounter2, grecModuleFromOUPortal.Count);
        end;
    end;


    local procedure CreateSalesInvoice()
    var
        grecSalesHeader: Record "Sales Header";
        grecSalesLine: Record "Sales Line";
        grecSalesLine2: Record "Sales Line";
        gtextSalesOrderNo: Text[50];
        gcodeCustomerno: code[20];
        gdatePostingDate: Date;
        grecModuleFromOUPortal: Record "Module Fee From OU Portal";
        grecModuleFromOUPortal2: Record "Module Fee From OU Portal";
        gintCounter: Integer;
        grecCustPostingGrp: Record "Customer Posting Group";
        SalesReceivableSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        SalesReceivableSetup.Get;
        Clear(gdatePostingDate);
        Clear(gcodeCustomerno);
        grecModuleFromOUPortal2.Reset();
        grecModuleFromOUPortal2.SetCurrentKey("Line No.");
        grecModuleFromOUPortal2.SetRange(Validated, true);
        if grecModuleFromOUPortal2.FindSet then begin
            repeat
                gintCounter += 1;
                grecSalesHeader.Init;
                grecSalesHeader."No." := NoSeriesMgt.GetNextNo(SalesReceivableSetup."Posted Inv Nos. for OU Portal", Today, TRUE);
                grecSalesHeader.Validate("Document Type", grecSalesHeader."Document Type"::Invoice);
                grecSalesHeader.validate("Sell-to Customer No.", grecModuleFromOUPortal2."Learner ID");
                grecSalesHeader.Validate("Posting Date", grecModuleFromOUPortal2."Posting Date");
                grecSalesHeader.Insert(true);
                grecSalesHeader.Validate("Shortcut Dimension 1 Code", grecModuleFromOUPortal2."Shortcut Dimension 1 Code");
                grecSalesHeader.Validate("Shortcut Dimension 2 Code", grecModuleFromOUPortal2."Shortcut Dimension 2 Code");
                grecSalesHeader."First Name" := grecModuleFromOUPortal2."First Name";
                grecSalesHeader."Last Name" := grecModuleFromOUPortal2."Last Name";
                grecSalesHeader."Maiden Name" := grecModuleFromOUPortal2."Maiden Name";
                grecSalesHeader.RDAP := grecModuleFromOUPortal2.RDAP;
                grecSalesHeader.RDBL := grecModuleFromOUPortal2.RDBL;
                grecSalesHeader.NIC := grecModuleFromOUPortal2.NIC;
                grecSalesHeader."Login Email" := grecModuleFromOUPortal2."Login Email";
                grecSalesHeader."Contact Email" := grecModuleFromOUPortal2."Contact Email";
                grecSalesHeader."From OU Portal" := true;

                grecSalesHeader."Gov Grant" := grecModuleFromOUPortal2."Gov Grant";
                grecSalesHeader.Instalment := grecModuleFromOUPortal2.Instalment;
                grecSalesHeader."Payment Amount" := grecModuleFromOUPortal2."Payment Amount";
                grecSalesHeader."Portal Payment Mode" := grecModuleFromOUPortal2."Portal Payment Mode";
                grecSalesHeader."MyT Money Ref" := grecModuleFromOUPortal2."MyT Money Ref";
                grecSalesHeader."Payment Date" := grecModuleFromOUPortal2."Payment Date";

                if (grecModuleFromOUPortal2.Currency <> '') and (grecModuleFromOUPortal2.Currency <> 'Rs') then
                    grecSalesHeader."Currency Code" := 'USD';

                grecCustPostingGrp.Reset();
                grecCustPostingGrp.SetRange(Code);
                if grecCustPostingGrp.FindSet then begin
                    repeat
                        if (grecCustPostingGrp."Start Date" >= Today) AND (grecCustPostingGrp."End Date" <= Today) then
                            grecSalesHeader.Validate("Customer Posting Group", grecCustPostingGrp.Code);
                    until grecCustPostingGrp.Next = 0;
                end;

                grecSalesHeader.Modify();

                if grecModuleFromOUPortal2."No. 1" <> '' then
                    CreateSalesInvoiceLine(grecSalesHeader."No.", grecModuleFromOUPortal2."No. 1", grecModuleFromOUPortal2."Common Module Code 1", grecModuleFromOUPortal2."Module Description 1", grecModuleFromOUPortal2."Module Amount 1", grecModuleFromOUPortal2."Shortcut Dimension 1 Code", grecModuleFromOUPortal2.Instalment, grecModuleFromOUPortal2."Module 1 Fee Ins");

                if grecModuleFromOUPortal2."No. 2" <> '' then
                    CreateSalesInvoiceLine(grecSalesHeader."No.", grecModuleFromOUPortal2."No. 2", grecModuleFromOUPortal2."Common Module Code 2", grecModuleFromOUPortal2."Module Description 2", grecModuleFromOUPortal2."Module Amount 2", grecModuleFromOUPortal2."Shortcut Dimension 1 Code", grecModuleFromOUPortal2.Instalment, grecModuleFromOUPortal2."Module 1 Fee Ins");

                if grecModuleFromOUPortal2."No. 3" <> '' then
                    CreateSalesInvoiceLine(grecSalesHeader."No.", grecModuleFromOUPortal2."No. 3", grecModuleFromOUPortal2."Common Module Code 3", grecModuleFromOUPortal2."Module Description 3", grecModuleFromOUPortal2."Module Amount 3", grecModuleFromOUPortal2."Shortcut Dimension 1 Code", grecModuleFromOUPortal2.Instalment, grecModuleFromOUPortal2."Module 1 Fee Ins");

                if grecModuleFromOUPortal2."No. 4" <> '' then
                    CreateSalesInvoiceLine(grecSalesHeader."No.", grecModuleFromOUPortal2."No. 4", grecModuleFromOUPortal2."Common Module Code 4", grecModuleFromOUPortal2."Module Description 4", grecModuleFromOUPortal2."Module Amount 4", grecModuleFromOUPortal2."Shortcut Dimension 1 Code", grecModuleFromOUPortal2.Instalment, grecModuleFromOUPortal2."Module 1 Fee Ins");

                if grecModuleFromOUPortal2."No. 5" <> '' then
                    CreateSalesInvoiceLine(grecSalesHeader."No.", grecModuleFromOUPortal2."No. 5", grecModuleFromOUPortal2."Common Module Code 5", grecModuleFromOUPortal2."Module Description 5", grecModuleFromOUPortal2."Module Amount 5", grecModuleFromOUPortal2."Shortcut Dimension 1 Code", grecModuleFromOUPortal2.Instalment, grecModuleFromOUPortal2."Module 1 Fee Ins");

                if grecModuleFromOUPortal2."No. 6" <> '' then
                    CreateSalesInvoiceLine(grecSalesHeader."No.", grecModuleFromOUPortal2."No. 6", grecModuleFromOUPortal2."Common Module Code 6", grecModuleFromOUPortal2."Module Description 6", grecModuleFromOUPortal2."Module Amount 6", grecModuleFromOUPortal2."Shortcut Dimension 1 Code", grecModuleFromOUPortal2.Instalment, grecModuleFromOUPortal2."Module 1 Fee Ins");

                grecModuleFromOUPortal2.Delete();
            until grecModuleFromOUPortal2.Next = 0;
            Message('%1 Sales Invoices have been created for Module Fees.', gintCounter);
        end else
            Message('Please validate lines before creating sales invoices.');
    end;


    local procedure CreateSalesInvoiceLine(pcodeDocNo: Code[20]; pcodeModuleNo: Code[20]; pcodeCommonModuleCode: Code[20]; ptextDescription: Text[250]; pdecAmount: Decimal; DimValue1: Code[20]; pboolInstalment: Boolean; pdecInstalmentAmt: Decimal)
    var
        grecSalesLine: Record "Sales Line";
        grecSalesLine2: Record "Sales Line";
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
    end;
}