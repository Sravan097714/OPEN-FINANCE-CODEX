report 50070 "List of Payments"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\ListofPayments.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = where("Document Type" = filter('Payment'));
            column(CompanyName; grecCompany.Name) { }
            column(gtextDateFilter; gtextDateFilter) { }
            column(Posting_Date; format("Posting Date")) { }
            column(Document_No_; "Document No.") { }
            column(PV_Number; "PV Number") { }
            column(Vendor_No_; "Vendor No.") { }
            column(Vendor_Name; grecVendor.Name) { }
            column(Original_Amount; "Original Amount") { }
            column(Currency_Code; "Currency Code") { }

            dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
            {
                DataItemLink = "Document No." = field("Document No.");
                DataItemTableView = where("Initial Document Type" = filter('Payment'), "Entry Type" = filter('Application'));

                dataitem(DetailedVendorLedgEntry2; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Applied Vend. Ledger Entry No." = field("Applied Vend. Ledger Entry No.");
                    DataItemTableView = where("Initial Document Type" = filter('Invoice'));

                    column(Amount2; Amount) { }
                    column(Currency_Code2; "Currency Code") { }

                    dataitem(VendorLedgerEntry2; "Vendor Ledger Entry")
                    {
                        DataItemLink = "Entry No." = field("Vendor Ledger Entry No.");
                        column(Posting_Date2; format("Posting Date")) { }
                        column(Document_No_2; "Document No.") { }
                        column(External_Document_No_2; "External Document No.") { }
                    }
                }
            }

            trigger OnPreDataItem()
            begin
                SetRange("Document Type", "Document Type"::Payment);
                //SetFilter("Posting Date", gtextDateFilter);
            end;

            trigger OnAfterGetRecord()
            begin
                if grecVendor.get("Vendor No.") then;
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
                    field(Date; gtextDateFilter)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        grecCompany.Get();
    end;

    var
        gtextDateFilter: Text;
        grecCompany: Record "Company Information";
        grecVendor: Record Vendor;
}