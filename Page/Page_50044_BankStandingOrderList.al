page 50044 "Bank Standing Order List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bank Standing Orders";
    SourceTableView = where(Archived = filter(false));
    CardPageId = "Bank Standing Order";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Bank Standing Order No."; "Bank Standing Order No.") { ApplicationArea = All; }
                field("Full Name of Applicant"; "Full Name of Applicant") { ApplicationArea = All; }
                field(Address; Address) { ApplicationArea = All; }
                field(City; City) { ApplicationArea = All; }
                field(Country; Country) { ApplicationArea = All; }
                field("National Identity No."; "National Identity No.") { ApplicationArea = All; }
                field(Programme; Programme) { ApplicationArea = All; }
                field(Intake; Intake) { ApplicationArea = All; }
                field(Year; Year) { ApplicationArea = All; }
                field(Semester; Semester) { ApplicationArea = All; }
                field("No. of Module"; "No. of Module") { ApplicationArea = All; }
                field("Total Fee per Installment"; "Total Fee per Installment") { ApplicationArea = All; }
                field("Currency Code"; "Currency Code") { ApplicationArea = All; }
                field("No. of Installments"; "No. of Installments") { ApplicationArea = All; }
                field("Total Fee for Installments"; "Total Fee for Installments") { ApplicationArea = All; }
                field("Currency Code 2"; "Currency Code 2") { ApplicationArea = All; }
                field("Name of Bank"; "Name of Bank") { ApplicationArea = All; }
                field("Address 2"; "Address 2") { ApplicationArea = All; }
                field("Current_Savings Account no."; "Current_Savings Account no.") { ApplicationArea = All; }
                field("Instalment amount to Debit"; "Instalment amount to Debit") { ApplicationArea = All; }
                field("From Month"; "From Month") { ApplicationArea = All; }
                field("To Month"; "To Month") { ApplicationArea = All; }
                field("Name of Bank 2"; "Name of Bank 2") { ApplicationArea = All; }
                field("Account to Credit"; "Account to Credit") { ApplicationArea = All; }
                field(Archived; Archived) { ApplicationArea = all; }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Archive Bank Standing Order")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = BankContact;

                trigger OnAction()
                var
                    Bankstandingorderrec: Record "Bank Standing Orders";
                    ArchivedBankStandingOrderrec: Record "Archived Bank Standing Orders";
                begin
                    if NOT Confirm('Do you want to archive the Bank Standing Order %1', false, rec."Bank Standing Order No.", '?') then exit;
                    ArchivedBankStandingOrderrec.Init();
                    ArchivedBankStandingOrderrec.TransferFields(Rec);
                    ArchivedBankStandingOrderrec.Insert();
                    Rec.Archived := true;
                    Rec.Modify();
                end;
            }
        }
    }
}