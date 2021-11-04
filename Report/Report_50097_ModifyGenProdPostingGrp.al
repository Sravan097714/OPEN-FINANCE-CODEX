report 50097 "Modify Gen. Prod Posting Grp"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = TableData "Purch. Rcpt. Line" = rm, tabledata "Value Entry" = rm;
    dataset
    {
        dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
        {
            RequestFilterFields = "Document No.", "Line No.";
            trigger OnAfterGetRecord()
            var
                ValueEntry: Record "Value Entry";
            begin
                "Gen. Prod. Posting Group" := NewGenProdPostingGrp;
                Modify();
                ValueEntry.Reset();
                ValueEntry.SetRange("Document No.", "Purch. Rcpt. Line"."Document No.");
                ValueEntry.SetRange("Document Line No.", "Purch. Rcpt. Line"."Line No.");
                if ValueEntry.FindFirst() then begin
                    ValueEntry."Gen. Prod. Posting Group" := NewGenProdPostingGrp;
                    ValueEntry.Modify();
                end;

            end;
        }

    }



    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("New Gen. Prod Posting Group"; NewGenProdPostingGrp)
                    {
                        ApplicationArea = All;
                        TableRelation = "Gen. Product Posting Group";
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        if NewGenProdPostingGrp = '' then
            Error('Please provide new general product posting group.');
        DocNoFilter := "Purch. Rcpt. Line".GetFilter("Document No.");
        if DocNoFilter = '' then
            Error('Please provide document No. filter');
        LineNoFilter := "Purch. Rcpt. Line".GetFilter("Line No.");
        if LineNoFilter = '' then
            Error('Please provide Line No. filter');
    end;

    var
        NewGenProdPostingGrp: Code[10];
        DocNoFilter: Text;
        LineNoFilter: Text;
        LineNoLVar: Integer;
}