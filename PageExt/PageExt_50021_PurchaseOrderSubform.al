pageextension 50021 PurchaseOrderSubformExt extends "Purchase Order Subform"
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
        modify("Line No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(FilteredTypeField)
        {
            Visible = false;
        }
        modify("Line Discount %")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Promised Receipt Date")
        {
            Visible = false;
        }
        modify("Requested Receipt Date")
        {
            Visible = false;
        }
        modify("Drop Shipment")
        {
            Visible = false;
        }
        modify("Variant Code")
        {
            Visible = false;
        }
        modify("Blanket Order Line No.")
        {
            Visible = false;

        }
        modify("Blanket Order No.")
        {
            Visible = false;

        }
        modify("Bin Code")
        {
            Visible = false;
        }

        modify("Line Discount Amount")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Planned Receipt Date")
        {
            Visible = false;
        }
        modify("Expected Receipt Date")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Reserved Quantity")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = true;
        }
        modify("Unit of Measure Code")
        {
            Visible = false;
        }

        modify("Prod. Order No.")
        {
            Editable = true;
            ApplicationArea = All;
        }
        modify("Work Center No.")
        {
            Editable = true;
            ApplicationArea = All;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify("Over-Receipt Quantity")
        {
            Visible = false;
        }
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

        addafter("No.")
        {
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
                Editable = Rec."Quantity Received" = 0;
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

        movefirst(Control1; "Line No.")
        moveafter("Gen. Prod. Posting Group"; "VAT Prod. Posting Group")
        moveafter("Line Discount %"; "Line Discount Amount")

        addlast(Control1)
        {
            field("TDS Code"; "TDS Code") { ApplicationArea = All; }
            field(VAT; VAT) { ApplicationArea = All; }
            field("Retention Fee"; "Retention Fee") { ApplicationArea = All; }
            field(PAYE; PAYE) { ApplicationArea = All; }
            field("G/L Account for Budget"; "G/L Account for Budget")
            {
                ApplicationArea = All;
                Editable = gboolEditable;

                trigger OnLookup(var Text: Text): Boolean
                var
                    grecGLAccount: Record "G/L Account";
                    gpageGLAccount: Page "G/L Account List";
                    grecGLAccount2: Record "G/L Account";
                    gtextEarmarkID: Text;
                    grecPurchPayableSetup: Record "Purchases & Payables Setup";
                    gtextCounter: Text;
                    grecPurchHeader: Record "Purchase Header";
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

                                if "G/L Account for Budget" <> '' then begin
                                    if ("Document Type" = "Document Type"::Order) or ("Document Type" = "Document Type"::Invoice) then begin
                                        clear(gtextEarmarkID);
                                        grecPurchPayableSetup.Get;
                                        gtextEarmarkID := 'R' + FORMAT(Today, 0, '<Year4><Month,2><Day,2>');

                                        if grecPurchPayableSetup."EarmarkID Counter Date" <> Today then begin
                                            grecPurchPayableSetup."EarmarkID Counter" := 1;
                                            grecPurchPayableSetup."EarmarkID Counter Date" := Today;
                                        end else
                                            grecPurchPayableSetup."EarmarkID Counter" += 1;
                                        grecPurchPayableSetup.Modify;

                                        if grecPurchHeader.get("Document Type", "Document No.") then begin
                                            grecPurchHeader.Earmarked := UserId;
                                            grecPurchHeader.Modify;
                                        end;

                                        gtextCounter := format(grecPurchPayableSetup."EarmarkID Counter");
                                        gtextEarmarkID += PADSTR('', 3 - STRLEN(gtextCounter), '0') + gtextCounter;
                                        "Earmark ID" := gtextEarmarkID;
                                        "Date Earmarked" := Today;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            }
            field("Earmark ID"; "Earmark ID") { ApplicationArea = All; }
            field("Date Earmarked"; "Date Earmarked") { ApplicationArea = All; }
            field("VAT Amount Input"; "VAT Amount Input")
            {
                ApplicationArea = All;
            }
            field("VAT %"; "VAT %")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("VAT Identifier"; "VAT Identifier")
            {
                ApplicationArea = all;
                editable = true;
            }
            field("Line Amount Excluding VAT"; "Line Amount Excluding VAT") { ApplicationArea = All; }
            field("Depreciation Book Code"; "Depreciation Book Code") { ApplicationArea = All; }
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                if Rec.Type = Rec.Type::"G/L Account" then begin
                    Rec."G/L Account for Budget" := Rec."No.";
                    Rec.Quantity := 1;
                end;
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
    }

    actions
    {
        addlast("&Line")
        {
            action("Calculate TDS")
            {
                ApplicationArea = All;
                Image = TaxPayment;

                trigger OnAction()
                var
                    grecPurchLine: Record "Purchase Line";
                    grecPurchLine2: Record "Purchase Line";
                    grecNewCategories: Record "New Categories";
                begin
                    grecPurchLine.Reset();
                    grecPurchLine.SetRange("Document No.", "Document No.");
                    grecPurchLine.SetFilter("TDS Code", '<>%1', '');
                    if grecPurchLine.FindFirst() then begin
                        repeat
                            grecPurchLine2.Init();
                            grecPurchLine2."System-Created Entry" := true;
                            grecPurchLine2."Document No." := grecPurchLine."Document No.";
                            grecPurchLine2."Document Type" := grecPurchLine."Document Type";
                            grecPurchLine2.validate(Type, grecPurchLine2.Type::"G/L Account");
                            if grecNewCategories.get('Payment Journal', 'TDS Code', grecPurchLine."TDS Code") then
                                grecPurchLine2."TDS %" := grecNewCategories."TDS %";

                            grecPurchLine2."Line No." := grecPurchLine."Line No." + 500;

                            grecPurchLine2.Validate("No.", grecNewCategories."TDS Account");
                            grecPurchLine2.Validate(Quantity, -1);

                            if grecPurchLine.VAT then
                                grecPurchLine2.validate("Direct Unit Cost", ROUND(((grecNewCategories."TDS %" / 100) * grecPurchLine."Line Amount Excluding VAT"), 1, '='))
                            else
                                grecPurchLine2.validate("Direct Unit Cost", ROUND(((grecNewCategories."TDS %" / 100) * grecPurchLine."Line Amount"), 1, '='));


                            grecPurchLine2.TDS := true;
                            grecPurchLine2.Insert;

                        until grecPurchLine.Next = 0;
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if grecUserSetup.Get(UserId) then
            gboolEditable := grecUserSetup."Edit GL Account Budget Purch";
    end;

    var
        gboolEditable: Boolean;
        grecUserSetup: Record "User Setup";
        GroupCompanyDisplayName: Text;
}