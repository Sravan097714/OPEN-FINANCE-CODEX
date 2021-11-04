report 50086 "FORM 3"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\FORM3.rdl';

    dataset
    {
        dataitem("Bank Standing Orders"; "Bank Standing Orders")
        {
            column(Date; Date) { }
            column(grecCompanyInfo; grecCompanyInfo.Name) { }
            column(Full_Name_of_Applicant; "Full Name of Applicant") { }
            column(Address; Address) { }
            column(City; City) { }
            column(Country; Country) { }
            column(Programme; Programme) { }
            column(Intake; Intake) { }
            column(Year; Year) { }
            column(Semester; Semester) { }
            column(No__of_Module; "No. of Module") { }
            column(Total_Fee_per_Installment; "Total Fee per Installment") { }
            column(Total_Fee_for_Installments; "Total Fee for Installments") { }
            column(Name_of_Bank; "Name of Bank") { }
            column(Address_2; "Address 2") { }
            column(Current_Savings_Account_no_; "Current_Savings Account no.") { }
            column(From_Month; "From Month") { }
            column(To_Month; "To Month") { }
            column(National_Identity_No_; "National Identity No.") { }
        }
    }

    var
        grecCompanyInfo: Record "Company Information";
}