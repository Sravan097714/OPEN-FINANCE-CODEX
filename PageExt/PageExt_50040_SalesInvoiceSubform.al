pageextension 50040 SalesInvoiceSubformExt extends "Sales Invoice Subform"
{
    layout
    {
        modify(Type)
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Line No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(FilteredTypeField)
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = true;
        }
        modify("Line Discount Amount")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify(LineDiscExists)
        {
            Visible = false;
        }
        modify("Qty. to Assign")
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
        modify("Unit of Measure Code")
        {
            Visible = false;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
            ApplicationArea = All;
        }

        addafter(Quantity)
        {
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
                Caption = 'Income Account';
            }
        }
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = all;
            }
        }
        addafter("No.")
        {
            field("Common Module Code"; "Common Module Code")
            {
                ApplicationArea = All;
            }
        }
        addlast(Control1)
        {
            field(Instalment; Instalment)
            {
                ApplicationArea = All;
                Visible = gboolVisibleColumn;
            }
            field("Original Amount"; "Original Amount")
            {
                ApplicationArea = All;
                Visible = gboolVisibleColumn;
            }
        }

        movefirst(Control1; "Line No.")
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
                gpageItem: Page "Module List";

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
                            grecGLAccount.SetRange(Income, true);
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
                            grecItem.SetRange("No.");
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


    trigger OnAfterGetRecord()
    begin
        if grecSalesHeader.get("Document Type", "Document No.") then
            gboolVisibleColumn := grecSalesHeader."From OU Portal";
    end;

    var
        gboolVisibleColumn: Boolean;
        grecSalesHeader: Record "Sales Header";
}