report 50014 "Fixed Asset Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\FixedAssetSchedule2.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("FA Ledger Entry"; "FA Ledger Entry")
        {
            RequestFilterFields = "FA No.", "FA Posting Group", "FA Class Code", "FA Subclass Code", "Global Dimension 1 Code", "FA Location Code";

            column(CompanyName; grecCompanyInfo.Name) { }
            column(gdateStartDate; FORMAT(gdateEndDate[1], 0, '<Day,2> <Month Text> <Year4>')) { }
            column(gdateEndDate; FORMAT(gdateEndDate[2], 0, '<Day,2> <Month Text> <Year4>')) { }
            column(FA_Posting_Group; "FA Posting Group") { }
            column(Amount; Amount) { }

            //COST
            column(gdecAmt1; gdecAmt1[1]) { }
            column(gdecAmt2; gdecAmt2[1]) { }
            column(gdecAmt3; gdecAmt3[1]) { }
            column(gdecAmt4; gdecAmt4[1]) { }
            column(gdecAmt12; gdecAmt1[2]) { }
            column(gdecAmt22; gdecAmt2[2]) { }
            column(gdecAmt32; gdecAmt3[2]) { }
            column(gdecAmt42; gdecAmt4[2]) { }
            column(gintRowNo1; gintRowNo1) { }
            column(gintRowNo2; gintRowNo2) { }
            column(gintRowNo3; gintRowNo3) { }
            column(gintRowNo4; gintRowNo4) { }

            //DEPRECIATION
            column(gdecAmt5; gdecAmt5[1]) { }
            column(gdecAmt6; gdecAmt6[1]) { }
            column(gdecAmt7; gdecAmt7[1]) { }
            column(gdecAmt52; gdecAmt5[2]) { }
            column(gdecAmt62; gdecAmt6[2]) { }
            column(gdecAmt72; gdecAmt7[2]) { }
            column(gintRowNo5; gintRowNo5) { }
            column(gintRowNo6; gintRowNo6) { }
            column(gintRowNo7; gintRowNo7) { }


            trigger OnAfterGetRecord()
            var
                grecFALedgerEntry: Record "FA Ledger Entry";
            begin
                //Start Date
                Clear(gdecAmt1);
                Clear(gintRowNo1);
                grecFALedgerEntry.Reset();
                grecFALedgerEntry.SetCurrentKey("Entry No.");
                grecFALedgerEntry.SetRange("Entry No.", "FA Ledger Entry"."Entry No.");
                grecFALedgerEntry.SetFilter("Posting Date", '<=%1', gdateEndDate[1]);
                grecFALedgerEntry.SetRange("Depreciation Book Code", gcodeDepreciationBook);
                grecFALedgerEntry.SetFilter("FA Posting Type", '%1', grecFALedgerEntry."FA Posting Type"::"Acquisition Cost");
                grecFALedgerEntry.SetRange(Reversed, false);
                if grecFALedgerEntry.FindFirst() then begin
                    gdecAmt1[1] := grecFALedgerEntry.Amount;
                    gintRowNo1 := 1;
                end;

                grecFALedgerEntry.SetFilter("Posting Date", '<=%1', gdateEndDate[1]);
                if grecFALedgerEntry.FindFirst() then begin
                    gdecAmt1[2] := grecFALedgerEntry.Amount;
                    gintRowNo1 := 1;
                end;


                //Additions
                Clear(gdecAmt2);
                Clear(gintRowNo2);
                grecFALedgerEntry.SetRange("Posting Date", gdateStartDate[1], gdateEndDate[1]);
                grecFALedgerEntry.SetRange("FA Posting Category", grecFALedgerEntry."FA Posting Category"::" ");
                if grecFALedgerEntry.FindFirst() then begin
                    gdecAmt2[1] := grecFALedgerEntry.Amount;
                    gintRowNo2 := 2;
                end;

                grecFALedgerEntry.SetRange("Posting Date", gdateStartDate[2], gdateEndDate[2]);
                if grecFALedgerEntry.FindFirst() then begin
                    gdecAmt2[2] := grecFALedgerEntry.Amount;
                    gintRowNo1 := 2;
                end;


                //Disposal/Scrap
                Clear(gdecAmt3);
                Clear(gintRowNo3);
                grecFALedgerEntry.SetRange("Posting Date", gdateStartDate[1], gdateEndDate[1]);
                grecFALedgerEntry.SetFilter("FA Posting Type", '%1', grecFALedgerEntry."FA Posting Type"::"Acquisition Cost");
                grecFALedgerEntry.SetRange("FA Posting Category", grecFALedgerEntry."FA Posting Category"::Disposal);
                if grecFALedgerEntry.FindFirst() then begin
                    gdecAmt3[1] := grecFALedgerEntry.Amount;
                    gintRowNo3 := 3;
                end;

                grecFALedgerEntry.SetRange("Posting Date", gdateStartDate[2], gdateEndDate[2]);
                if grecFALedgerEntry.FindFirst() then begin
                    gdecAmt3[2] := grecFALedgerEntry.Amount;
                    gintRowNo3 := 3;
                end;


                //Revaluation
                Clear(gdecAmt4);
                Clear(gintRowNo4);
                grecFALedgerEntry.SetRange("Depreciation Book Code", gcodeRevaluationDeprBook);
                grecFALedgerEntry.SetRange("Posting Date", gdateStartDate[1], gdateEndDate[1]);
                grecFALedgerEntry.SetRange("FA Posting Category", grecFALedgerEntry."FA Posting Category"::" ");
                if grecFALedgerEntry.FindFirst() then begin
                    gdecAmt4[1] := grecFALedgerEntry.Amount;
                    gintRowNo4 := 4;
                end;

                grecFALedgerEntry.SetRange("Posting Date", gdateStartDate[2], gdateEndDate[2]);
                if grecFALedgerEntry.FindFirst() then begin
                    gdecAmt4[2] := grecFALedgerEntry.Amount;
                    gintRowNo3 := 4;
                end;



                //Start of Depreciation 
                Clear(gdecAmt5);
                Clear(gintRowNo5);
                grecFALedgerEntry.SetRange("Depreciation Book Code", gcodeDepreciationBook);
                grecFALedgerEntry.SetFilter("Posting Date", '<=%1', gdateStartDate[1]);
                grecFALedgerEntry.SetRange("FA Posting Type", grecFALedgerEntry."FA Posting Type"::Depreciation);
                grecFALedgerEntry.SetRange("FA Posting Category");
                if grecFALedgerEntry.FindFirst() then begin
                    gdecAmt5[1] := grecFALedgerEntry.Amount;
                    gintRowNo5 := 5;
                end;

                grecFALedgerEntry.SetFilter("Posting Date", '<=%1', gdateStartDate[2]);
                if grecFALedgerEntry.FindFirst() then begin
                    gdecAmt5[2] := grecFALedgerEntry.Amount;
                    gintRowNo3 := 5;
                end;



                //Charge for the Period
                Clear(gdecAmt6);
                Clear(gintRowNo6);
                grecFALedgerEntry.SetRange("Posting Date", gdateStartDate[1], gdateEndDate[1]);
                if grecFALedgerEntry.FindFirst() then begin
                    gdecAmt6[1] := grecFALedgerEntry.Amount;
                    gintRowNo6 := 6;
                end;

                grecFALedgerEntry.SetRange("Posting Date", gdateStartDate[2], gdateEndDate[2]);
                if grecFALedgerEntry.FindFirst() then begin
                    gdecAmt6[2] := grecFALedgerEntry.Amount;
                    gintRowNo6 := 6;
                end;



                //Disposal/Scrap
                Clear(gdecAmt7);
                Clear(gintRowNo7);
                grecFALedgerEntry.SetRange("Posting Date", gdateStartDate[1], gdateEndDate[1]);
                grecFALedgerEntry.SetRange("FA Posting Category", grecFALedgerEntry."FA Posting Category"::Disposal);
                if grecFALedgerEntry.FindFirst() then begin
                    gdecAmt7[1] := grecFALedgerEntry.Amount;
                    gintRowNo7 := 7;
                end;

                grecFALedgerEntry.SetRange("Posting Date", gdateStartDate[2], gdateEndDate[2]);
                if grecFALedgerEntry.FindFirst() then begin
                    gdecAmt7[2] := grecFALedgerEntry.Amount;
                    gintRowNo7 := 7;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("Depreciation Book"; gcodeDepreciationBook)
                    {
                        ApplicationArea = All;
                        TableRelation = "Depreciation Book";
                    }
                    //field("Start Date"; gdateStartDate) { ApplicationArea = All; }
                    field("End Date"; gdateEndDate[1]) { ApplicationArea = All; }

                    field("Revaluation Depreciation Book"; gcodeRevaluationDeprBook)
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            grecDepreciationBook: Record "Depreciation Book";
                            gpageDepreciationBook: page "Depreciation Book List";
                        begin
                            grecDepreciationBook.Reset();
                            grecDepreciationBook.SetRange("FA Revaluation", true);
                            if grecDepreciationBook.FindFirst() then begin
                                gpageDepreciationBook.SetRecord(grecDepreciationBook);
                                gpageDepreciationBook.SetTableView(grecDepreciationBook);
                                gpageDepreciationBook.LookupMode(true);
                                if gpageDepreciationBook.RunModal() = Action::LookupOK then begin
                                    gpageDepreciationBook.GetRecord(grecDepreciationBook);
                                    gcodeRevaluationDeprBook := grecDepreciationBook.Code;
                                end;
                            end;
                        end;
                    }
                }
            }
        }
    }


    trigger OnPreReport()
    begin

        /* if (gdateStartDate = 0D) OR (gdateEndDate = 0D) then
            Error('Please insert both Starting Date and Ending Date.');

        if gdateEndDate < gdateStartDate then
            Error('Starting Date should be less or equal to Ending Date.'); */

        if (Date2DMY(gdateEndDate[1], 1) <> 30) or (Date2DMY(gdateEndDate[1], 2) <> 06) then begin
            Error('Please insert date with 30th of June.');
        end;

        Evaluate(gdateStartDate[1], '01/07/' + format(Date2DMY(gdateEndDate[1], 3) - 1));
        gdateEndDate[2] := CalcDate('-1Y', gdateEndDate[1]);
        Evaluate(gdateStartDate[2], '01/07/' + format(Date2DMY(gdateEndDate[2], 3) - 1));

        /* Message(format(gdateStartDate[1]));
        Message(format(gdateEndDate[1]));
        Message(format(gdateStartDate[2]));
        Message(format(gdateEndDate[2])); */
        grecCompanyInfo.get;
    end;


    var
        grecCompanyInfo: Record "Company Information";
        gdateStartDate: array[2] of Date;
        gdateEndDate: array[2] of Date;
        gdecAmt1: array[2] of Decimal;
        gdecAmt2: array[2] of Decimal;
        gdecAmt3: array[2] of Decimal;
        gdecAmt4: array[2] of Decimal;
        gdecAmt5: array[2] of Decimal;
        gdecAmt6: array[2] of Decimal;
        gdecAmt7: array[2] of Decimal;
        gintRowNo1: Integer;
        gintRowNo2: Integer;
        gintRowNo3: Integer;
        gintRowNo4: Integer;
        gintRowNo5: Integer;
        gintRowNo6: Integer;
        gintRowNo7: Integer;
        gcodeDepreciationBook: Code[10];
        gcodeRevaluationDeprBook: Code[10];
}
