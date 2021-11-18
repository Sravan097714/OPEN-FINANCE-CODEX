tableextension 50034 GenJnlLine extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "Payment Type"; Code[50])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Payment Journal'), "Field Name" = filter('Payment Type'));
        }
        field(50001; "Voucher No."; Text[50]) { }
        field(50002; "Requested By"; text[50]) { }
        field(50003; "Created By"; Text[50])
        {
            Editable = false;
        }
        field(50004; RDAP; Text[25])
        {
            Editable = false;
        }
        field(50005; RDBL; Text[25])
        {
            Editable = false;
        }
        field(50006; NIC; Text[20])
        {
            Editable = false;
        }
        field(50007; "Student Name"; Text[250])
        {
            Editable = false;
        }
        field(50008; "Login Email"; Text[100])
        {
            Editable = false;
        }
        field(50009; "Contact Email"; Text[100])
        {
            Editable = false;
        }
        field(50010; "Phone"; Text[20])
        {
            Editable = false;
        }
        field(50011; "Mobile"; Text[20])
        {
            Editable = false;
        }
        field(50012; Address; Text[100])
        {
            Editable = false;
        }
        field(50013; Country; Text[50])
        {
            Editable = false;
        }
        field(50014; "TDS Code"; Text[30])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Payment Journal'), "Field Name" = filter('TDS Code'));
        }
        field(50015; VAT; Boolean) { }
        field(50016; "Retention Fee"; Boolean) { }
        field(50017; Payee; Text[100]) { }
        field(50018; "Vendor Type"; Text[50]) { }
        field(50019; Earmarked; Text[150]) { }
        field(50020; "Date Earmarked"; Date) { }
        field(50021; "Amount Earmarked"; Decimal) { }
        field(50022; "Earmark ID"; Text[25]) { }
        field(50023; "Original PO Number"; Code[20])
        {
            Caption = 'Original Purchase Order Number';
        }
        field(50024; "Payment Journal No."; Text[20])
        {
            Editable = false;
        }
        field(50025; ReceiptPaymentRep; Boolean) { }
        field(50026; "Vendor Category"; Text[50]) { }
        field(50027; "From OU Portal"; Boolean) { }
        field(50028; "Description 2"; Text[250]) { }
        field(50029; "Student ID"; Code[10])
        {
            TableRelation = "OU Portal App Submission".User_ID;

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

        modify("Account No.")
        {
            trigger OnAfterValidate()
            begin
                "Created By" := UserId;
            end;
        }
        field(50034; "Payee Name"; Text[50])
        {
            Caption = 'Payee Name';
            TableRelation = Vendor.Name;
            ValidateTableRelation = false;
            //Enabled = payeeeditable;
        }
        field(50035; "Amount Tendered"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Amount Tendered" < Amount then
                    Error('Amount Tendered cannot be less than Amount');
                "Amount to Remit" := "Amount Tendered" - Amount;
            end;
        }
        field(50036; "Amount To Remit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50037; "FA Supplier No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Supplier No.';
            TableRelation = Vendor."No.";
        }
        modify(Amount)
        {
            trigger OnAfterValidate()
            begin
                if xRec.Amount <> Rec.Amount then begin
                    Clear("Amount Tendered");
                    Clear("Amount To Remit");
                end;
            end;
        }

    }

    trigger OnBeforeInsert()
    begin
        if ("Journal Template Name" = 'CASH RECE') or ("Journal Template Name" = 'PAYMENT') then
            "Document Type" := "Document Type"::Payment;
    end;

    trigger OnInsert()
    begin
        if ("Journal Template Name" = 'CASH RECE') or ("Journal Template Name" = 'PAYMENT') then
            "Document Type" := "Document Type"::Payment;
        "Created By" := UserId;
    end;
}