pageextension 50043 SalesCrMemoSubformExt extends "Sales Cr. Memo Subform"
{
    layout
    {
        modify(Type)
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(FilteredTypeField)
        {
            Visible = false;
        }
        modify("Line Discount Amount")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Unit of Measure Code")
        {
            Visible = false;
        }


        addfirst(Control1)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }

        addafter(Quantity)
        {
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
            }
        }

        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }

        moveafter("Gen. Prod. Posting Group"; "VAT Prod. Posting Group")


        modify("No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                grecStdText: Record "Standard Text";
                gpageStdTextCodes: Page "Standard Text Codes";

                grecGLAccount: Record "G/L Account";
                gpageGLAccount: Page "G/L Account List";

                grecItem: Record Item;
                gpageItem: Page "Item List";

                grecResources: Record Resource;
                gpageResources: Page "Resource List";

                grecFixedAsset: Record "Fixed Asset";
                gpageFixedAsset: Page "Fixed Asset List";

                grecItemCharge: Record "Item Charge";
                gpageItemCharge: Page "Item Charges";

            begin
                case Type of
                    Type::" ":
                        begin
                            Clear(gpageStdTextCodes);
                            grecStdText.Reset();
                            grecStdText.SetRange(Code);
                            if grecStdText.FindFirst() then begin
                                gpageStdTextCodes.SetRecord(grecStdText);
                                gpageStdTextCodes.SetTableView(grecStdText);
                                gpageStdTextCodes.LookupMode(true);
                                if gpageStdTextCodes.RunModal() = Action::LookupOK then begin
                                    gpageStdTextCodes.GetRecord(grecStdText);
                                    Rec.Validate("No.", grecStdText.Code);
                                end;
                            end;
                        end;

                    Type::"G/L Account":
                        begin
                            grecGLAccount.Reset();
                            grecGLAccount.SetRange("No.");
                            if grecGLAccount.FindFirst() then begin
                                gpageGLAccount.SetRecord(grecGLAccount);
                                gpageGLAccount.SetTableView(grecGLAccount);
                                gpageGLAccount.LookupMode(true);
                                if gpageGLAccount.RunModal() = Action::LookupOK then begin
                                    gpageGLAccount.GetRecord(grecGLAccount);
                                    Rec.Validate("No.", grecGLAccount."No.");
                                end;
                            end;
                        end;

                    Type::Item:
                        begin
                            grecItem.Reset();
                            grecItem.SetRange(Module, true);
                            if grecItem.FindFirst() then begin
                                gpageItem.SetRecord(grecItem);
                                gpageItem.SetTableView(grecItem);
                                gpageItem.LookupMode(true);
                                if gpageItem.RunModal() = Action::LookupOK then begin
                                    gpageItem.GetRecord(grecItem);
                                    Rec.Validate("No.", grecItem."No.");
                                end;
                            end;
                        end;

                    Type::Resource:
                        begin
                            grecResources.Reset();
                            grecResources.SetRange("No.");
                            if grecResources.FindFirst() then begin
                                gpageResources.SetRecord(grecResources);
                                gpageResources.SetTableView(grecResources);
                                gpageResources.LookupMode(true);
                                if gpageResources.RunModal() = Action::LookupOK then begin
                                    gpageResources.GetRecord(grecResources);
                                    Rec.Validate("No.", grecResources."No.");
                                end;
                            end;
                        end;


                    Type::"Fixed Asset":
                        begin
                            grecFixedAsset.Reset();
                            grecFixedAsset.SetRange("No.");
                            if grecFixedAsset.FindFirst() then begin
                                gpageFixedAsset.SetRecord(grecFixedAsset);
                                gpageFixedAsset.SetTableView(grecFixedAsset);
                                gpageFixedAsset.LookupMode(true);
                                if gpageFixedAsset.RunModal() = Action::LookupOK then begin
                                    gpageFixedAsset.GetRecord(grecFixedAsset);
                                    Rec.Validate("No.", grecFixedAsset."No.");
                                end;
                            end;
                        end;

                    Type::"Charge (Item)":
                        begin
                            grecItemCharge.Reset();
                            grecItemCharge.SetRange("No.");
                            if grecItemCharge.FindFirst() then begin
                                gpageItemCharge.SetRecord(grecItemCharge);
                                gpageItemCharge.SetTableView(grecItemCharge);
                                gpageItemCharge.LookupMode(true);
                                if gpageItemCharge.RunModal() = Action::LookupOK then begin
                                    gpageItemCharge.GetRecord(grecItemCharge);
                                    Rec.Validate("No.", grecItemCharge."No.");
                                end;
                            end;
                        end;

                end;
            end;
        }

    }
}