pageextension 50018 Currencies extends Currencies
{
    layout
    {
        // Add changes to page layout here
        modify(ExchangeRateAmt)
        {
            Visible = false;
        }
        modify("EMU Currency")
        {
            Visible = false;
        }
        modify("Amount Rounding Precision")
        {
            Visible = false;
        }
        modify("Amount Decimal Places")
        {
            Visible = false;
        }
        modify("Invoice Rounding Precision")
        {
            Visible = false;
        }
        modify("Invoice Rounding Type")
        {
            Visible = false;
        }
        modify("Unit-Amount Decimal Places")
        {
            Visible = false;
        }
        modify("Unit-Amount Rounding Precision")
        {
            Visible = false;
        }
        modify("Appln. Rounding Precision")
        {
            Visible = false;
        }
        modify("Conv. LCY Rndg. Credit Acc.")
        {
            Visible = false;
        }
        modify("Conv. LCY Rndg. Debit Acc.")
        {
            Visible = false;
        }
        modify("Last Date Adjusted")
        {
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Visible = false;
        }
        modify("Payment Tolerance %")
        {
            Visible = false;
        }
        modify("Max. Payment Tolerance Amount")
        {
            Visible = false;
        }

        addlast(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(4);
            }
        }
    }
}