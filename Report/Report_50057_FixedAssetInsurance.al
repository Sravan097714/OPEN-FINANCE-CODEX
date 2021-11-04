report 50057 "Fixed Asset Insurance Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\FAInsurance.rdl';

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            column(CompanyName; grecCompanyInfo.Name) { }
            column(No_; "No.") { }
            column(Description; Description) { }
            column(DateofPurchase; format(gdatePostingDate)) { }
            column(AcquisitionCost; gdecAcquisitionCost) { }
            column(gdecAmount; gdecAmount) { }
            column(gdateUserEndDate; format(gdateUserEndDate)) { }
            column(today; format(today)) { }

            trigger OnAfterGetRecord()
            begin
                gdateStartDate := gdateInitialStartDate;
                gdateEndDate := gdateInitialEndDate;

                Clear(gdatePostingDate);
                Clear(gdecAcquisitionCost);
                grecFALedgerEntry.Reset();
                grecFALedgerEntry.SetCurrentKey("Entry No.");
                grecFALedgerEntry.SetRange("FA No.", "No.");
                grecFALedgerEntry.SetRange("FA Posting Type", grecFALedgerEntry."FA Posting Type"::"Acquisition Cost");
                grecFALedgerEntry.SetRange("FA Posting Category", grecFALedgerEntry."FA Posting Category"::" ");
                grecFALedgerEntry.SetRange(Reversed, false);
                if grecFALedgerEntry.FindFirst() then
                    gdatePostingDate := grecFALedgerEntry."Posting Date";

                //grecFALedgerEntry.SetRange("Document Type", grecFALedgerEntry."Document Type"::Invoice);
                if grecFALedgerEntry.FindFirst() then
                    gdecAcquisitionCost := grecFALedgerEntry.Amount;


                //Calculating Insurance Cost
                clear(gdecAmount);
                if (gdateStartDate <= gdatePostingDate) AND (gdateEndDate >= gdatePostingDate) then
                    gdecAmount := gdecAcquisitionCost;

                if gdecAmount = 0 then begin
                    grecFAInsuranceSetup.Reset();
                    grecFAInsuranceSetup.SetCurrentKey("Entry No.");
                    grecFAInsuranceSetup.SetRange("FA Posting Group", "FA Posting Group");
                    if grecFAInsuranceSetup.FindFirst() then begin
                        repeat
                            gdateStartDate := gdateInitialStartDate;
                            gdateEndDate := gdateInitialEndDate;

                            gdateStartDate := CalcDate(grecFAInsuranceSetup.Year, gdateStartDate);
                            gdateEndDate := CalcDate(grecFAInsuranceSetup.Year, gdateEndDate);

                            if (gdateStartDate <= gdatePostingDate) AND (gdateEndDate >= gdatePostingDate) then
                                gdecAmount := gdecAcquisitionCost * grecFAInsuranceSetup."Insurance Amount %"
                        until (grecFAInsuranceSetup.Next = 0) or (gdecAmount <> 0)
                    end;
                end;

                if (gdecAcquisitionCost <> 0) and (gdecAmount = 0) then begin
                    grecFAInsuranceSetup.Reset();
                    grecFAInsuranceSetup.SetCurrentKey("Entry No.");
                    grecFAInsuranceSetup.SetRange("FA Posting Group", "FA Posting Group");
                    if grecFAInsuranceSetup.FindLast() then begin
                        if grecFAInsuranceSetup."Insurance Amount %" > 1 then
                            gdecAmount := grecFAInsuranceSetup."Insurance Amount %"
                        else
                            gdecAmount := gdecAcquisitionCost * grecFAInsuranceSetup."Insurance Amount %";
                    end;
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
                group("Date Filter")
                {
                    field("Ending Date"; gdateUserEndDate)
                    {
                        ApplicationArea = All;
                        Visible = true;
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if (Date2DMY(gdateUserEndDate, 1) <> 30) or (Date2DMY(gdateUserEndDate, 2) <> 06) then begin
            Error('Please insert date with 30th of June.');
        end;

        grecCompanyInfo.get;
        gtextStartDate := '01/07/';
        gtextEndDate := '30/06/';

        Clear(gintYear);
        clear(gdateStartDate);
        clear(gdateEndDate);
        gintYear := Date2DMY(gdateUserEndDate, 3);
        Evaluate(gdateStartDate, gtextStartDate + Format(gintYear - 1));
        gdateEndDate := CalcDate('1Y-1D', gdateStartDate);

        gdateInitialStartDate := gdateStartDate;
        gdateInitialEndDate := gdateEndDate;
    end;

    var
        grecCompanyInfo: Record "Company Information";
        gdateUserEndDate: Date;
        grecFALedgerEntry: Record "FA Ledger Entry";
        gdatePostingDate: Date;
        gdecAcquisitionCost: Decimal;

        gtextStartDate: Text;
        gtextEndDate: Text;

        gdateStartDate: Date;
        gdateEndDate: Date;

        gdateInitialStartDate: Date;
        gdateInitialEndDate: Date;

        gintYear: Integer;
        grecFAInsuranceSetup: Record "FA Insurance Setup";
        gdecAmount: Decimal;
}