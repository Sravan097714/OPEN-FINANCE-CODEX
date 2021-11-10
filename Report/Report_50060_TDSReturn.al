report 50060 "TDS Return Finance"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\TDSReturn.rdl';


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

            column(PayerTaxAcc; CompanyInfo."VAT Payer Tax") { }
            column(NID; NIDVar) { }
            column(TaxPeriod; TaxPeriod) { }
            column(EmolumentAmtGVar; EmolumentAmtGVar) { }
            column(PAYEAmtGVar; PAYEAmtGVar) { }
            column(Surname; Surname) { }
            column(Other_Names; "Other Names") { }
            trigger OnAfterGetRecord()
            begin
                Clear(EmolumentAmtGVar);
                Clear(PAYEAmtGVar);
                Clear(NIDVar);
                if NID <> '' then
                    NIDVar := NID
                else
                    NIDVar := BRN;
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
                        /*
                            PurchInvHdr.CalcFields(Amount);
                            EmolumentAmtGVar += Abs(Round(PurchInvHdr.Amount, 1, '='));
                        */
                        PurchInvLine.Reset();
                        PurchInvLine.SetRange("Document No.", PurchInvHdr."No.");
                        PurchInvLine.SetFilter(Amount, '>%1', 0);
                        if PurchInvLine.FindSet() then
                            repeat
                                if not PurchInvLine.VAT then
                                    EmolumentAmtGVar += Abs(Round(PurchInvLine."Line Amount", 1, '='))
                                else
                                    EmolumentAmtGVar += Abs(Round(PurchInvLine."Line Amount Excluding VAT", 1, '='));
                            until PurchInvLine.Next() = 0;

                        PurchInvLine.Reset();
                        PurchInvLine.SetRange("Document No.", PurchInvHdr."No.");
                        PurchInvLine.SetRange(Type, PurchInvLine.Type::"G/L Account");
                        PurchInvLine.SetRange("No.", '110080');
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
        DateFilterGVar: Text;
        EndDate: Date;
        TaxPeriod: Text;
        NIDVar: Text;
}
