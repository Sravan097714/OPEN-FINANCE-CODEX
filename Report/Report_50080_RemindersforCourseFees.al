report 50080 "Reminders for Course Fees"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Reminders for Course Fees';
    RDLCLayout = 'Report\Layout\ReminderforCourseFees.rdl';

    dataset
    {
        dataitem("Issued Reminder Header"; "Issued Reminder Header")
        {
            column(gtextReminder; gtextReminder) { }
            column(Reminder_Ref; "Reminder Ref") { }

            column(GlobalDim1Name2Hdr; gtextGlobalDim1Name2Hdr) { }
            column(GlobalDim2NameHdr; gtextGlobalDim2NameHdr) { }

            column(Name; Name) { }
            column(Address; Address) { }
            column(Deadline_for_Payment; Format("Deadline for Payment", 0, '<Day,2> <Month Text> <Year4>')) { }

            column(CompanyName; grecCompanyInfo.Name) { }
            column(CompanyAddress; grecCompanyInfo.Address) { }
            column(CompanyPicture; grecCompanyInfo.Picture) { }
            column(Signature; grecSalesReceivableSetup."Sign for Reminders") { }

            column(Remaining_Amount; "Remaining Amount") { }

            dataitem("Issued Reminder Line"; "Issued Reminder Line")
            {
                column(PayableRs; "Original Amount") { }
                column(PaidRs; "Original Amount" - "Remaining Amount") { }
                column(AmountDueRs; "Remaining Amount") { }
                column(Remark; Description) { }
                column(GlobalDim2Name; gtextGlobalDim2Name) { }

                trigger OnAfterGetRecord()
                begin
                    if grecDimensionValue.Get('INTAKE', "Global Dimension 2") then
                        gtextGlobalDim2Name := grecDimensionValue.Name;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if grecDimensionValue.Get('INTAKE', "Shortcut Dimension 1 Code") then
                    gtextGlobalDim1Name2Hdr := grecDimensionValue.Name;

                if grecDimensionValue.Get('PROGRAMME', "Shortcut Dimension 2 Code") then
                    gtextGlobalDim1Name2Hdr := grecDimensionValue."Name 2";

                case "Reminder Level" of
                    1:
                        gtextReminder := 'First Reminder';
                    2:
                        gtextReminder := 'Second Reminder';
                    3:
                        gtextReminder := 'Third Reminder';
                end;
            end;
        }
    }

    trigger OnPreReport()
    begin
        grecCompanyInfo.get;
        grecCompanyInfo.CalcFields(Picture);
        grecSalesReceivableSetup.Get();
    end;

    var
        grecCompanyInfo: Record "Company Information";
        grecSalesReceivableSetup: Record "Sales & Receivables Setup";
        grecDimensionValue: Record "Dimension Value";
        gtextGlobalDim2Name: Text;

        gtextGlobalDim1Name2Hdr: Text;
        gtextGlobalDim2NameHdr: Text;

        gtextReminder: Text;
}