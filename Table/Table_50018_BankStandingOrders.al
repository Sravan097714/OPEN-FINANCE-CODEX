table 50018 "Bank Standing Orders"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bank Standing Order No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Full Name of Applicant"; Text[100])
        {
            trigger OnLookup()
            var
                grecCustomer: Record Customer;
                gpageCustList: Page "Customer List";
            begin
                grecCustomer.Reset();
                grecCustomer.SetRange("No.");
                if grecCustomer.FindFirst() then begin
                    gpageCustList.SetRecord(grecCustomer);
                    gpageCustList.SetTableView(grecCustomer);
                    gpageCustList.LookupMode(true);
                    if gpageCustList.RunModal() = Action::LookupOK then begin
                        gpageCustList.GetRecord(grecCustomer);
                        "Full Name of Applicant" := grecCustomer.Name;
                        Address := grecCustomer.Address;
                        City := grecCustomer.City;
                        Country := grecCustomer."Country/Region Code";
                    end;
                end;
            end;
        }
        field(3; Address; Text[100]) { }
        field(4; City; Text[30]) { }
        field(5; Country; Code[10]) { }


        field(6; Programme; Text[250])
        {
            Caption = 'Programme / Course enrolled for';
            //TableRelation = "Dimension Value"."Name 2" where("Dimension Code" = filter('Programmes'));
        }
        field(7; Intake; Text[20])
        {
            //TableRelation = "Dimension Value".Name where("Dimension Code" = filter('Intake'));
        }

        field(8; Year; Text[10]) { }
        field(9; Semester; Text[10]) { }
        field(10; "No. of Module"; text[2]) { }

        field(11; "Total Fee per Installment"; Decimal) { }
        field(12; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }

        field(13; "Name of Bank"; Text[50]) { }
        field(14; "Address 2"; Text[50]) { }
        field(15; "Current_Savings Account no."; Text[20])
        {
            Caption = 'Student Current / Savings Account No.';
        }
        field(16; "From Month"; Text[15]) { }
        field(17; "To Month"; Text[15]) { }

        field(18; "Account to Credit"; Text[20]) { }

        field(19; "National Identity No."; Text[20]) { }

        field(20; "No. of Installments"; Integer) { }
        field(21; "Total Fee for Installments"; Decimal)
        {
            Caption = 'Total Fee for all Installments';
        }
        field(22; "Currency Code 2"; Code[10])
        {
            TableRelation = Currency;
            Caption = 'Currency Code';
        }
        field(23; "Instalment amount to Debit"; Decimal) { }
        field(24; "Name of Bank 2"; text[50])
        {
            Caption = 'Name of Bank';
        }
        field(25; "Address 1"; Text[50]) { }
        field(26; Date; Date) { }
        field(27; "Created By"; Text[100]) { Editable = false; }

    }


    keys
    {
        key(Key1; "Bank Standing Order No.")
        {
            Clustered = true;
        }
    }

    var
        grecCustomer: Record "Dimension Value";
        grecSalesReceivableSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;


    trigger OnInsert()
    begin
        grecSalesReceivableSetup.Get;
        "Name of Bank 2" := 'State Bank of Mauritius Ltd';
        "Bank Standing Order No." := NoSeriesMgt.GetNextNo(grecSalesReceivableSetup."Bank Standing Order Nos.", Today, TRUE);
        "Created By" := UserId;
        Date := Today;
    end;


}