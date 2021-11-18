pageextension 50029 PurchHdrArchiveListExt extends "Purchase Order Archives"
{
    layout
    {
        modify("Interaction Exist")
        {
            Visible = false;
        }
        modify("Vendor Authorization No.")
        {
            Visible = false;
        }
        modify("Buy-from Post Code")
        {
            Visible = false;
        }
        modify("Buy-from Contact")
        {
            Visible = false;
        }
        modify("Buy-from Country/Region Code")
        {
            Visible = false;
        }
        modify("Posting Date")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
            ApplicationArea = All;
        }

        modify("Currency Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Due Date")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Location Code")
        {
            Visible = false;
        }

        addlast(Control1)
        {
            field("Cancelled By"; Rec."Cancelled By")
            {
                ApplicationArea = All;
                //Caption = 'Closed By';
            }
            field("Date Cancelled"; Rec."Date Cancelled")
            {
                ApplicationArea = All;
                //Caption = 'Date Closed';
            }
            field("Time Cancelled"; Rec."Time Cancelled")
            {
                ApplicationArea = All;
                //Caption = 'Time Closed';
            }
        }
    }

    actions
    {
        modify("Delete Order Versions")
        {
            Visible = false;
        }

    }
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Cancelled By", '<>%1', '');
        Rec.FilterGroup(0)
    end;
}