pageextension 50067 GeneralJournal extends "General Journal"
{
    layout
    {
        modify("Document Type")
        {
            Visible = true;
        }
        modify(Quantity)
        {
            Visible = false;
        }
        modify("External Document No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Account Type")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(AccName)
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Gen. Posting Type")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify(Amount)
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Bal. Account Type")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Bal. Account No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Bal. Gen. Posting Type")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify(Correction)
        {
            Visible = false;
        }
        modify("Deferral Code")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Bal. VAT Prod. Posting Group")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Bal. VAT Bus. Posting Group")
        {
            Visible = false;
            ApplicationArea = All;
        }
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = all;
            }
        }

        addfirst(Control1)
        {
            field("Line No."; Rec."Line No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addlast(Control1)
        {
            field("Created By"; "Created By")
            {
                ApplicationArea = All;
            }
        }

    }
    actions
    {
        addafter("Request Approval")
        {
            action("Import Entries")
            {
                ApplicationArea = All;
                Caption = 'Import Entries';
                Promoted = true;
                PromotedCategory = Process;
                Image = Import;
                ToolTip = 'Import journal from desktop';

                trigger OnAction()
                var
                    GenImportData: Codeunit "Import Files";
                begin
                    GenImportData.SetJournalTemplateBatch(Rec."Journal Template Name", Rec."Journal Batch Name");
                    GenImportData.ImportGenJnlFile();
                end;
            }
        }
    }
}