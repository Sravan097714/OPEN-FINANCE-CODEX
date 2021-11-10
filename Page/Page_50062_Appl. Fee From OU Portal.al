page 50062 "Appl. Fee From OU Portal"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Appl. Fee From OU Portal";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Select; Rec.Select) { ApplicationArea = All; }
                field("Line No."; Rec."Line No.") { ApplicationArea = All; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
                field("Payment Method Code"; Rec."Payment Method Code") { ApplicationArea = All; }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = All; }
                field(Dim2Date; Rec.Dim2Date) { ApplicationArea = All; }
                field(RDAP; Rec.RDAP) { ApplicationArea = ALL; }
                field(RDBL; Rec.RDBL) { ApplicationArea = ALL; }
                field(NIC; Rec.NIC) { ApplicationArea = ALL; }
                field("Student Name"; Rec."Student Name") { ApplicationArea = ALL; }
                field("Login Email"; Rec."Login Email") { ApplicationArea = ALL; }
                field("Contact Email"; Rec."Contact Email") { ApplicationArea = ALL; }
                field(Phone; Rec.Phone) { ApplicationArea = ALL; }
                field(Mobile; Rec.Mobile) { ApplicationArea = ALL; }
                field(Address; Rec.Address) { ApplicationArea = ALL; }
                field(Country; Rec.Country) { ApplicationArea = ALL; }
                field("Inserted By"; Rec."Inserted By") { ApplicationArea = All; }
                field("Inserted DateTime"; Rec."Inserted DateTime") { ApplicationArea = All; }
                field("Last Modified By"; Rec."Last Modified By") { ApplicationArea = All; }
                field("Last Modified DateTime"; Rec."Last Modified DateTime") { ApplicationArea = All; }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Import Appl. Fee")
            {
                ApplicationArea = All;
                Image = ImportExcel;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Import Application Fee Data.';

                trigger OnAction()
                begin
                    Report.Run(Report::"Import App Fee from OU Portal");
                end;
            }

            action("Validate")
            {
                ApplicationArea = All;
                Image = ValidateEmailLoggingSetup;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    //ValidateData();
                end;
            }

            action("Create Cash Receipt Jnl")
            {
                ApplicationArea = All;
                Image = CreateJobSalesInvoice;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Create Cash Receipt Journal for Selected Lines.';

                trigger OnAction()
                begin
                    CreateCashRcptJnl();
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

    var
        grecGenJnlLine: Record "Gen. Journal Line";
        grecGenJnlLine2: Record "Gen. Journal Line";
        grecSalesReceivableSetup: Record "Sales & Receivables Setup";
        NoSeries: Record "No. Series Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        gintCounter: Integer;

    local procedure CreateCashRcptJnl()
    var
        ApplFeeLRec: Record "Appl. Fee From OU Portal";
        grecGenLedgSetup: Record "General Ledger Setup";
        grecDimValue: Record "Dimension Value";
        LineNo: Integer;
    begin
        grecSalesReceivableSetup.Get;
        grecGenLedgSetup.get;
        clear(grecGenJnlLine);

        grecGenJnlLine2.Reset();
        grecGenJnlLine2.SetRange("Journal Template Name", 'CASH RECE');
        grecGenJnlLine2.SetRange("Journal Batch Name", grecSalesReceivableSetup."Journal Batch Name OU Portal");
        if grecGenJnlLine2.FindLast then
            LineNo := grecGenJnlLine2."Line No." + 10000
        else
            LineNo := 10000;

        ApplFeeLRec.Reset();
        ApplFeeLRec.SetRange(Select, true);
        if Not ApplFeeLRec.FindSet() then
            Error('Nothing to create.');
        repeat
            grecGenJnlLine.Init();

            grecGenJnlLine."Journal Template Name" := 'CASH RECE';
            grecGenJnlLine."Journal Batch Name" := grecSalesReceivableSetup."Journal Batch Name OU Portal";
            grecGenJnlLine."Line No." := LineNo;
            grecGenJnlLine."Document Type" := grecGenJnlLine."Document Type"::Payment;

            NoSeries.RESET;
            NoSeries.SETRANGE("Series Code", grecSalesReceivableSetup."No. Series for OU Portal");
            IF NoSeries.FINDLAST THEN
                grecGenJnlLine."Document No." := NoSeriesMgt.GetNextNo(grecSalesReceivableSetup."No. Series for OU Portal", Today, false);

            grecGenJnlLine.validate("Posting Date", ApplFeeLRec."Posting Date");
            grecGenJnlLine."Account Type" := grecGenJnlLine."Account Type"::"G/L Account";
            grecGenJnlLine.Validate("Account No.", grecSalesReceivableSetup."G/L Acc. for App Reg OU Portal");
            grecGenJnlLine.Validate("Payment Method Code", ApplFeeLRec."Payment Method Code");
            if ApplFeeLRec.Amount <> 0 then
                grecGenJnlLine.validate(Amount, ApplFeeLRec.Amount);
            grecGenJnlLine."Bal. Account Type" := grecGenJnlLine."Bal. Account Type"::"Bank Account";
            grecGenJnlLine.Validate("Bal. Account No.", grecSalesReceivableSetup."Bank Acc. No. for OU Portal");

            grecGenJnlLine.Validate("Student ID", ApplFeeLRec."Student ID");
            grecGenJnlLine.RDAP := ApplFeeLRec.RDAP;
            grecGenJnlLine.RDBL := ApplFeeLRec.RDBL;
            grecGenJnlLine.NIC := ApplFeeLRec.NIC;
            grecGenJnlLine."Student Name" := ApplFeeLRec."Student Name";

            if ApplFeeLRec.Dim2Date <> 0D then begin
                grecDimValue.Reset();
                grecDimValue.SetRange("Dimension Code", grecGenLedgSetup."Global Dimension 2 Code");
                grecDimValue.SetFilter("Starting Date", '>=%1', ApplFeeLRec.Dim2Date);
                if grecDimValue.Findfirst then begin
                    repeat
                        if ApplFeeLRec.Dim2Date <= grecDimValue."Ending Date" then
                            grecGenJnlLine."Shortcut Dimension 2 Code" := grecDimValue.Code;
                    until (grecDimValue.Next = 0) or (grecGenJnlLine."Shortcut Dimension 2 Code" <> '');
                end;
            end;

            //grecGenJnlLine."Shortcut Dimension 2 Code" := GetValueAtCell(RowNo, 8);
            if ApplFeeLRec."Login Email" <> '' then
                grecGenJnlLine."Login Email" := ApplFeeLRec."Login Email";
            if ApplFeeLRec."Contact Email" <> '' then
                grecGenJnlLine."Contact Email" := ApplFeeLRec."Contact Email";
            if ApplFeeLRec.Phone <> '' then
                grecGenJnlLine.Phone := ApplFeeLRec.Phone;
            if ApplFeeLRec.Mobile <> '' then
                grecGenJnlLine.Mobile := ApplFeeLRec.Mobile;
            if ApplFeeLRec.Address <> '' then
                grecGenJnlLine.Address := ApplFeeLRec.Address;
            if ApplFeeLRec.Country <> '' then
                grecGenJnlLine.Country := ApplFeeLRec.Country;

            if (ApplFeeLRec."Currency Code" <> '') AND (ApplFeeLRec."Currency Code" <> 'Rs') then
                grecGenJnlLine."Currency Code" := 'USD';
            grecGenJnlLine."From OU Portal" := true;
            grecGenJnlLine.Insert();
            LineNo += 10000;
            gintCounter += 1;
        until ApplFeeLRec.Next() = 0;

    end;
}