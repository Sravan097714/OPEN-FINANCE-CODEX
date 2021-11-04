pageextension 50126 PostedSalesShipmentSubformExt extends "Posted Sales Shpt. Subform"
{
    layout
    {
        modify("Location Code") { Visible = false; }
        modify("Planned Delivery Date") { Visible = false; }
        modify("Planned Shipment Date") { Visible = false; }
        modify("Shipment Date") { Visible = false; }

        addfirst(Control1)
        {
            field("Line No."; "Line No.") { Editable = false; }
        }
    }
}