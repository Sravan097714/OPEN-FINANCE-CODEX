pageextension 50017 PaymentTermsExt extends "Payment Terms"
{
    layout
    {
        modify("Discount Date Calculation")
        {
            Visible = false;
        }
        modify("Discount %")
        {
            Visible = false;
        }
        modify("Calc. Pmt. Disc. on Cr. Memos")
        {
            Visible = false;
        }
        moveafter(Code; Description)
    }
}