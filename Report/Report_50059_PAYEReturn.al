report 50059 "PAYE Return Finance"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\PAYEReturn.rdl';


    dataset
    {
        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "No.", "Date Filter";
            column(No_; "No.") { }
            column(Name; Name) { }
            column(Name_2; "Name 2") { }
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyBRN; CompanyInfo.BRN) { }
            column(CompanyPhone; CompanyInfo."Phone No.") { }
            column(CompanyMobile; CompanyInfo."Mobile Number") { }
            column(NameofDeclarant; CompanyInfo."Name Of Declarant") { }
            column(VATEmail; CompanyInfo."E-mail Payer") { }
            column(EmployerRN; CompanyInfo."Employer Registration No.") { }
            column(NID; NID) { }
            column(EmolumentAmtGVar; EmolumentAmtGVar) { }
            column(PAYEAmtGVar; PAYEAmtGVar) { }
            column(TaxPeriod; TaxPeriod) { }
            column(Surname; Surname) { }
            column(Other_Names; "Other Names") { }
            trigger OnAfterGetRecord()
            begin
                Clear(EmolumentAmtGVar);
                Clear(PAYEAmtGVar);
                /*
                VLE.Reset();
                VLE.SetRange("Vendor No.", "No.");
                VLE.SetRange("Document Type", VLE."Document Type"::Payment);
                if DateFilterGVar <> '' then
                    VLE.SetFilter("Posting Date", DateFilterGVar);
                if VLE.FindSet() then
                    repeat
                        VLE.CalcFields("Original Amt. (LCY)");
                        EmolumentAmtGVar += Abs(Round(VLE."Original Amt. (LCY)", 1, '='));
                    until VLE.Next() = 0;
                */

                PurchInvHdr.Reset();
                PurchInvHdr.SetRange("Buy-from Vendor No.", "No.");
                if DateFilterGVar <> '' then
                    PurchInvHdr.SetFilter("Posting Date", DateFilterGVar);
                if PurchInvHdr.FindSet() then
                    repeat
                        PurchInvLine.Reset();
                        PurchInvLine.SetRange("Document No.", PurchInvHdr."No.");
                        PurchInvLine.SetFilter(Amount, '>%1', 0);
                        if PurchInvLine.FindSet() then begin
                            PurchInvLine.CalcSums(PurchInvLine."Line Amount");
                            EmolumentAmtGVar += Abs(Round(PurchInvLine."Line Amount", 1, '='));
                        end;
                        PurchInvLine.Reset();
                        PurchInvLine.SetRange("Document No.", PurchInvHdr."No.");
                        PurchInvLine.SetRange(PAYE, true);
                        PurchInvLine.SetRange(Type, PurchInvLine.Type::"G/L Account");
                        PurchInvLine.SetRange("No.", PurchasePaybleSetup."PAYE Claims");
                        if PurchInvLine.FindSet() then begin
                            PurchInvLine.CalcSums(PurchInvLine."Line Amount");
                            PAYEAmtGVar += Abs(Round(PurchInvLine."Line Amount", 1, '='));
                        end;
                    until PurchInvHdr.Next() = 0;
                if (PAYEAmtGVar = 0) then
                    CurrReport.Skip();
            end;
        }
    }


    requestpage
    {
        layout
        {
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        PurchasePaybleSetup.Get();
        PurchasePaybleSetup.TestField("PAYE Claims");
        DateFilterGVar := Vendor.GetFilter("Date Filter");
        EndDate := Vendor.GetRangeMax("Date Filter");
        TaxPeriod := CopyStr(Format(Date2DMY(EndDate, 3)), 3, 2) + Format(Date2DMY(EndDate, 2));
    end;

    var
        CompanyInfo: Record "Company Information";
        EmolumentAmtGVar: Decimal;
        PAYEAmtGVar: Decimal;
        PurchInvLine: Record "Purch. Inv. Line";
        PurchInvHdr: Record "Purch. Inv. Header";
        VLE: Record "Vendor Ledger Entry";
        PurchasePaybleSetup: Record "Purchases & Payables Setup";
        DateFilterGVar: Text;
        TaxPeriod: Text;
        EndDate: Date;
}
