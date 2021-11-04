report 50055 "FA Reconciliation Sheet"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\FAReconciliationSheet.rdl';

    dataset
    {
        dataitem("FA Posting Group"; "FA Posting Group")
        {
            RequestFilterFields = Code;

            column(CompanyName; grecCompanyInfo.Name) { }
            column(StartDateMinus1; format(gdateStartDate - 1)) { }
            column(StartDate; format(gdateStartDate)) { }
            column(EndDate; format(gdateEndDate)) { }
            column(FA_Posting_Group; code) { }
            dataitem(FALedgerEntry; Integer)
            {
                DataItemTableView = sorting(Number);
                MaxIteration = 1;

                column(gdecSection1; gdecSection[1]) { }
                column(gdecSection2; gdecSection[2]) { }
                column(gdecSection3; gdecSection[3]) { }
                column(gdecSection4; gdecSection[4]) { }
                column(gdecSection5; gdecSection[5]) { }
                column(gdecSection6; gdecSection[6]) { }
                column(gdecSection7; gdecSection[7]) { }
                column(gdecSection8; gdecSection[8]) { }
                column(gdecSection9; gdecSection[9]) { }
                column(gdecSection10; gdecSection[10]) { }


                trigger OnAfterGetRecord()
                begin
                    clear(gdecSection);

                    //Opening Balance as at Starting Date -1           
                    grecFALedgerEntry.Reset();
                    grecFALedgerEntry.SetRange("FA Posting Group", "FA Posting Group".Code);
                    grecFALedgerEntry.SetFilter("Posting Date", '<=%1', gdateStartDate - 1);
                    grecFALedgerEntry.SetRange("FA Posting Type", grecFALedgerEntry."FA Posting Type"::"Acquisition Cost");
                    grecFALedgerEntry.SetRange(Reversed, false);
                    if gcodeDepreciationBook <> '' then
                        grecFALedgerEntry.SetRange("Depreciation Book Code", gcodeDepreciationBook);
                    if grecFALedgerEntry.FindFirst() then begin
                        repeat
                            gdecSection[1] += grecFALedgerEntry.Amount;
                        until grecFALedgerEntry.Next = 0;
                    end;


                    //Addtion for period Starting Date to Ending Date
                    grecFALedgerEntry.Reset();
                    grecFALedgerEntry.SetRange("FA Posting Group", "FA Posting Group".Code);
                    grecFALedgerEntry.SetRange("Posting Date", gdateStartDate, gdateEndDate);
                    grecFALedgerEntry.SetRange("FA Posting Type", grecFALedgerEntry."FA Posting Type"::"Acquisition Cost");
                    grecFALedgerEntry.SetRange("FA Posting Category", grecFALedgerEntry."FA Posting Category"::" ");
                    grecFALedgerEntry.SetRange(Reversed, false);
                    if gcodeDepreciationBook <> '' then
                        grecFALedgerEntry.SetRange("Depreciation Book Code", gcodeDepreciationBook);
                    if grecFALedgerEntry.FindFirst() then begin
                        repeat
                            gdecSection[2] += grecFALedgerEntry.Amount;
                        until grecFALedgerEntry.Next = 0;
                    end;


                    //Disposal for period Starting Date to Ending Date
                    grecFALedgerEntry.Reset();
                    grecFALedgerEntry.SetRange("FA Posting Group", "FA Posting Group".Code);
                    grecFALedgerEntry.SetRange("Posting Date", gdateStartDate, gdateEndDate);
                    grecFALedgerEntry.SetRange("FA Posting Type", grecFALedgerEntry."FA Posting Type"::"Acquisition Cost");
                    grecFALedgerEntry.SetRange("FA Posting Category", grecFALedgerEntry."FA Posting Category"::Disposal);
                    grecFALedgerEntry.SetRange(Reversed, false);
                    if gcodeDepreciationBook <> '' then
                        grecFALedgerEntry.SetRange("Depreciation Book Code", gcodeDepreciationBook);
                    if grecFALedgerEntry.FindFirst() then begin
                        repeat
                            gdecSection[3] += grecFALedgerEntry.Amount;
                        until grecFALedgerEntry.Next = 0;
                    end;


                    //Closing Balance for period Starting Date to Ending Date
                    gdecSection[4] := gdecSection[1] + gdecSection[2] + gdecSection[3];


                    //Opening Balance as at Starting Date -1 for Depreciation       
                    grecFALedgerEntry.Reset();
                    grecFALedgerEntry.SetRange("FA Posting Group", "FA Posting Group".Code);
                    grecFALedgerEntry.SetFilter("Posting Date", '<=%1', gdateStartDate - 1);
                    grecFALedgerEntry.SetRange("FA Posting Type", grecFALedgerEntry."FA Posting Type"::Depreciation);
                    grecFALedgerEntry.SetRange(Reversed, false);
                    if gcodeDepreciationBook <> '' then
                        grecFALedgerEntry.SetRange("Depreciation Book Code", gcodeDepreciationBook);
                    if grecFALedgerEntry.FindFirst() then begin
                        repeat
                            gdecSection[5] += grecFALedgerEntry.Amount;
                        until grecFALedgerEntry.Next = 0;
                        gdecSection[5] *= -1;
                    end;


                    //Change for the year - Period Starting Date to Ending Date
                    grecFALedgerEntry.Reset();
                    grecFALedgerEntry.SetRange("FA Posting Group", "FA Posting Group".Code);
                    grecFALedgerEntry.SetRange("Posting Date", gdateStartDate, gdateEndDate);
                    grecFALedgerEntry.SetRange("FA Posting Type", grecFALedgerEntry."FA Posting Type"::Depreciation);
                    grecFALedgerEntry.SetRange("FA Posting Category", grecFALedgerEntry."FA Posting Category"::" ");
                    grecFALedgerEntry.SetRange(Reversed, false);
                    if gcodeDepreciationBook <> '' then
                        grecFALedgerEntry.SetRange("Depreciation Book Code", gcodeDepreciationBook);
                    if grecFALedgerEntry.FindFirst() then begin
                        repeat
                            gdecSection[6] += grecFALedgerEntry.Amount;
                        until grecFALedgerEntry.Next = 0;
                        gdecSection[6] *= -1;
                    end;


                    //Disposal for period Starting Date to Ending Date
                    grecFALedgerEntry.Reset();
                    grecFALedgerEntry.SetRange("FA Posting Group", "FA Posting Group".Code);
                    grecFALedgerEntry.SetRange("Posting Date", gdateStartDate, gdateEndDate);
                    grecFALedgerEntry.SetRange("FA Posting Type", grecFALedgerEntry."FA Posting Type"::Depreciation);
                    grecFALedgerEntry.SetRange("FA Posting Category", grecFALedgerEntry."FA Posting Category"::Disposal);
                    grecFALedgerEntry.SetRange(Reversed, false);
                    if gcodeDepreciationBook <> '' then
                        grecFALedgerEntry.SetRange("Depreciation Book Code", gcodeDepreciationBook);
                    if grecFALedgerEntry.FindFirst() then begin
                        repeat
                            gdecSection[7] += grecFALedgerEntry.Amount;
                        until grecFALedgerEntry.Next = 0;
                    end;


                    //Closing Balance for period Starting Date to Ending Date Depreciation
                    gdecSection[8] := gdecSection[5] + gdecSection[6] + gdecSection[7];


                    //NBV as at Ending Date
                    gdecSection[9] := gdecSection[4] - gdecSection[8];


                    //NBV as at Starting Date - 1
                    gdecSection[10] := gdecSection[1] - gdecSection[5];
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Date Filter")
                {
                    field("Depreciation Book"; gcodeDepreciationBook)
                    {
                        ApplicationArea = All;
                        TableRelation = "Depreciation Book";
                    }
                    field("Start Date"; gdateStartDate) { ApplicationArea = All; }
                    field("End Date"; gdateEndDate) { ApplicationArea = All; }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if gdateStartDate > gdateEndDate then
            Error('Start Date should be less or equal to End Date.');

        if (gdateStartDate = 0D) or (gdateEndDate = 0D) then
            Error('Please display Start Date and End Date.');
        grecCompanyInfo.get;
    end;


    var
        gdateStartDate: Date;
        gdateEndDate: Date;
        grecCompanyInfo: Record "Company Information";
        grecFALedgerEntry: Record "FA Ledger Entry";
        gdecSection: array[10] of Decimal;
        gcodeDepreciationBook: Code[10];
}