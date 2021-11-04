pageextension 50092 PurhCrMemoSubformExt extends "Purch. Cr. Memo Subform"
{
    layout
    {
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = true;
        }
        modify("Depreciation Book Code")
        {
            Visible = true;
        }
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = all;
            }
        }
        addlast(Control1)
        {
            field("G/L Account for Budget"; "G/L Account for Budget")
            {
                ApplicationArea = All;
                //Editable = gboolEditable;
                trigger OnLookup(var Text: Text): Boolean
                var
                    grecGLAccount: Record "G/L Account";
                    gpageGLAccount: Page "G/L Account List";
                    grecGLAccount2: Record "G/L Account";
                begin
                    clear(gpageGLAccount);
                    grecGLAccount.Reset();
                    grecGLAccount.SetRange("Account Type", grecGLAccount."Account Type"::Posting);
                    if grecGLAccount.FindFirst() then begin
                        gpageGLAccount.SetRecord(grecGLAccount);
                        gpageGLAccount.SetTableView(grecGLAccount);
                        gpageGLAccount.LookupMode(true);
                        if gpageGLAccount.RunModal() = Action::LookupOK then begin
                            gpageGLAccount.GetRecord(grecGLAccount);
                            if grecGLAccount2.Get(grecGLAccount."No.") then begin
                                Rec."G/L Account for Budget" := grecGLAccount2."No.";
                                Rec."Account Category" := grecGLAccount2."Account Category";
                            end;
                        end;
                    end;
                end;
            }
            field("Earmark ID"; "Earmark ID") { ApplicationArea = All; }
            field("Date Earmarked"; "Date Earmarked") { ApplicationArea = All; }
            field("VAT Amount Input"; "VAT Amount Input") { ApplicationArea = All; }
            field("Retention Fee"; "Retention Fee") { ApplicationArea = All; }
            field(PAYE; PAYE) { ApplicationArea = All; }
            field(VAT; VAT) { ApplicationArea = All; }
            field("TDS Code"; "TDS Code") { ApplicationArea = All; }
            field("Line Amount Excluding VAT"; "Line Amount Excluding VAT") { ApplicationArea = All; }
        }
        addfirst(Control1)
        {
            field("Line No."; "Line No.") { Editable = false; }
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                if rec.Type = Rec.Type::"G/L Account" then
                    Rec."G/L Account for Budget" := Rec."No.";
            end;

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
                            grecItem.SetRange(Module, false);
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
        modify("Gen. Prod. Posting Group") { Visible = true; }
        modify("VAT Prod. Posting Group") { Visible = true; }
        movebefore(Quantity; "Gen. Prod. Posting Group")
        moveafter("Gen. Prod. Posting Group"; "VAT Prod. Posting Group")
    }

    trigger OnOpenPage()
    begin
        if grecUserSetup.Get(UserId) then
            gboolEditable := grecUserSetup."Edit GL Account Budget Purch";
    end;

    var
        gboolEditable: Boolean;
        grecUserSetup: Record "User Setup";
}