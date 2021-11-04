report 50009 "Purchase Register"
{
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "No.";
            trigger OnPreDataItem()
            begin
                "Purchase Header".SetFilter("Order Date", gtextDate);
                "Purchase Header".SetRange("Document Type", "Document Type"::Order);
                ExcelBuf.DeleteAll(false);
                MakeExcelDataHeader1();
            end;

            trigger OnAfterGetRecord()
            begin
                ExcelBuf.NewRow;
                ExcelBuf.AddColumn("Order Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Buy-from Vendor No." + ' ' + "Buy-from Vendor Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Posting Description", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Date Earmarked", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Amount Earmarked", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn("Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                "Purchase Header".CalcFields("Amount Including VAT");
                ExcelBuf.AddColumn("Amount Including VAT", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

                if grecNewCategories.Get('Purchase Header', 'Procurement Method', "Procurement Method") then
                    ExcelBuf.AddColumn(grecNewCategories.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            end;

            trigger OnPostDataItem()
            begin
                ExcelBuf.CreateNewBook('Open Purchase Orders');
                ExcelBuf.WriteSheet('', '', '');
            end;
        }

        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.";
            trigger OnPreDataItem()
            begin
                "Purch. Inv. Header".SetFilter("Posting Date", gtextDate);
                ExcelBuf.DeleteAll(false);
                ExcelBuf.SelectOrAddSheet('Posted Purchase Invoices');
                MakeExcelDataHeader2();
            end;

            trigger OnAfterGetRecord()
            var
                lrecDetVendLedgerEntry: Record "Detailed Vendor Ledg. Entry";
                lrecDetVendLedgerEntry2: Record "Detailed Vendor Ledg. Entry";
                lrecVendorLedgerEntry: Record "Vendor Ledger Entry";
            begin
                ExcelBuf.NewRow;
                ExcelBuf.AddColumn("Order Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Order No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Buy-from Vendor No." + ' ' + "Buy-from Vendor Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Posting Description", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Date Earmarked", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Amount Earmarked", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                ExcelBuf.AddColumn("Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                "Purch. Inv. Header".CalcFields("Amount Including VAT");
                ExcelBuf.AddColumn("Amount Including VAT", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                lrecDetVendLedgerEntry.Reset();
                lrecDetVendLedgerEntry.SetRange("Document Type", lrecDetVendLedgerEntry."Document Type"::Invoice);
                lrecDetVendLedgerEntry.SetRange("Entry Type", lrecDetVendLedgerEntry."Entry Type"::"Initial Entry");
                lrecDetVendLedgerEntry.SetRange("Document No.", "No.");
                if lrecDetVendLedgerEntry.FindFirst() then begin
                    lrecDetVendLedgerEntry2.Reset();
                    lrecDetVendLedgerEntry2.SetRange("Document Type", lrecDetVendLedgerEntry."Document Type"::Payment);
                    lrecDetVendLedgerEntry2.SetRange("Entry Type", lrecDetVendLedgerEntry."Entry Type"::Application);
                    lrecDetVendLedgerEntry2.SetRange("Vendor Ledger Entry No.", lrecDetVendLedgerEntry."Vendor Ledger Entry No.");
                    if lrecDetVendLedgerEntry2.FindFirst() then begin
                        lrecVendorLedgerEntry.Reset();
                        lrecVendorLedgerEntry.SetRange("Entry No.", lrecDetVendLedgerEntry2."Applied Vend. Ledger Entry No.");
                        if lrecVendorLedgerEntry.FindFirst() then begin
                            ExcelBuf.AddColumn(lrecVendorLedgerEntry."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn(lrecDetVendLedgerEntry2.Amount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn(lrecVendorLedgerEntry."PV Number", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        end else begin
                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn(lrecDetVendLedgerEntry2.Amount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        end;
                    end;
                end;

            end;

            trigger OnPostDataItem()
            begin
                ExcelBuf.WriteSheet('', '', '');
            end;
        }


        dataitem("Purchase Header Archive"; "Purchase Header Archive")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Document Type", "No.";
            trigger OnPreDataItem()
            begin
                "Purchase Header Archive".SetFilter("Order Date", gtextDate);
                ExcelBuf.DeleteAll(false);
                ExcelBuf.SelectOrAddSheet('Closed Purchase Orders');
                MakeExcelDataHeader3();
            end;

            trigger OnAfterGetRecord()
            begin
                ExcelBuf.NewRow;
                ExcelBuf.AddColumn("Order Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Buy-from Vendor No." + ' ' + "Buy-from Vendor Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Posting Description", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Date Earmarked", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Amount Earmarked", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                "Purchase Header Archive".CalcFields("Amount Including VAT");
                ExcelBuf.AddColumn("Amount Including VAT", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Vendor Order No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            end;

            trigger OnPostDataItem()
            begin
                ExcelBuf.WriteSheet('', '', '');
                //ExcelBuf.CloseBook();
                //ExcelBuf.OpenExcel();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Date Filter")
                {
                    field(Date; gtextDate)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        var
                        //TextManagement: Codeunit TextManagement;
                        begin
                            //TextManagement.MakeDateFilter(gtextDate);
                        end;
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if gtextDate = '' then
            error(gtextDateFilterError);

    end;

    trigger OnPostReport()
    begin
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
    end;

    local procedure MakeExcelDataHeader1()
    begin

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Purchase Register - Open Purchase Orders', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(gtextDate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Purchase Order', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Supplier', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Description', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Earmarked Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Earmarked Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('Director General Signature', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Supplied Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Supplied Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('Procurement Method', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Date Sent for Payment', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Payment Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Payment PV No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Remarks', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
    end;


    local procedure MakeExcelDataHeader2()
    begin
        ExcelBuf.ClearNewRow();
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Purchase Register - Posted Purchase Invoices', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(gtextDate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Purchase Order', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Supplier', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Description', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Earmarked Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Earmarked Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('Director General Signature', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Supplied Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Supplied Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('Date Sent for Payment', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Payment Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Amount Paid', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Payment PV No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Remarks', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
    end;


    local procedure MakeExcelDataHeader3()
    begin
        ExcelBuf.ClearNewRow();
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Purchase Register - Closed Purchase Orders', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(gtextDate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Purchase Order', FALSE, '', True, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Supplier', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Description', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Earmarked Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Earmarked Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('Director General Signature', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Supplied Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Supplied Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('Date Sent for Payment', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Payment Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Payment PV No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Remarks', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

    end;


    var
        gtextDate: Text;
        grecPurchHdr: Record "Purchase Header";
        grecPurchInvHdr: Record "Purch. Inv. Header";
        grecPurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        grecPurchHdrArchive: Record "Purchase Header Archive";
        ExcelBuf: Record "Excel Buffer";
        gtextDateFilterError: Label 'Date filter should be fill in.';
        grecNewCategories: Record "New Categories";

}