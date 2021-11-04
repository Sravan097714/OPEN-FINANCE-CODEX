pageextension 50031 PurchOrderArchiveSubform extends "Purchase Order Archive Subform"
{
    layout
    {
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Unit of Measure Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Deferral Code")
        {
            Visible = false;
        }
        modify("Order Date")
        {
            Visible = false;
        }
        modify("Planned Receipt Date")
        {
            Visible = false;
        }
        modify("Expected Receipt Date")
        {
            Visible = false;
        }
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
}