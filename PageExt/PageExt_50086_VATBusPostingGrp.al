pageextension 50086 VATBusPostingGrpExt extends "VAT Business Posting Groups"
{
    layout
    {
        addlast(Control1)
        {
            field(Type; Type)
            {
                ApplicationArea = All;
                Editable = true;
            }
        }

    }
}