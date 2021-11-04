pageextension 50009 VendorExt extends "Vendor Card"
{
    layout
    {
        modify(Address)
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Address 2")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(Receiving)
        {
            Visible = false;
        }
        modify(City)
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(County)
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify(Contact)
        {
            Visible = true;
        }
        modify("Country/Region Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Balance Due (LCY)")
        {
            Visible = false;
        }
        modify("Document Sending Profile")
        {
            Visible = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("Purchaser Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Disable Search by Name")
        {
            Visible = false;
        }
        modify("Our Account No.")
        {
            Visible = false;
        }
        modify("Language Code")
        {
            Visible = false;
        }
        modify("Pay-to Vendor No.")
        {
            Visible = false;
        }
        modify("Invoice Disc. Code")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = true;
        }
        modify(Priority)
        {
            Visible = false;
        }
        modify("Block Payment Tolerance")
        {
            Visible = false;
        }
        modify("Preferred Bank Account Code")
        {
            Visible = false;
        }

        modify("Partner Type")
        {
            Visible = false;
        }
        modify("Cash Flow Payment Terms Code")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        modify("Lead Time Calculation")
        {
            Visible = false;
        }
        modify("Base Calendar Code")
        {
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Privacy Blocked")
        {
            Visible = false;
        }
        modify("Primary Contact No.")
        {
            Visible = false;
        }
        modify("Customized Calendar")
        {
            Visible = false;
        }
        modify(GLN)
        {
            Visible = false;
        }
        modify("Prepayment %")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                grecVATBusPostingGrp: Record "VAT Business Posting Group";
                gpageVatBusPostingGrp: Page "VAT Business Posting Groups";
            begin
                Clear(gpageVatBusPostingGrp);
                grecVATBusPostingGrp.Reset();
                grecVATBusPostingGrp.SetRange(Type, grecVATBusPostingGrp.Type::Vendor);
                if grecVATBusPostingGrp.FindFirst() then begin
                    gpageVatBusPostingGrp.SetRecord(grecVATBusPostingGrp);
                    gpageVatBusPostingGrp.SetTableView(grecVATBusPostingGrp);
                    gpageVatBusPostingGrp.LookupMode(true);
                    if gpageVatBusPostingGrp.RunModal() = Action::LookupOK then begin
                        gpageVatBusPostingGrp.GetRecord(grecVATBusPostingGrp);
                        Rec."VAT Bus. Posting Group" := grecVATBusPostingGrp.Code;
                    end;
                end;
            end;
        }

        modify("Gen. Bus. Posting Group")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                grecGenBusPostingGrp: Record "Gen. Business Posting Group";
                gpageGenBusPostingGrp: Page "Gen. Business Posting Groups";
            begin
                Clear(gpageGenBusPostingGrp);
                grecGenBusPostingGrp.Reset();
                grecGenBusPostingGrp.SetRange(Type, grecGenBusPostingGrp.Type::Vendor);
                if grecGenBusPostingGrp.FindFirst() then begin
                    gpageGenBusPostingGrp.SetRecord(grecGenBusPostingGrp);
                    gpageGenBusPostingGrp.SetTableView(grecGenBusPostingGrp);
                    gpageGenBusPostingGrp.LookupMode(true);
                    if gpageGenBusPostingGrp.RunModal() = Action::LookupOK then begin
                        gpageGenBusPostingGrp.GetRecord(grecGenBusPostingGrp);
                        Rec."Gen. Bus. Posting Group" := grecGenBusPostingGrp.Code;
                    end;
                end;
            end;
        }
        modify("Payment Method Code")
        {
            trigger OnAfterValidate()
            begin
                if "Payment Method Code" = 'BANKTRANS' then begin
                    if ("Bank Accout No." = '') or ("Bank Name" = '') then
                        Error('Please fill in Bank Account No. and Bank Name.');
                end;
            end;
        }
        /* modify(Balance)
        {
            Visible = true;
        }

        addafter(Blocked)
        {
            field(Balance; Rec.Balance)
            {
                Editable = false;
                ApplicationArea = All;
            }
        } */

        modify("No.")
        {
            Visible = false;
        }

        addafter(Payments)
        {
            group("Bank Details")
            {
                field("Bank Accout No."; "Bank Accout No.") { ApplicationArea = All; }
                field("Bank Name"; "Bank Name") { ApplicationArea = All; }
                field("Bank Address"; "Bank Address") { ApplicationArea = All; }
                field(IBAN; IBAN) { ApplicationArea = All; }
                field("SWIFT Code"; "SWIFT Code") { ApplicationArea = All; }
                field("SORT Code"; "SORT Code") { ApplicationArea = All; }
                field("Bank Code"; "Bank Code") { ApplicationArea = All; }
            }
        }

        addlast(General)
        {
            field(BRN; Rec.BRN)
            {
                ApplicationArea = All;
            }
            field(NID; NID)
            {
                ApplicationArea = All;
            }
            field("TAN Number"; "TAN Number")
            {
                ApplicationArea = all;
            }
            field("Vendor Type"; "Vendor Type")
            {
                ApplicationArea = All;
            }
            field("SME Registration Number"; "SME Registration Number")
            {
                ApplicationArea = All;
            }
            field("Vendor Category"; "Vendor Category")
            {
                ApplicationArea = All;
            }
            field("Name of Client"; "Name of Client")
            {
                ApplicationArea = All;
            }
            field("No. of Years in Business"; "No. of Years in Business")
            {
                ApplicationArea = All;
            }
            field(Status; Status)
            {
                ApplicationArea = All;
            }
            field("Date of Registration"; "Date of Registration")
            {
                ApplicationArea = all;
            }
            field("Created By"; "Created By")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Date Created"; "Date Created")
            {
                ApplicationArea = ALl;
                Editable = false;
            }
        }

        addafter("Address & Contact")
        {
            group(Representative)
            {
                field("Representative Name"; "Representative Name")
                {
                    ApplicationArea = All;
                }
                field("Position Held"; "Position Held")
                {
                    ApplicationArea = All;
                }
                field(NIC; NIC)
                {
                    ApplicationArea = All;
                }
                field("Representative Address 1"; "Representative Address 1")
                {
                    ApplicationArea = All;
                }
                field("Representative Address 2"; "Representative Address 2")
                {
                    ApplicationArea = All;
                }
                field("Telephone Number"; "Telephone Number")
                {
                    ApplicationArea = All;
                }
                field("Fax Number"; "Fax Number")
                {
                    ApplicationArea = All;
                }
                field("Email Address"; "Email Address")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Search Name")
        {
            field(Surname; Rec.Surname)
            {
                ApplicationArea = all;
            }
            field("Other Names"; Rec."Other Names")
            {
                ApplicationArea = all;
            }
        }
    }

}