pageextension 50007 CustomerExt extends "Customer Card"
{
    layout
    {
        modify("IC Partner Code")
        {
            Visible = false;
        }
        /* modify("Balance Due (LCY)")
        {
            Visible = false;
        } */
        modify("Privacy Blocked")
        {
            Visible = false;
        }
        modify(County)
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Service Zone Code")
        {
            Visible = false;
        }
        modify("Document Sending Profile")
        {
            Visible = false;
        }
        modify("Disable Search by Name")
        {
            Visible = false;
        }
        modify("Language Code")
        {
            Visible = false;
        }
        modify(GLN)
        {
            Visible = false;
        }
        modify("Copy Sell-to Addr. to Qte From")
        {
            Visible = false;
        }
        modify("Customer Disc. Group")
        {
            Visible = false;
        }
        modify("Customer Price Group")
        {
            Visible = false;
        }
        modify("Allow Line Disc.")
        {
            Visible = false;
        }
        modify("Invoice Disc. Code")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify("Prepayment %")
        {
            Visible = false;
        }
        modify("Partner Type")
        {
            Visible = false;
        }
        modify("Reminder Terms Code")
        {
            Visible = true;
            Editable = true;
        }
        modify("Fin. Charge Terms Code")
        {
            Visible = false;
        }
        modify("Cash Flow Payment Terms Code")
        {
            Visible = false;
        }
        modify("Print Statements")
        {
            Visible = false;
        }
        modify("Last Statement No.")
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
        modify(Shipping)
        {
            Visible = false;
        }
        modify(TotalSales2)
        {
            Visible = false;
        }
        modify(AdjCustProfit)
        {
            Visible = false;
        }
        modify(AdjProfitPct)
        {
            Visible = false;
        }
        modify("CustSalesLCY - CustProfit - AdjmtCostLCY")
        {
            Visible = false;
        }
        modify("Primary Contact No.")
        {
            Visible = false;
        }
        modify("Shipment Method Code")
        {
            Visible = true;
            Caption = 'MRU Post Code';
        }
        modify("Shipping Agent Code")
        {
            Visible = false;
        }
        modify("Shipping Agent Service Code")
        {
            Visible = false;
        }
        modify("Shipping Time")
        {
            Visible = false;
        }
        modify("Base Calendar Code")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Combine Shipments")
        {
            Visible = false;
        }
        modify(Reserve)
        {
            Visible = false;
        }
        modify("Shipping Advice")
        {
            Visible = false;
        }
        modify("Use GLN in Electronic Document")
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
        modify(Balance)
        {
            Visible = false;
        }
        modify("Balance (LCY)")
        {
            Visible = false;
        }
        modify("Balance Due (LCY)")
        {
            Visible = false;
        }
        modify(Statistics) { Visible = false; }
        modify("Last Date Modified") { Visible = false; }
        modify(PriceAndLineDisc) { Visible = false; }
        modify("VAT Bus. Posting Group")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                grecVATBusPostingGrp: Record "VAT Business Posting Group";
                gpageVatBusPostingGrp: Page "VAT Business Posting Groups";
            begin
                Clear(gpageVatBusPostingGrp);
                grecVATBusPostingGrp.Reset();
                grecVATBusPostingGrp.SetRange(Type, grecVATBusPostingGrp.Type::Customer);
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
                grecGenBusPostingGrp.SetRange(Type, grecGenBusPostingGrp.Type::Customer);
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

        addafter(Name)
        {
            /* field("Balance "; Rec.Balance)
            {
                ApplicationArea = All;
            } */
        }

        addafter("VAT Registration No.")
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }


        addlast(General)
        {
            field(BRN; Rec.BRN)
            {
                ApplicationArea = All;
            }
            field(NIC; NIC)
            {
                ApplicationArea = All;
            }
            field("Customer Category"; "Customer Category")
            {
                ApplicationArea = All;
            }
            field("First Name"; "First Name")
            {
                ApplicationArea = All;
            }
            field("Maiden Name"; "Maiden Name")
            {
                ApplicationArea = All;
            }
            field("Last Name"; "Last Name")
            {
                ApplicationArea = All;
            }
            field("Date Created"; "Date Created") { ApplicationArea = All; }
            field("Created By"; "Created By") { ApplicationArea = All; }
            field("Balance(LCY)"; "Balance (LCY)") { ApplicationArea = all; }
        }
        moveafter(NIC; "VAT Registration No.")

        addafter("E-Mail")
        {
            field("Login Email"; "Login Email") { ApplicationArea = all; }
        }

        modify("E-Mail")
        {
            Caption = 'Contact Email';
        }
        addbefore(ContactName)
        {
            field("Contact Title"; Rec."Contact Title") { ApplicationArea = all; }
        }
    }

    trigger OnOpenPage()
    var
        grecUserSetup: Record "User Setup";
    begin
        if grecUserSetup.Get(UserId) then
            gboolEdit := grecUserSetup."Can modify Cust Date Created";
    end;


    var
        gboolEdit: Boolean;
}