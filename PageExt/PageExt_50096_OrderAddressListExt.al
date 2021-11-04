pageextension 50096 OrderAddressListExt extends "Order Address List"
{
    layout
    {
        modify(Address)
        {
            Visible = true;
            Editable = true;
            ApplicationArea = All;
        }
        modify("Address 2")
        {
            Visible = true;
            Editable = true;
            ApplicationArea = All;
        }
        modify("Country/Region Code")
        {
            Visible = true;
            Editable = true;
            ApplicationArea = All;
        }
        modify("Post Code")
        {
            Visible = true;
            Editable = true;
            ApplicationArea = All;
        }
    }
}