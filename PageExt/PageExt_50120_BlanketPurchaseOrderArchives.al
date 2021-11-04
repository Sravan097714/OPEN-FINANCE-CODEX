pageextension 50120 BlanketPOArchives extends "Blanket Purch. Order Archives"
{
    layout
    {
        modify("Interaction Exist") { Visible = false; }
        modify("Vendor Authorization No.") { Visible = false; }
        modify("Location Code") { Visible = false; }
        modify("Currency Code") { Visible = true; }
        modify("Time Archived") { Visible = false; }
        modify("Archived By")
        {
            Caption = 'Closed By';
        }
        modify("Date Archived")
        {
            Caption = 'Closed On';
        }

        addfirst(Control29)
        {
            field("Order Date"; "Order Date") { ApplicationArea = All; }
            field("Document Type"; "Document Type") { ApplicationArea = All; }
            field("No."; "No.") { ApplicationArea = All; }
        }
        moveafter("Currency Code"; "Archived By")
        moveafter("Currency Code"; "Date Archived")
    }
}