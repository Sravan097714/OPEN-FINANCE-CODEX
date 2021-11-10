report 50099 "Bank Copy"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\BankCopy.rdl';

    dataset
    {
        dataitem("Bank Standing Orders"; "Bank Standing Orders")
        {
            column(Date; Date) { }
            column(Name_of_Bank; "Name of Bank") { }
            column(Address_2; "Address") { }
            column(Current_Savings_Account_no_; "Current_Savings Account no.") { }
            column(Total_Fee_for_Installments; "Total Fee for Installments") { }
            column(From_Month; "From Month") { }
            column(To_Month; "To Month") { }
            column(Full_Name_of_Applicant; "Full Name of Applicant") { }
            column(National_Identity_No_; "National Identity No.") { }
        }
    }

    var
        grecCompanyInfo: Record "Company Information";
}