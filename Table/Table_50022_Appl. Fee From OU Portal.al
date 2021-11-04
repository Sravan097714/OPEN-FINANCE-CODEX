table 50022 "Appl. Fee From OU Portal"
{
    Caption = 'Application Fee From OU Portal';
    fields
    {
        field(1; "Line No."; Integer) { Editable = false; }
        field(2; "Posting Date"; Date) { Editable = false; }
        field(10; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
            Editable = false;
        }
        field(12; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            Editable = false;
        }
        field(13; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
        }
        field(19; Dim2Date; Date)
        {
            Editable = false;
        }

        field(20; RDAP; Text[25])
        {
            Editable = false;
        }
        field(21; RDBL; Text[25])
        {
            Editable = false;
        }
        field(22; NIC; Text[20])
        {
            Editable = false;
        }
        field(23; "Student Name"; Text[250])
        {
            Editable = false;
        }
        field(24; "Login Email"; Text[100])
        {
            Editable = false;
        }
        field(25; "Contact Email"; Text[100])
        {
            Editable = false;
        }
        field(26; "Phone"; Text[20])
        {
            Editable = false;
        }
        field(27; "Mobile"; Text[20])
        {
            Editable = false;
        }
        field(28; Address; Text[100])
        {
            Editable = false;
        }
        field(29; Country; Text[50])
        {
            Editable = false;
        }

        field(30; "Student ID"; Code[10])
        {
            TableRelation = "OU Portal App Submission".User_ID;
            Editable = false;

            trigger OnValidate()
            var
                grecOUPortalAppSubmission: Record "OU Portal App Submission";
            begin
                if "Student ID" <> '' then begin
                    grecOUPortalAppSubmission.Reset();
                    grecOUPortalAppSubmission.SetRange(User_ID, "Student ID");
                    if grecOUPortalAppSubmission.FindFirst() then begin
                        RDAP := grecOUPortalAppSubmission.RDAP;
                        RDBL := grecOUPortalAppSubmission.RDBL;
                        NIC := grecOUPortalAppSubmission.NIC;
                        "Student Name" := grecOUPortalAppSubmission."First Name" + ' ' + grecOUPortalAppSubmission."Maiden Name" + ' ' + grecOUPortalAppSubmission."Last Name";
                        "Login Email" := grecOUPortalAppSubmission."Login Email";
                        "Contact Email" := grecOUPortalAppSubmission."Contact Email";
                        Phone := grecOUPortalAppSubmission.Phone;
                        Mobile := grecOUPortalAppSubmission.Mobile;
                        Address := grecOUPortalAppSubmission.Address;
                        Country := grecOUPortalAppSubmission.Country;
                    end;
                end else begin
                    RDAP := '';
                    RDBL := '';
                    NIC := '';
                    "Student Name" := '';
                    "Login Email" := '';
                    "Contact Email" := '';
                    Phone := '';
                    Mobile := '';
                    Address := '';
                    Country := '';
                end;
            end;
        }
        field(31; Select; Boolean)
        {
        }
        field(32; "Inserted DateTime"; DateTime)
        {
            Editable = false;
        }
        field(33; "Inserted By"; Code[50])
        {
            Editable = false;
        }
        field(35; "Last Modified By"; Code[50])
        {
            Editable = false;
        }
        field(36; "Last Modified DateTime"; DateTime)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }
}
