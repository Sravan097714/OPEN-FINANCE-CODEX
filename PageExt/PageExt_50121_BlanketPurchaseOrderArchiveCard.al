pageextension 50121 BlanketPOArchiveCard extends "Blanket Purchase Order Archive"
{
    layout
    {
        modify("Vendor Order No.") { Visible = false; }
        modify("Vendor Shipment No.") { Visible = false; }
        modify("Vendor Invoice No.") { Visible = false; }
        modify("Responsibility Center") { Visible = false; }
        modify("Interaction Exist") { Visible = false; }

        modify(Invoicing) { Visible = false; }
        modify(Shipping) { Visible = false; }
        modify("Foreign Trade") { Visible = false; }
        modify(Version) { Visible = false; }
        modify("Archived By")
        {
            Caption = 'Closed By';
        }

        modify("Date Archived")
        {
            Caption = 'Closed On';
        }

        movelast(General; "Prices Including VAT")
        moveafter("Prices Including VAT"; "Currency Code")
        moveafter("Currency Code"; "Date Archived")
        moveafter("Currency Code"; "Archived By")
        addlast(General)
        {
            field("Created By"; "Created By") { ApplicationArea = All; }
        }
    }
}