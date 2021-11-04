pageextension 50113 VendBankAccList extends "Vendor Bank Account List"
{
    layout
    {
        modify("Bank Account No.")
        {
            Visible = true;
        }

        addlast(Control1)
        {
            field("Bank Branch No."; "Bank Branch No.") { ApplicationArea = All; }
            field(Address; Address) { ApplicationArea = All; }
        }
    }
}