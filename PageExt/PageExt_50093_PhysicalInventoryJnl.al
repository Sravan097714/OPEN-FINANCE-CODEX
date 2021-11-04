pageextension 50093 PhysicalInventoryJnl extends "Phys. Inventory Journal"
{
    layout
    {

        addlast(Control1)
        {
            field("Created By"; "Created By") { ApplicationArea = All; }
        }
        modify("Salespers./Purch. Code")
        {
            Visible = false;
        }
        modify("Unit Amount")
        {
            Visible = false;
        }
        modify("Applies-to Entry")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify(ShortcutDimCode3)
        {
            Visible = false;
        }
        modify(ShortcutDimCode4)
        {
            Visible = false;
        }
        modify(ShortcutDimCode5)
        {
            Visible = false;
        }
        modify(ShortcutDimCode6)
        {
            Visible = false;
        }
        modify(Amount)
        {
            Editable = gboolEditCost;
        }
        modify("Unit Cost")
        {
            Editable = gboolEditCost;
        }
        modify("Location Code")
        {
            Visible = true;
        }
        modify("Item No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                grecItem: Record Item;
                gpageItemList: Page "Item List";
            begin
                Clear(gpageItemList);
                grecItem.Reset();
                grecItem.SetRange(Module, false);
                if grecItem.FindFirst() then begin
                    gpageItemList.SetRecord(grecItem);
                    gpageItemList.SetTableView(grecItem);
                    gpageItemList.LookupMode(true);
                    if gpageItemList.RunModal() = Action::LookupOK then begin
                        gpageItemList.GetRecord(grecItem);
                        Rec."Item No." := grecItem."No.";
                    end;
                end;
            end;
        }
    }

    actions
    {
        modify(CalculateInventory)
        {
            trigger OnBeforeAction()
            begin
                CalcQtyOnHand.SetItemJnlLine(Rec);
                CalcQtyOnHand.RunModal;
                Clear(CalcQtyOnHand);
                Error('');
            end;
        }

        modify(Print)
        {
            trigger OnBeforeAction()
            var
                ItemJournalBatch: Record "Item Journal Batch";
            begin
                ItemJournalBatch.SetRange("Journal Template Name", "Journal Template Name");
                ItemJournalBatch.SetRange(Name, "Journal Batch Name");
                REPORT.RunModal(50066, true, false, ItemJournalBatch);
                Error('');
            end;
        }

        addafter(Print)
        {
            action("Physical Inventory Discrepancy Report")
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category4;
                Image = Print;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ItemJournalBatch: Record "Item Journal Batch";
                    grecUserSetup: Record "User Setup";
                begin
                    if grecUserSetup.Get(UserId) then begin
                        if grecUserSetup."Print Discrepancy Report" then begin
                            ItemJournalBatch.SetRange("Journal Template Name", "Journal Template Name");
                            ItemJournalBatch.SetRange(Name, "Journal Batch Name");
                            REPORT.RunModal(50067, true, false, ItemJournalBatch);
                        end else
                            Error('You do not have access to print the report.');
                    end;

                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        gboolEditCost := false;
        if grecUserSetup.Get(UserId) then begin
            if grecUserSetup."Edit Cost on Phys Inv Jnl" then
                gboolEditCost := true;
        end;
    end;

    var
        grecUserSetup: Record "User Setup";
        gboolEditCost: Boolean;
        CalcQtyOnHand: Report 50065;
}