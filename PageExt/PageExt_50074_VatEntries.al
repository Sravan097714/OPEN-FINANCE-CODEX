pageextension 50074 VatEntries extends "VAT Entries"
{
    layout
    {
        modify("Gen. Bus. Posting Group")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = true;
            ApplicationArea = All;

        }
        modify("Document Date")
        {
            ApplicationArea = All;
            Visible = true;
        }
        modify("Country/Region Code")
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Internal Ref. No.")
        {
            Visible = false;
        }
        modify("VAT Registration No.")
        {
            Visible = true;
            ApplicationArea = All;
        }

        addlast(Control1)
        {
            field("User ID"; Rec."User ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
}