page 50065 "Archived Bank Standing Order"
{
    PageType = Card;
    //ApplicationArea = All;
    //UsageCategory = Tasks;
    SourceTable = "Archived Bank Standing Orders";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {

            grid(GroupName)
            {
                GridLayout = Rows;
                field(Date; Date) { }
                field("Bank Standing Order No."; "Bank Standing Order No.") { ApplicationArea = All; }
                field("Created By"; "Created By") { ApplicationArea = All; }
            }

            group("Student Details")
            {
                grid("                  ")
                {
                    GridLayout = Rows;
                    group("    ")
                    {
                        field("Full Name of Applicant"; "Full Name of Applicant") { ApplicationArea = All; }
                        field(Address; Address) { ApplicationArea = All; }
                        field(City; City) { ApplicationArea = All; }
                        field(Country; Country) { ApplicationArea = All; }
                        field("National Identity No."; "National Identity No.") { ApplicationArea = All; }
                        field("Invoice Number"; "Invoice Number") { ApplicationArea = all; }
                    }
                }
            }

            group("Programme and Instalments Details")
            {
                grid("                               ")
                {
                    GridLayout = Rows;
                    group("       ")
                    {
                        field(Programme; Programme)
                        {
                            ApplicationArea = All;

                            trigger OnLookup(var Text: Text): Boolean
                            var
                                grecDimension: Record "Dimension Value";
                                gpageDimensionList: Page "Dimension Value List";
                            begin
                                Clear(gpageDimensionList);
                                grecDimension.Reset();
                                grecDimension.SetRange("Dimension Code", 'Programmes');
                                if grecDimension.FindFirst() then begin
                                    gpageDimensionList.SetRecord(grecDimension);
                                    gpageDimensionList.SetTableView(grecDimension);
                                    gpageDimensionList.LookupMode(true);
                                    if gpageDimensionList.RunModal() = Action::LookupOK then begin
                                        gpageDimensionList.GetRecord(grecDimension);
                                        Rec.Programme := grecDimension."Name 2";
                                    end;
                                end;
                            end;
                        }
                        field(Intake; Intake)
                        {
                            ApplicationArea = All;

                            trigger OnLookup(var Text: Text): Boolean
                            var
                                grecDimension: Record "Dimension Value";
                                gpageDimensionList: Page "Dimension Value List";
                            begin
                                Clear(gpageDimensionList);
                                grecDimension.Reset();
                                grecDimension.SetRange("Dimension Code", 'Intake');
                                if grecDimension.FindFirst() then begin
                                    gpageDimensionList.SetRecord(grecDimension);
                                    gpageDimensionList.SetTableView(grecDimension);
                                    gpageDimensionList.LookupMode(true);
                                    if gpageDimensionList.RunModal() = Action::LookupOK then begin
                                        gpageDimensionList.GetRecord(grecDimension);
                                        Rec.Intake := grecDimension.Name;
                                    end;
                                end;
                            end;
                        }

                        field(" "; '') { ApplicationArea = All; }
                        field(Year; Year) { ApplicationArea = All; }
                        field(Semester; Semester) { ApplicationArea = All; }
                        field("No. of Module"; "No. of Module") { ApplicationArea = All; }

                        field("  "; '') { ApplicationArea = All; }

                        field("Total Fee per Installment"; "Total Fee per Installment") { ApplicationArea = All; }
                        field("Currency Code"; "Currency Code") { ApplicationArea = All; }

                        field("   "; '') { ApplicationArea = All; }
                        field("No. of Installments"; "No. of Installments") { ApplicationArea = All; }
                        field("Total Fee for Installment"; "Total Fee for Installments") { ApplicationArea = All; }
                        field("Currency Code 2"; "Currency Code 2") { ApplicationArea = All; }
                    }
                }
            }

            group("Student Bank Details")
            {
                grid("")
                {
                    GridLayout = Rows;
                    group("        ")
                    {
                        field("Name of Bank"; "Name of Bank") { ApplicationArea = All; }
                        field("Address "; "Address 2") { ApplicationArea = All; Caption = 'Branch/ Head Office'; }
                        field("Current_Savings Account no."; "Current_Savings Account no.") { ApplicationArea = All; }
                        field("Instalment amount to Debit"; "Instalment amount to Debit") { ApplicationArea = All; }
                        field("From Month"; "From Month") { ApplicationArea = All; }
                        field("To Month Inclusive"; "To Month") { ApplicationArea = All; }
                    }
                }
            }

            group("Open University of Mauritius Bank Details")
            {
                grid("                     ")
                {
                    GridLayout = Rows;
                    group("            ")
                    {
                        field("Name of Bank 2"; "Name of Bank 2") { ApplicationArea = All; }
                        field("Account to Credit"; "Account to Credit") { ApplicationArea = All; }
                    }
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action("Print Learner Copy")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = BankContact;

                trigger OnAction()
                var
                    Bankstandingorderrec: Record "Bank Standing Orders";
                begin
                    Bankstandingorderrec.Reset();
                    Bankstandingorderrec.SetRange("Bank Standing Order No.", Rec."Bank Standing Order No.");
                    Report.Run(50087, true, false, Bankstandingorderrec);
                end;
            }

            action("Print Finance Copy")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Form;

                trigger OnAction()
                var
                    Bankstandingorderrec: Record "Bank Standing Orders";
                begin
                    Bankstandingorderrec.Reset();
                    Bankstandingorderrec.SetRange("Bank Standing Order No.", Rec."Bank Standing Order No.");
                    Report.Run(50086, true, false, Bankstandingorderrec);
                end;
            }
            action("Print Bank Copy")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Form;

                trigger OnAction()
                var
                    Bankstandingorderrec: Record "Bank Standing Orders";
                begin
                    Bankstandingorderrec.Reset();
                    Bankstandingorderrec.SetRange("Bank Standing Order No.", Rec."Bank Standing Order No.");
                    Report.Run(50099, true, false, Bankstandingorderrec);
                end;
            }
        }
    }

    var
        myInt: Integer;
}