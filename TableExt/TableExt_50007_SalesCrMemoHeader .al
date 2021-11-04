tableextension 50007 SalesCrMemoHeaderExt extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50000; BRN; Code[30])
        {
            Editable = false;
        }
        field(50001; "Delivery Date"; Date) { }
        field(50002; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(50003; "From OU Portal"; Boolean)
        {
            Editable = false;
        }
        field(50004; "First Name"; Text[100])
        {
            Editable = false;
        }
        field(50005; "Last Name"; Text[100])
        {
            Editable = false;
        }
        field(50006; "Middle Name"; Text[100])
        {
            Editable = false;
        }
        field(50007; RDAP; Text[50])
        {
            Editable = false;
        }
        field(50008; RDBL; Text[50])
        {
            Editable = false;
        }
        field(50009; PTN; Text[25]) { }
        field(50010; "Payment Semester"; Text[25]) { }
        field(50011; NIC; Text[20]) { Editable = false; }
        field(50012; "Login Email"; Text[50]) { Editable = false; }
        field(50013; "Contact Email"; Text[50]) { Editable = false; }
        field(50014; "Our Ref"; Text[50]) { }
        field(50015; "Your Ref"; Text[100]) { }
    }
}