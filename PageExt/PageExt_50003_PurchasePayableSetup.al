pageextension 50003 PurchasePayableSetup extends "Purchases & Payables Setup"
{
    layout
    {
        addlast(General)
        {
            field("Doc. Posting Date as WORKDATE"; rec."Doc. Posting Date as WORKDATE")
            {
                ApplicationArea = All;
            }
            field("Threshold Goods & Services Rpt"; "Threshold Goods & Services Rpt")
            {
                ApplicationArea = all;
            }
            field("Sign for Emoluments"; "Sign for Emoluments") { ApplicationArea = All; }

            group("Report ID")
            {
                field("Bank Transfer Report ID"; "Bank Transfer Report ID")
                {
                    ApplicationArea = All;
                }
                field("Vendor Cheque Trans. Report ID"; "Vendor Cheque Trans. Report ID")
                {
                    ApplicationArea = All;
                }
                field("Vendor Bank Trans. Report ID"; "Vendor Bank Trans. Report ID")
                {
                    ApplicationArea = All;
                }
                field("Signature 1"; "Signature 1")
                {
                    ApplicationArea = All;
                }
                field("Signature 2"; "Signature 2")
                {
                    ApplicationArea = All;
                }
                field("Retention Fee"; "Retention Fee") { ApplicationArea = All; }
                field("PAYE Claims"; "PAYE Claims") { ApplicationArea = all; }
                field("PAYE Payroll"; "PAYE Payroll") { ApplicationArea = all; }
            }
        }
        addafter(General)
        {
            group(Signature)
            {
                field("Bulk Bank Transfer – Chaiman"; "Bulk Bank Transfer – Chaiman") { ApplicationArea = All; }
                field("Bank Trans – Director General"; "Bank Trans – Director General") { ApplicationArea = All; }
                field("Bulk Bank Transfer – enc."; "Bulk Bank Transfer – enc.") { ApplicationArea = All; }
            }
        }
        addlast("Number Series")
        {
            field("Requisition No. Series"; "Requisition No. Series") { ApplicationArea = All; }
            field("Claim No. Series"; "Claim No. Series") { ApplicationArea = All; }
        }
    }
}