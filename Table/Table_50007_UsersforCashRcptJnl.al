table 50007 "Users for Cash Receipt Journal"
{
    fields
    {
        field(1; UserID; Code[50])
        {
            trigger OnLookup()
            var
                grecUser: Record User;
                gpageUser: Page Users;
            begin
                Clear(gpageUser);
                grecUser.Reset();
                if grecUser.FindFirst() then begin
                    gpageUser.SetRecord(grecUser);
                    gpageUser.SetTableView(grecUser);
                    gpageUser.LookupMode(true);
                    if gpageUser.RunModal() = Action::LookupOK then begin
                        gpageUser.GetRecord(grecUser);
                        Rec.UserID := grecUser."User Name";
                    end;
                end;
            end;
        }
        field(2; "Jnl Template Name"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(3; "Jnl Batch Name"; Code[20])
        {
            trigger OnLookup()
            var
                grecGenJnlBatch: Record "Gen. Journal Batch";
                gpageGenJnlBatch: Page "General Journal Batches 2";
            begin
                Clear(gpageGenJnlBatch);
                grecGenJnlBatch.Reset();
                grecGenJnlBatch.SetRange("Journal Template Name", rec."Jnl Template Name");
                if grecGenJnlBatch.Findset() then begin
                    gpageGenJnlBatch.SetRecord(grecGenJnlBatch);
                    gpageGenJnlBatch.SetTableView(grecGenJnlBatch);
                    gpageGenJnlBatch.LookupMode(true);
                    if gpageGenJnlBatch.RunModal() = Action::LookupOK then begin
                        gpageGenJnlBatch.GetRecord(grecGenJnlBatch);
                        "Jnl Batch Name" := grecGenJnlBatch.Name;
                    end;
                end;
            end;
        }
        field(4; "Vendor Type"; Code[50])
        {
            TableRelation = "New Categories".Code;
        }
    }

    keys
    {
        key(PK; UserID, "Jnl Template Name", "Jnl Batch Name")
        {
            Clustered = true;
        }
    }
}