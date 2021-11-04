page 50005 "Stock Adjustment Batches"
{

    Caption = 'Stock Adjustment Batches';
    DataCaptionExpression = DataCaption;
    PageType = List;
    SourceTable = 233;
    SourceTableView = where("Journal Template Name" = filter('ITEM'), "Positive Item Batch" = filter(true));
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(" ")
            {
                field(Name; Name)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the item journal you are creating.';
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a brief description of the item journal batch you are creating.';
                }
                field("No. Series"; "No. Series")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number series from which entry or record numbers are assigned to new entries or records.';
                }
                field("Gen. Prod Posting Group"; "Gen. Prod Posting Group")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Posting No. Series"; "Posting No. Series")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number series code used to assign document numbers to ledger entries that are posted from this journal batch.';
                }
                field("Reason Code"; "Reason Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the reason code, a supplementary source code that enables you to trace the entry.';
                }
                field("Positive Item Batch"; "Positive Item Batch")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart("   "; Links)
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
        area(processing)
        {
            action("Edit Journal")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Edit Journal';
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Return';
                ToolTip = 'Open a journal based on the journal batch.';

                trigger OnAction()
                //ItemJnlMgt.TemplateSelectionFromBatch(Rec);
                var
                    OpenFromBatch: Boolean;
                    ItemJnlTemplate: Record "Item Journal Template";
                    ItemJnlLine: Record "Item Journal Line";
                begin
                    //RCTS1.0 07/10/19
                    OpenFromBatch := TRUE;
                    ItemJnlTemplate.GET(Rec."Journal Template Name");
                    ItemJnlTemplate.TESTFIELD("Page ID");

                    ItemJnlLine.FILTERGROUP := 2;
                    ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
                    ItemJnlLine.FILTERGROUP := 0;

                    ItemJnlLine."Journal Template Name" := '';
                    ItemJnlLine."Journal Batch Name" := Rec.Name;
                    PAGE.RUN(50006, ItemJnlLine);
                    //RCTS1.0 07/10/19 
                end;
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
                        ReportPrint.PrintItemJnlBatch(Rec);
                    end;
                }
                action("P&ost")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit 243;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';
                }
                action("Post and &Print")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit 244;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';
                }
            }
        }
    }

    trigger OnInit()
    begin
        SETRANGE("Journal Template Name");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetupNewBatch;
    end;

    trigger OnOpenPage()
    begin
        ItemJnlMgt.OpenJnlBatch(Rec);
    end;

    var
        ReportPrint: Codeunit 228;
        ItemJnlMgt: Codeunit 240;

    local procedure DataCaption(): Text[250]
    var
        ItemJnlTemplate: Record 82;
    begin
        IF NOT CurrPage.LOOKUPMODE THEN
            IF GETFILTER("Journal Template Name") <> '' THEN
                IF GETRANGEMIN("Journal Template Name") = GETRANGEMAX("Journal Template Name") THEN
                    IF ItemJnlTemplate.GET(GETRANGEMIN("Journal Template Name")) THEN
                        EXIT(ItemJnlTemplate.Name + ' ' + ItemJnlTemplate.Description);
    end;
}

