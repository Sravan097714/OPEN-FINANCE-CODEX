pageextension 50046 SalesReturnOrderSubformExt extends "Sales Return Order Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Return Reason Code")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify(Type)
        {
            Visible = true;
            ApplicationArea = All;
        }


        addfirst(Control1)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }

        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }

        addafter(Quantity)
        {
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
            }
        }

        moveafter("Gen. Prod. Posting Group"; "VAT Prod. Posting Group")
    }
}