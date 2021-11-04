pageextension 50011 FixedAssetCardExt extends "Fixed Asset Card"
{
    layout
    {
        modify("No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Budgeted Asset")
        {
            Visible = false;
        }
        modify("Main Asset/Component")
        {
            Visible = true;
        }
        modify("Component of Main Asset")
        {
            Visible = true;
        }
        modify(Inactive)
        {
            Visible = false;
        }
        modify(Acquired)
        {
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Visible = false;
        }
        modify("Vendor No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Depreciation Book")
        {
            Visible = false;
        }
        modify(BookValue)
        {
            Visible = true;
        }
        modify(DepreciationTableCode)
        {
            Visible = false;
        }
        modify(UseHalfYearConvention)
        {
            Visible = false;
        }
        modify(AddMoreDeprBooks)
        {
            Visible = true;
        }
        modify(DepreciationBook)
        {
            Visible = true;
        }
        modify(FAPostingGroup)
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Maintenance Vendor No.")
        {
            Visible = true;
        }
        modify("Under Maintenance")
        {
            Visible = true;
        }
        modify("Next Service Date")
        {
            Visible = true;
        }
        modify("Warranty Date")
        {
            Visible = true;
        }
        modify(Insured)
        {
            Visible = true;
        }

        addlast(General)
        {
            field("FA Posting Group"; "FA Posting Group")
            {
                ApplicationArea = all;
            }
            field("Additional Description"; "Additional Description")
            {
                ApplicationArea = all;
                MultiLine = true;
            }
            field(Revalued; Revalued) { ApplicationArea = All; }
            field(Make; Make) { ApplicationArea = All; }
            field(Model; Model) { ApplicationArea = All; }
            field("Date Created"; "Date Created") { ApplicationArea = All; }
            field("Created By"; "Created By") { ApplicationArea = All; }
        }
        addlast(Maintenance)
        {
            field(Warranty; Warranty)
            {
                ApplicationArea = All;
                //MultiLine = true;
            }
            field("Warranty Description"; "Warranty Description")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
            field("Details of Donation"; "Details of Donation")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
            field("Insurance Details"; "Insurance Details")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
            field("Insurance Type"; "Insurance Type") { ApplicationArea = All; }
        }

    }

    actions
    {
        addlast("Fixed &Asset")
        {
            action("Print FA Barcode")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = BarCode;

                trigger OnAction()
                var
                    grecFixedAsset: Record "Fixed Asset";
                    grepPrintFABarcode: report "Print Fixed Asset Barcode";
                begin
                    grecFixedAsset.Reset();
                    grecFixedAsset.SetRange("No.", Rec."No.");
                    if grecFixedAsset.FindFirst() then begin
                        grepPrintFABarcode.SetTableView(grecFixedAsset);
                        grepPrintFABarcode.Run;
                    end;
                end;
            }
        }
    }


    /* trigger OnAfterGetRecord()
    begin
        FADeprBookNew.SetRange("FA No.", Rec."No.");
        if FADeprBookNew.FindFirst then begin
            FADeprBookNew.CalcFields("Acquisition Cost");
            FADeprBookNew.CalcFields(Depreciation);
            FADeprBookNew.CalcFields("Book Value");
        end;
    end;
 */

    var
        FADeprBook: Record 5612;
        FADeprBookNew: Record 5612;
}
