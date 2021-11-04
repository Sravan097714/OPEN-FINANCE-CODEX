pageextension 50000 UserSetup extends "User Setup"
{
    layout
    {
        modify("Register Time")
        {
            Visible = false;
        }
        modify("Salespers./Purch. Code")
        {
            Visible = false;
        }
        modify("Sales Resp. Ctr. Filter")
        {
            Visible = false;
        }
        modify("Purchase Resp. Ctr. Filter")
        {
            Visible = false;
        }
        modify("Time Sheet Admin.")
        {
            Visible = false;
        }
        modify(Email)
        {
            Visible = false;
        }
        modify("Service Resp. Ctr. Filter")
        {
            Visible = false;
        }
        modify(PhoneNo)
        {
            Visible = false;
        }

        addlast(Control1)
        {
            field("Hide Unit Cost on Item List"; Rec."Hide Unit Cost on Item List")
            {
                ApplicationArea = All;
            }
            field("Hide Unit Price on Item List"; Rec."Hide Unit Price on Item List")
            {
                ApplicationArea = All;
            }
            field("Dis. Posting Button Prod Jnl"; Rec."Dis. Posting Button Prod Jnl")
            {
                ApplicationArea = All;
            }
            field("Purchase Order Posting"; Rec."Purchase Order Posting")
            {
                ApplicationArea = All;
            }
            field("Can released Purchase Order"; Rec."Can Released Purchase Order")
            {
                ApplicationArea = All;
            }
            field("Can reopen Purchase Order"; Rec."Can Reopen Purchase Order")
            {
                ApplicationArea = All;
            }
            field("Can Close Purchase Order"; Rec."Can Close Purchase Order")
            {
                ApplicationArea = All;
            }
            field("Can Post Positive Adjustment"; "Can Post Positive Adjustment")
            {
                ApplicationArea = all;
            }
            field("Can Post Negative Adjustment"; "Can Post Negative Adjustment")
            {
                ApplicationArea = all;
            }
            field("Edit Cost on Item Journal"; "Edit Cost on Item Journal")
            {
                ApplicationArea = All;
            }
            field("Edit Cost on Phys Inv Jnl"; "Edit Cost on Phys Inv Jnl")
            {
                ApplicationArea = All;
            }
            field("Approve Requisition Worksheet"; "Approve Requisition Worksheet")
            {
                ApplicationArea = All;
            }
            field("Void Check"; "Void Check") { ApplicationArea = All; }
            field("Void All Checks"; "Void All Checks") { ApplicationArea = All; }
            field("Void Check on Chk Led Entries"; "Void Check on Chk Led Entries") { ApplicationArea = All; }
            field("View Qty on Hand"; "View Qty on Hand") { ApplicationArea = All; }
            field("Print Discrepancy Report"; "Print Discrepancy Report") { ApplicationArea = All; }
            field("Edit GL Account Budget Purch"; "Edit GL Account Budget Purch") { ApplicationArea = All; }
            field("Can modify Cust Date Created"; "Can modify Cust Date Created") { ApplicationArea = All; }
            field("Validate Purchase Orders"; "Validate Purchase Orders") { ApplicationArea = All; }
            field("Clear Validated Purchase Order"; "Clear Validated Purchase Order") { ApplicationArea = All; }
        }
    }
}