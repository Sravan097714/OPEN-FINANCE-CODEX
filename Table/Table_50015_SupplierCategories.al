table 50015 "Supplier Categories"
{
    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Supplier Code"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            var
                grecVendor: Record Vendor;
            begin
                if grecVendor.get("Supplier Code") then begin
                    Name := grecVendor.Name;
                    "Address 1" := grecVendor.Address;
                    "Address 2" := grecVendor."Address 2";
                    "Post Code" := grecVendor."Post Code";
                    "Phone No." := grecVendor."Phone No.";
                    "Country Code" := grecVendor."Country/Region Code";
                    "Contact Name" := grecVendor.Contact;
                    "FAX No." := grecVendor."Fax No.";
                    Email := grecVendor."E-Mail";
                    Homepage := grecVendor."Home Page";
                    "Payment Terms Code" := grecVendor."Payment Terms Code";
                    "VAT Registration No." := grecVendor."VAT Registration No.";
                    "Business Registration No." := grecVendor.BRN;
                    "Mobile No." := grecVendor."Mobile Phone No.";
                end
            end;
        }
        field(3; Name; Text[100]) { }
        field(4; "Address 1"; Text[100]) { }
        field(5; "Address 2"; Text[50]) { }
        field(6; "Post Code"; Text[50]) { }
        field(7; "Phone No."; Text[30]) { }
        field(8; "Country Code"; Text[10]) { }
        field(9; "Contact Name"; Text[50]) { }
        field(10; "FAX No."; Text[30]) { }
        field(11; "Email"; Text[80]) { }
        field(12; "Homepage"; Text[80]) { }
        field(13; "Payment Terms Code"; Code[10]) { }
        field(14; "VAT Registration No."; text[20]) { }
        field(15; "Business Registration No."; Text[20]) { }
        field(16; Categories; Text[20]) { }
        field(17; "Sub Categories"; Text[150]) { }
        field(18; Type; Text[50]) { }
        field(19; "Mobile No."; Text[30]) { }
    }

    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
        key(FK; "Supplier Code", "Entry No") { }
    }
}