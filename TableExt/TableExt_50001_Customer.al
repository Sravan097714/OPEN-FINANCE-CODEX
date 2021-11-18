tableextension 50001 CustExt extends Customer
{
    fields
    {
        field(50000; BRN; Text[30]) { }
        field(50001; "Customer Category"; code[50])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Customer'), "Field Name" = filter('Customer Category'));
            trigger OnValidate()
            var
                NewCategories: Record "New Categories";
            begin
                if "Customer Category" = '' then
                    exit;
                NewCategories.Get('Customer', 'Customer Category', "Customer Category");
                if NewCategories."Customer Posting Group" <> '' then
                    "Customer Posting Group" := NewCategories."Customer Posting Group";
                if NewCategories."Gen. Bus. Posting Group" <> '' then
                    "Gen. Bus. Posting Group" := NewCategories."Gen. Bus. Posting Group";
                if NewCategories."VAT Bus. Posting Group" <> '' then
                    "VAT Bus. Posting Group" := NewCategories."VAT Bus. Posting Group";

            end;
        }
        field(50002; "First Name"; text[100]) { }
        field(50003; "Last Name"; Text[100]) { }
        field(50004; "Maiden Name"; Text[100]) { }
        field(50005; NIC; Text[15])
        {
            caption = 'NID';
        }
        field(50006; "Date Created"; DateTime) { Editable = false; }
        field(50007; "Created By"; Text[50]) { Editable = false; }
        field(50008; Email; Boolean)
        {
            //Caption = 'Contact Email';
        }
        field(50009; "Login Email"; Text[80]) { }
        field(50010; "Contact Title"; Text[50]) { }
    }

    trigger OnInsert()
    begin
        "Date Created" := CurrentDateTime;
        "Created By" := UserId;
    end;
}