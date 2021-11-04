tableextension 50036 ItemJnlLineExt extends "Item Journal Line"
{
    fields
    {
        field(50000; "Requested By"; text[50])
        {
            //TableRelation = "Dimension Value".Code where("Dimension Code" = filter('DEPARTMENT'));

            /* trigger OnLookup()
            var
                grecDimensionValue: Record "Dimension Value";
                gpageDimensionList: page "Dimension Value List";
            begin
                Clear(gpageDimensionList);
                grecDimensionValue.Reset();
                grecDimensionValue.SetRange("Dimension Code", 'DEPARTMENT');
                if grecDimensionValue.FindFirst() then begin
                    gpageDimensionList.SetRecord(grecDimensionValue);
                    gpageDimensionList.SetTableView(grecDimensionValue);
                    gpageDimensionList.LookupMode(true);
                    if gpageDimensionList.RunModal() = Action::LookupOK then begin
                        gpageDimensionList.GetRecord(grecDimensionValue);
                        Rec."Requested By" := grecDimensionValue.Name;
                    end;
                end;
            end; */
            TableRelation = "New Categories".Code where("Table Name" = filter('Item Journal'), "Field Name" = filter('Requested By'));
        }
        field(50001; "Created By"; Text[50])
        {
            Editable = false;
        }
        field(50002; "Original PO Number"; Code[20])
        {
            Caption = 'Original Purchase Order Number';
        }
        field(50003; "Vendor No."; Code[20])
        {
            TableRelation = Vendor where("Vendor Category" = filter('<> TUTOR'));
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
    end;
}
