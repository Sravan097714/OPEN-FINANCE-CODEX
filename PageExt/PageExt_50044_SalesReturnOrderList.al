pageextension 50044 SalesReturnOrderListExt extends "Sales Return Order List"
{
    layout
    {
        addlast(Control1)
        {
            field(BRN; Rec.BRN)
            {
                ApplicationArea = All;
            }
            field("Created By"; Rec."Created By")
            {
                ApplicationArea = All;
            }
        }
    }
}