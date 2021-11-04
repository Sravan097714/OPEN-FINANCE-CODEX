tableextension 50019 UserSetupExt extends "User Setup"
{
    fields
    {
        field(50000; "Hide Unit Cost on Item List"; Boolean) { }
        field(50001; "Hide Unit Price on Item List"; Boolean) { }
        field(50002; "Dis. Posting Button Prod Jnl"; Boolean)
        {
            Caption = 'Disable Posting Button on Prod Jnl';
        }
        field(50003; "Purchase Order Posting"; Option)
        {
            OptionMembers = " ",Receive,Invoice,"Receive and Invoice",All;
        }
        field(50004; "Can Released Purchase Order"; Boolean) { }
        field(50005; "Can Reopen Purchase Order"; Boolean) { }
        field(50006; "Can Close Purchase Order"; Boolean) { }
        field(50007; "Can Post Positive Adjustment"; Boolean) { }
        field(50008; "Can Post Negative Adjustment"; Boolean) { }
        field(50009; "Edit Cost on Item Journal"; Boolean) { }
        field(50010; "Edit Cost on Phys Inv Jnl"; Boolean)
        {
            Caption = 'Edit Cost on Physical Inventory Journal';
        }
        field(50011; "Approve Requisition Worksheet"; Boolean) { }
        field(50012; "Void Check"; Boolean) { }
        field(50013; "Void All Checks"; Boolean) { }
        field(50014; "Void Check on Chk Led Entries"; Boolean)
        {
            Caption = 'Can Void Check on Check Ledger Entries';
        }
        field(50015; "View Qty on Hand"; Boolean)
        {
            Caption = 'View Qty. on Hand on Phys. Inventory List Report';
        }
        field(50016; "Print Discrepancy Report"; Boolean)
        {
            Caption = 'Print Physical Inventory Discrepancy Report';
        }
        field(50017; "Edit GL Account Budget Purch"; Boolean)
        {
            Caption = 'Can edit GL Account Budget on Purchases';
        }
        field(50018; "Can modify Cust Date Created"; Boolean)
        {
            Caption = 'Can modify Date Created for customers';
        }
        field(50019; "Validate Purchase Orders"; Boolean) { }
        field(50020; "Clear Validated Purchase Order"; Boolean) { }
    }
}