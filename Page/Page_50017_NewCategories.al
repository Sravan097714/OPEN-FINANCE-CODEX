page 50017 "New Categories"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "New Categories";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Table Name"; "Table Name")
                {
                    ApplicationArea = All;
                }
                field("Field Name"; "Field Name")
                {
                    ApplicationArea = All;
                }
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("TDS %"; "TDS %")
                {
                    ApplicationArea = All;
                }
                field("TDS Account"; "TDS Account")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Vendor Posting Group"; "Vendor Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    ApplicationArea = all;
                }

            }
        }
    }
}