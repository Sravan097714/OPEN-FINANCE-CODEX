tableextension 50012 SalesReceivablesSetupExt extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Doc. Posting Date as WORKDATE"; Code[20]) { }
        field(50001; "Use Available Inventory Only"; Boolean) { }
        field(50002; "Upload Customer Payments"; code[20])
        {
            Caption = 'Upload List of Customer Payments';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = filter('CASH RECE'));
        }
        field(50003; "VAT Product on OU Sales App"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(50004; "G/L Acc. for App Reg OU Portal"; Code[20])
        {
            Caption = 'G/L Acc. for Application Registration OU Portal';
            TableRelation = "G/L Account";
        }
        field(50005; "Bank Acc. No. for OU Portal"; Code[20])
        {
            Caption = 'Bank Acc. for Application Registration OU Portal';
            TableRelation = "Bank Account";
        }

        field(50006; "Journal Batch Name OU Portal"; code[50])
        {
            //TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = filter('CASH RECE' ));
            trigger OnLookup()
            var
                grecGenJnlBatch: Record "Gen. Journal Batch";
                gpageGenJnlBatch: Page "General Journal Batches 2";
            begin
                Clear(gpageGenJnlBatch);
                grecGenJnlBatch.Reset();
                grecGenJnlBatch.SetRange("Journal Template Name", 'CASH RECE');
                if grecGenJnlBatch.Findset() then begin
                    gpageGenJnlBatch.SetRecord(grecGenJnlBatch);
                    gpageGenJnlBatch.SetTableView(grecGenJnlBatch);
                    gpageGenJnlBatch.LookupMode(true);
                    if gpageGenJnlBatch.RunModal() = Action::LookupOK then begin
                        gpageGenJnlBatch.GetRecord(grecGenJnlBatch);
                        "Journal Batch Name OU Portal" := grecGenJnlBatch.Name;
                    end;
                end;
            end;
        }
        field(50007; "No. Series for OU Portal"; Code[20])
        {

            Caption = 'No. Series for Application Registration OU Portal';
            TableRelation = "No. Series";
        }
        field(50008; "Sales Invoice Signature Name"; Text[50]) { }
        field(50009; "VAT Bus. Posting Group"; Code[20])
        {
            TableRelation = "VAT Business Posting Group";
        }
        field(50010; "Gen. Bus. Posting Group"; Code[20])
        {
            TableRelation = "Gen. Business Posting Group";
        }
        field(50011; "Customer Posting Group"; Code[20])
        {
            TableRelation = "Customer Posting Group";
        }
        field(50012; "Sign for Statement of Accounts"; Text[50])
        {
            Caption = 'Signature for Statement of Accounts';
        }
        field(50013; "Sign for Reminders"; Text[50]) { }
        field(50014; "Post Cash Receipts today"; Boolean)
        {
            Caption = 'Post Cash Receipts todays date';
        }
        field(50015; "Posted Inv Nos. for OU Portal"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50016; "Bank Standing Order Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50017; "G/L for Penalty Fee"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50018; "G/L for Exemption Fee"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50019; "Exemption Amount"; Decimal) { }
    }
}