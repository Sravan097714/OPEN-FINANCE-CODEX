tableextension 50020 ItemTblExt extends Item
{
    fields
    {
        field(50000; "Vendor Name"; Text[100]) { }
        field(50001; "Ext. Shelf Description"; Text[100]) { }
        field(50002; "Unit Cost - Posted to GL"; Decimal) { }
        field(50003; Revaluation; Text[30]) { }
        field(50004; "Last Purchase Price"; Decimal) { }
        field(50005; "Common Module Code"; Code[50]) { }
        field(50006; Credit; Decimal) { }
        field(50007; "Module ID"; Code[10]) { }
        field(50008; Year; Decimal) { }
        field(50009; Semester; Integer) { }
        field(50010; Module; Boolean) { }
        field(50011; "Item Type"; Code[50])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Item'), "Field Name" = filter('Item Type'));
        }
        field(50012; "Product Group Code 2"; Code[20])
        {
            Caption = 'Product Group Code';
            TableRelation = "Item Product Group"."Product Group Code";

            trigger OnLookup()
            var
                grecItemCategory: Record "Item Product Group";
                gpageItemCategory: Page "Item Product Groups";
            begin
                Clear(gpageItemCategory);
                grecItemCategory.Reset();
                grecItemCategory.SetRange("Item Category Code", rec."Item Category Code");
                if grecItemCategory.FindFirst() then begin
                    gpageItemCategory.SetRecord(grecItemCategory);
                    gpageItemCategory.SetTableView(grecItemCategory);
                    gpageItemCategory.LookupMode(true);
                    if gpageItemCategory.RunModal() = Action::LookupOK then begin
                        gpageItemCategory.GetRecord(grecItemCategory);
                        Rec."Product Group Code 2" := grecItemCategory."Product Group Code";
                    end;
                end;
            end;
        }
        field(50013; "Date Created"; DateTime) { Editable = false; }
        field(50014; "Created By"; Text[50]) { Editable = false; }
    }

    trigger OnInsert()
    begin
        "Stockout Warning" := "Stockout Warning"::Yes;
        "Prevent Negative Inventory" := "Prevent Negative Inventory"::Yes;
        "Costing Method" := "Costing Method"::FIFO;
        "Date Created" := CurrentDateTime;
        "Created By" := UserId;
    end;
}