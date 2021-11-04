tableextension 50024 VendLedgerEntryExt extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; "PV Number"; Code[20]) { }
        field(50001; "Payment Type"; Code[50])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Payment Journal'), "Field Name" = filter('Payment Type'));
        }
        field(50002; "Created By"; Text[50]) { }
        field(50003; "TDS Code"; Text[30]) { }
        field(50004; VAT; Boolean) { }
        field(50005; "Retention Fee"; Boolean) { }
        field(50006; Payee; Text[100]) { }
        field(50007; "Vendor Type"; Text[50]) { }
        field(50008; "Vendor Category"; Text[50]) { }
        field(50009; "Payment Journal No."; Text[20]) { }
        field(50010; Print; Boolean) { }
    }

    trigger OnInsert()
    var
        grecVendor: Record Vendor;
    begin
        if grecVendor.get("Vendor No.") then begin
            "Vendor Category" := grecVendor."Vendor Category";
            "Vendor Type" := grecVendor."Vendor Type";
        end;
    end;
}