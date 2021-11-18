report 50101 "Update Supplier FALedger"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = TableData "FA Ledger Entry" = rm, tabledata "G/L Entry" = rm;
    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            trigger OnAfterGetRecord()
            var
                FALedEntry: Record "FA Ledger Entry";
                GLEntry: Record "G/L Entry";
            begin
                FALedEntry.Reset();
                FALedEntry.SetFilter("Document No.", DocNoFilter);
                if FALedEntry.FindSet() then
                    FALedEntry.ModifyAll("FA Supplier No.", VendorNo);

                GLEntry.Reset();
                GLEntry.SetFilter("Document No.", DocNoFilter);
                if GLEntry.FindSet() then
                    GLEntry.ModifyAll("FA Supplier No.", VendorNo);
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
                    field(DocNoFilter; DocNoFilter)
                    {
                        ApplicationArea = All;
                    }
                    field(VendorNo; VendorNo)
                    {
                        ApplicationArea = all;
                        TableRelation = Vendor."No.";
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        if DocNoFilter = '' then
            Error('Please provide document No. filter');
        if VendorNo = '' then
            Error('Please provide Vendor No.');
    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        Message('Done.');
    end;

    var
        VendorNo: Code[20];
        DocNoFilter: Text;
}