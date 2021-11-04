page 50006 "Stock Adjustment"
{

    //ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Stock Adjustment';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = Worksheet;
    PromotedActionCategories = 'New,Process,Report,Page';
    SaveValues = true;
    SourceTable = 83;
    //UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Batch Name';
                Lookup = true;
                ToolTip = 'Specifies the name of the journal batch, a personalized journal layout, that the journal is based on.';

                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemJnlBatch: Record "Item Journal Batch";
                    ItemJnlLine: Record "Item Journal Line";
                    ItemJnlMgt: Codeunit ItemJnlManagement;
                begin
                    /* CurrPage.SAVERECORD;
                    ItemJnlMgt.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(FALSE); */

                    COMMIT;
                    ItemJnlBatch."Journal Template Name" := Rec.GETRANGEMAX("Journal Template Name");
                    ItemJnlBatch.Name := Rec.GETRANGEMAX("Journal Batch Name");
                    ItemJnlBatch.FILTERGROUP(2);
                    ItemJnlBatch.SETRANGE("Journal Template Name", ItemJnlBatch."Journal Template Name");
                    ItemJnlBatch.FILTERGROUP(0);

                    IF PAGE.RUNMODAL(50005, ItemJnlBatch) = ACTION::LookupOK THEN BEGIN
                        CurrentJnlBatchName := ItemJnlBatch.Name;
                        gdecHashQuantity := ItemJnlBatch."Hash Quantity";
                        ItemJnlMgt.SetName(CurrentJnlBatchName, Rec);
                    END;

                end;

                trigger OnValidate()
                begin
                    ItemJnlMgt.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali;
                end;
            }
            field("Hash Quantity"; gdecHashQuantity)
            {
                ApplicationArea = All;
                trigger OnValidate()
                var
                    ItemJnlBatch: Record "Item Journal Batch";
                begin
                    ItemJnlBatch.Reset();
                    ItemJnlBatch.SetRange("Journal Template Name", 'ITEM');
                    ItemJnlBatch.SetRange(Name, CurrentJnlBatchName);
                    if ItemJnlBatch.FindFirst() then begin
                        ItemJnlBatch."Hash Quantity" := gdecHashQuantity;
                        ItemJnlBatch.Modify;
                    end;
                end;
            }
            field(RequestedByVar; RequestedByVar)
            {
                ApplicationArea = all;
                Caption = 'Request By';
                TableRelation = "New Categories".Code where("Table Name" = filter('Item Journal'), "Field Name" = filter('Requested By'));
                trigger OnValidate()
                begin
                    ValidateRequestBy;
                end;
            }
            repeater("     ")
            {
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the posting date for the entry.';
                }
                /* field("Document Date"; "Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the related document was created.';
                    Visible = false;
                } */
                field("Entry Type"; "Entry Type")
                {
                    ApplicationArea = Basic, Suite;
                    OptionCaption = ',,Positive Adjmt.,';
                    ToolTip = 'Specifies the type of transaction that will be posted from the item journal line.';
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a document number for the journal line.';
                }
                /* field("External Document No."; "External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
                    Visible = false;
                } */
                field("Item No."; "Item No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the item on the journal line.';

                    trigger OnValidate()
                    begin
                        ItemJnlMgt.GetItem("Item No.", ItemDescription);
                        ShowShortcutDimCode(ShortcutDimCode);
                    end;

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
                                Rec.validate("Item No.", grecItem."No.");
                            end;
                        end;
                    end;
                }
                /* field("Variant Code"; "Variant Code")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the variant of the item on the line.';
                    Visible = false;
                } */
                field(Description; Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a description of the item on the journal line.';
                }
                /* field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    ApplicationArea = Suite;
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (3),
                                                                  "Dimension Value Type" = CONST (Standard),
                                                                  Blocked = CONST (false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    ApplicationArea = Suite;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (4),
                                                                  "Dimension Value Type" = CONST (Standard),
                                                                  Blocked = CONST (false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    ApplicationArea = Suite;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (5),
                                                                  "Dimension Value Type" = CONST (Standard),
                                                                  Blocked = CONST (false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    ApplicationArea = Suite;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (6),
                                                                  "Dimension Value Type" = CONST (Standard),
                                                                  Blocked = CONST (false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    ApplicationArea = Suite;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (7),
                                                                  "Dimension Value Type" = CONST (Standard),
                                                                  Blocked = CONST (false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    ApplicationArea = Suite;
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (8),
                                                                  "Dimension Value Type" = CONST (Standard),
                                                                  Blocked = CONST (false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                } */
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies the code for the inventory location where the item on the journal line will be registered.';
                    Visible = true;

                    trigger OnValidate()
                    var
                        Item: Record 27;
                        WMSManagement: Codeunit 7302;
                    begin
                        IF "Location Code" <> '' THEN
                            IF Item.GET("Item No.") THEN
                                Item.TESTFIELD(Type, Item.Type::Inventory);
                        WMSManagement.CheckItemJnlLineLocation(Rec, xRec);
                    end;
                }
                /* field("Bin Code"; "Bin Code")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies the bin where the items are picked or put away.';
                    Visible = false;
                }
                field("Salespers./Purch. Code"; "Salespers./Purch. Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for the salesperson or purchaser who is linked to the sale or purchase on the journal line.';
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the vendor''s or customer''s trade type to link transactions made for this business partner with the appropriate general ledger account according to the general posting setup.';
                    Visible = false;
                } */
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
                    Visible = true;
                    Editable = false;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of units of the item to be included on the journal line.';
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                /* field("Unit Amount"; "Unit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the price of one unit of the item on the journal line.';
                }

                field("Discount Amount"; "Discount Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the discount amount of this entry on the line.';
                }
                field("Indirect Cost %"; "Indirect Cost %")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the percentage of the item''s last purchase cost that includes indirect costs, such as freight that is associated with the purchase of the item.';
                    Visible = false;
                } */
                field("Unit Cost"; "Unit Cost")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the cost of one unit of the item or resource on the line.';
                    Editable = gboolEditCost;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the line''s net amount.';
                    Editable = gboolEditCost;
                }
                field("Requested By"; "Requested By")
                {
                    ApplicationArea = All;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = All;
                }
                /* field("Applies-to Entry"; "Applies-to Entry")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the quantity on the journal line must be applied to an already-posted entry. In that case, enter the entry number that the quantity will be applied to.';
                }
                field("Applies-from Entry"; "Applies-from Entry")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the outbound item ledger entry, whose cost is forwarded to the inbound item ledger entry.';
                    Visible = false;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the type of transaction that the document represents, for the purpose of reporting to INTRASTAT.';
                    Visible = false;
                }
                field("Transport Method"; "Transport Method")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the transport method, for the purpose of reporting to INTRASTAT.';
                    Visible = false;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region of the address.';
                    Visible = false;
                }
                field("Reason Code"; "Reason Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the reason code, a supplementary source code that enables you to trace the entry.';
                    Visible = false;
                }
                field("Shpt. Method Code"; "Shpt. Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the item''s shipment method.';
                } */

                field("Vendor No."; "Vendor No.") { ApplicationArea = All; }
            }
            group("      ")
            {
                fixed("   ")
                {
                    group("Item Description")
                    {
                        Caption = 'Item Description';
                        field(ItemDescription; ItemDescription)
                        {
                            ApplicationArea = Basic, Suite;
                            Editable = false;
                            ShowCaption = false;
                            ToolTip = 'Specifies a description of the item.';
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            part(""; 9090)
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Item No.");
                Visible = false;
            }
            systempart(" "; Links)
            {
                Visible = false;
            }
            systempart("  "; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    AccessByPermission = TableData 348 = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(ItemTrackingLines)
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ToolTip = 'View or edit serial numbers and lot numbers that are assigned to the item on the document or journal line.';

                    trigger OnAction()
                    begin
                        OpenItemTrackingLines(FALSE);
                    end;
                }
                action("Bin Contents")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Bin Contents';
                    Image = BinContent;
                    RunObject = Page 7305;
                    RunPageLink = "Location Code" = FIELD("Location Code"),
                                  "Item No." = FIELD("Item No."),
                                  "Variant Code" = FIELD("Variant Code");
                    RunPageView = SORTING("Location Code", "Item No.", "Variant Code");
                    ToolTip = 'View items in the bin if the selected line contains a bin code.';
                }
                action("&Recalculate Unit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Recalculate Unit Amount';
                    Image = UpdateUnitCost;
                    ToolTip = 'Reset the unit amount to the amount specified on the item card.';

                    trigger OnAction()
                    begin
                        RecalculateUnitAmount;
                        CurrPage.SAVERECORD;
                    end;
                }
            }
            group("&Item")
            {
                Caption = '&Item';
                Image = Item;
                action(Card)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page 30;
                    RunPageLink = "No." = FIELD("Item No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or change detailed information about the record on the document or journal line.';
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ledger E&ntries';
                    Image = ItemLedger;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page 38;
                    RunPageLink = "Item No." = FIELD("Item No.");
                    RunPageView = SORTING("Item No.");
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Event';
                        Image = "Event";
                        ToolTip = 'View how the actual and the projected available balance of an item will develop over time according to supply and demand events.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByEvent)
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period';
                        Image = Period;
                        ToolTip = 'Show the projected quantity of the item over time according to time periods, such as day, week, or month.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByPeriod)
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = Planning;
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ToolTip = 'View or edit the item''s variants. Instead of setting up each color of an item as a separate item, you can set up the various colors as variants of the item.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByVariant)
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData 14 = R;
                        ApplicationArea = Location;
                        Caption = 'Location';
                        Image = Warehouse;
                        ToolTip = 'View the actual and projected quantity of the item per location.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByLocation)
                        end;
                    }
                    action("BOM Level")
                    {
                        AccessByPermission = TableData 5870 = R;
                        ApplicationArea = Assembly;
                        Caption = 'BOM Level';
                        Image = BOMLevel;
                        ToolTip = 'View availability figures for items on bills of materials that show how many units of a parent item you can make based on the availability of child items.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByBOM)
                        end;
                    }
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("E&xplode BOM")
                {
                    AccessByPermission = TableData 90 = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Codeunit 246;
                    ToolTip = 'Insert new lines for the components on the bill of materials, for example to sell the parent item as a kit. CAUTION: The line for the parent item will be deleted and represented by a description only. To undo, you must delete the component lines and add a line the parent item again.';
                }
                action("&Calculate Warehouse Adjustment")
                {
                    ApplicationArea = Warehouse;
                    Caption = '&Calculate Warehouse Adjustment';
                    Ellipsis = true;
                    Image = CalculateWarehouseAdjustment;
                    ToolTip = 'Calculate adjustments in quantity based on the warehouse adjustment bin for each item in the journal. New lines are added for negative and positive quantities.';

                    trigger OnAction()
                    begin
                        CalcWhseAdjmt.SetItemJnlLine(Rec);
                        CalcWhseAdjmt.RUNMODAL;
                        CLEAR(CalcWhseAdjmt);
                    end;
                }
                action("&Get Standard Journals")
                {
                    ApplicationArea = Suite;
                    Caption = '&Get Standard Journals';
                    Ellipsis = true;
                    Image = GetStandardJournal;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Import journal lines from a standard journal that already exists.';

                    trigger OnAction()
                    var
                        StdItemJnl: Record 752;
                    begin
                        StdItemJnl.FILTERGROUP := 2;
                        StdItemJnl.SETRANGE("Journal Template Name", "Journal Template Name");
                        StdItemJnl.FILTERGROUP := 0;
                        IF PAGE.RUNMODAL(PAGE::"Standard Item Journals", StdItemJnl) = ACTION::LookupOK THEN BEGIN
                            StdItemJnl.CreateItemJnlFromStdJnl(StdItemJnl, CurrentJnlBatchName);
                            MESSAGE(Text001, StdItemJnl.Code);
                        END
                    end;
                }
                action("&Save as Standard Journal")
                {
                    ApplicationArea = Suite;
                    Caption = '&Save as Standard Journal';
                    Ellipsis = true;
                    Image = SaveasStandardJournal;
                    ToolTip = 'Save the journal lines as a standard journal that you can later reuse.';

                    trigger OnAction()
                    var
                        ItemJnlBatch: Record 233;
                        ItemJnlLines: Record 83;
                        StdItemJnl: Record 752;
                        SaveAsStdItemJnl: Report 751;
                    begin
                        ItemJnlLines.SETFILTER("Journal Template Name", "Journal Template Name");
                        ItemJnlLines.SETFILTER("Journal Batch Name", CurrentJnlBatchName);
                        CurrPage.SETSELECTIONFILTER(ItemJnlLines);
                        ItemJnlLines.COPYFILTERS(Rec);

                        ItemJnlBatch.GET("Journal Template Name", CurrentJnlBatchName);
                        SaveAsStdItemJnl.Initialise(ItemJnlLines, ItemJnlBatch);
                        SaveAsStdItemJnl.RUNMODAL;
                        IF NOT SaveAsStdItemJnl.GetStdItemJournal(StdItemJnl) THEN
                            EXIT;

                        MESSAGE(Text002, StdItemJnl.Code);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Test Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintItemJnlLine(Rec);
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        gCUMiscellaneous.CheckHashQty(Rec, gdecHashQuantity);
                        if grecUserSetup.Get(UserId) then begin
                            if grecUserSetup."Can Post Positive Adjustment" then begin
                                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", Rec);
                                CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                                gdecHashQuantity := 0;
                                gCUMiscellaneous.ClearHashQty(rec."Journal Batch Name");
                                CurrPage.UPDATE(FALSE);
                            end;
                        end;
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        gCUMiscellaneous.CheckHashQty(Rec, gdecHashQuantity);
                        if grecUserSetup.Get(UserId) then begin
                            if grecUserSetup."Can Post Positive Adjustment" then begin
                                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post+Print", Rec);
                                CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                                gdecHashQuantity := 0;
                                CurrPage.UPDATE(FALSE);
                            end;
                        end;
                    end;
                }
            }
            action("&Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    ItemJnlLine: Record 83;
                begin
                    ItemJnlLine.COPY(Rec);
                    ItemJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
                    ItemJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
                    REPORT.RUNMODAL(REPORT::"Inventory Movement 2", TRUE, TRUE, ItemJnlLine);
                end;
            }
            group(Page)
            {
                Caption = 'Page';
                action(EditInExcel)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Edit in Excel';
                    Image = Excel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Send the data in the journal to an Excel file for analysis or editing.';
                    Visible = IsSaasExcelAddinEnabled;

                    trigger OnAction()
                    var
                        ODataUtility: Codeunit 6710;
                    begin
                        ODataUtility.EditJournalWorksheetInExcel(CurrPage.CAPTION, CurrPage.OBJECTID(FALSE), "Journal Batch Name", "Journal Template Name");
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ItemJnlMgt.GetItem("Item No.", ItemDescription);
    end;

    trigger OnAfterGetRecord()
    var
        ItemJnlLine: Record "Item Journal Line";
    begin
        ShowShortcutDimCode(ShortcutDimCode);
        ItemJnlLine.copy(Rec);
        if ItemJnlLine.FindFirst() then begin
            RequestedByVar := ItemJnlLine."Requested By";
        end else
            RequestedByVar := '';
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveItemJnlLine: Codeunit 99000835;
    begin
        COMMIT;
        IF NOT ReserveItemJnlLine.DeleteLineConfirm(Rec) THEN
            EXIT(FALSE);
        ReserveItemJnlLine.DeleteLine(Rec);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Entry Type" := "Entry Type"::"Positive Adjmt.";
        "Location Code" := 'MAINSTORE';
        IF "Entry Type" > "Entry Type"::"Negative Adjmt." THEN
            ERROR(Text000, "Entry Type");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetUpNewLine(xRec);
        "Requested By" := RequestedByVar;
        "Created By" := UserId;
        CLEAR(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    var
        ServerConfigSettingHandler: Codeunit 6723;
        JnlSelected: Boolean;
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
    begin


        gboolEditCost := false;
        if grecUserSetup.Get(UserId) then begin
            if grecUserSetup."Edit Cost on Item Journal" then
                gboolEditCost := true;
        end;

        "Entry Type" := "Entry Type"::"Positive Adjmt.";
        IsSaasExcelAddinEnabled := ServerConfigSettingHandler.GetIsSaasExcelAddinEnabled;
        /* IF ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::ODataV4 THEN
            EXIT; */

        IF IsOpenedFromBatch THEN BEGIN
            CurrentJnlBatchName := "Journal Batch Name";

            ItemJnlBatch.Reset();
            ItemJnlBatch.SetRange("Journal Template Name", 'ITEM');
            ItemJnlBatch.SetRange(Name, CurrentJnlBatchName);
            if ItemJnlBatch.FindFirst() then begin
                gdecHashQuantity := ItemJnlBatch."Hash Quantity";
            end;

            ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
            EXIT;
        END;
        ItemJnlMgt.TemplateSelection(PAGE::"Item Journal", 0, FALSE, Rec, JnlSelected);
        IF NOT JnlSelected THEN
            ERROR('');
        ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);

    end;

    var
        gboolEditCost: Boolean;
        Text000: Label 'You cannot use entry type %1 in this journal.';
        CalcWhseAdjmt: Report 7315;
        ItemJnlMgt: Codeunit 240;
        ReportPrint: Codeunit 228;
        ItemAvailFormsMgt: Codeunit 353;
        //ClientTypeManagement: Codeunit 4;
        CurrentJnlBatchName: Code[10];
        ItemDescription: Text[50];
        ShortcutDimCode: array[8] of Code[20];
        Text001: Label 'Item Journal lines have been successfully inserted from Standard Item Journal %1.';
        Text002: Label 'Standard Item Journal %1 has been successfully created.';
        IsSaasExcelAddinEnabled: Boolean;
        grecUserSetup: Record "User Setup";
        gdecHashQuantity: Decimal;
        gCUMiscellaneous: Codeunit Miscellaneous;
        RequestedByVar: Code[50];

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD;
        ItemJnlMgt.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ValidateRequestBy()
    var
        ItemJnlLine: Record "Item Journal Line";
        ConfirmTxt: Label 'Do you want to change the Requested By for all the below existing lines?.';
    begin
        if RequestedByVar = '' then
            exit;
        if not Confirm(ConfirmTxt) then
            exit;
        ItemJnlLine.copy(Rec);
        ItemJnlLine.ModifyAll("Requested By", RequestedByVar);
        CurrPage.Update(false);
    end;
}

