pageextension 50078 ApplyVendEntriesExt extends "Apply Vendor Entries"
{
    layout
    {
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Pmt. Disc. Tolerance Date")
        {
            Visible = false;
        }
        modify("Remaining Pmt. Disc. Possible")
        {
            Visible = false;
        }
        modify("Max. Payment Tolerance")
        {
            Visible = false;
        }
        modify("Payment Reference")
        {
            Visible = false;
        }
    }
}