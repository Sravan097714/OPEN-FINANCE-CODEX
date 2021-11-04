pageextension 50109 VendorLookup extends "Vendor Lookup"
{
    layout
    {
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Purchaser Code")
        {
            Visible = false;
        }

        addlast(Group)
        {
            field("Vendor Type"; "Vendor Type") { ApplicationArea = All; }
            field("Vendor Category"; "Vendor Category") { ApplicationArea = All; }
            field(Status; Status) { ApplicationArea = All; }
        }
    }


}