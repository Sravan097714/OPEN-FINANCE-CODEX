tableextension 50032 PurchLineExt extends "Purchase Line"
{
    fields
    {
        field(50000; "FA Aquisition"; code[20])
        {
            Editable = true;
        }
        field(50001; "FA Aquisition 2"; Code[20])
        {
            Editable = true;
        }
        field(50002; "TDS Code"; Text[30])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Payment Journal'), "Field Name" = filter('TDS Code'));

            trigger OnValidate()
            var
                grecNewCategories: Record "New Categories";
            begin
                if grecNewCategories.get('Payment Journal', 'TDS Code', "TDS Code") then begin
                    "TDS %" := grecNewCategories."TDS %";
                    "TDS Account No." := grecNewCategories."TDS Account";
                    //Modify;
                end;
            end;
        }
        field(50003; VAT; Boolean)
        {
            trigger OnValidate()
            var
                grecGenLedgSetup: Record "General Ledger Setup";
            begin
                grecGenLedgSetup.Get;
                if ("Document Type" = "Document Type"::Order) or ("Document Type" = "Document Type"::Invoice) or ("Document Type" = "Document Type"::"Credit Memo") then begin
                    if VAT then begin
                        "Line Amount Excluding VAT" := "Line Amount" / (1 + grecGenLedgSetup."VAT %");
                        "VAT Amount Input" := grecGenLedgSetup."VAT %" * "Line Amount Excluding VAT";
                    end else begin
                        "VAT Amount Input" := 0;
                        "Line Amount Excluding VAT" := 0;
                    end;
                end;
            end;
        }
        field(50004; "Retention Fee"; Boolean) { }
        field(50005; "G/L Account for Budget"; code[20])
        {
            trigger OnValidate()
            var
                grecPurchPayableSetup: Record "Purchases & Payables Setup";
                gtextEarmarkID: Text;
                gtextCounter: Text;
                grecPurchHeader: Record "Purchase Header";
            begin
                //if grecPurchHeader.get("Document Type", "Document No.") then begin
                //if not grecPurchHeader.Claim then begin
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
                //end;
                //end;
            end;
        }
        field(50006; "TDS %"; Decimal) { }
        field(50007; PAYE; Boolean) { }
        field(50008; "VAT Amount Input"; Decimal) { }
        field(50009; "Account Category"; Enum "G/L Account Category") { }

        field(50010; "Budget Category"; Code[20])
        {
            TableRelation = "Budget Category"."Budget Category Code";
        }
        field(50011; TDS; Boolean) { }
        field(50012; "Line Amount Excluding VAT"; Decimal) { }
        field(50013; "TDS Account No."; Code[20]) { }
        field(50014; "Earmark ID"; Text[25]) { }
        field(50015; "Date Earmarked"; Date) { }


        modify("No.")
        {
            trigger OnAfterValidate()
            var
                grecPurchPayableSetup: Record "Purchases & Payables Setup";
            begin
                grecPurchPayableSetup.Get;
                if "No." = grecPurchPayableSetup."Retention Fee" then
                    Rec."Retention Fee" := true;
                if Type = Type::Item then
                    "Location Code" := 'MAINSTORE';
                if Type = Type::"G/L Account" then
                    Validate(Quantity, 1);
            end;
        }
    }
}