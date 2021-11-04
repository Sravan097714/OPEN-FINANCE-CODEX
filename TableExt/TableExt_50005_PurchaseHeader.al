tableextension 50005 PurchHeaderExt extends "Purchase Header"
{
    fields
    {
        field(50000; "BRN"; Code[30])
        {
            Editable = false;
        }
        field(50001; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(50002; "Date Time Released"; DateTime)
        {
            Editable = false;
        }
        field(50003; "Released By"; text[50])
        {
            Editable = false;
        }
        field(50004; "Date Time Reopened"; DateTime)
        {
            Editable = false;
        }
        field(50005; "Reopened By"; text[50])
        {
            Editable = false;
        }
        field(50006; "Budget Updated"; Boolean) { }
        field(50007; "PO Category"; Code[50])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Purchase Header'), "Field Name" = filter('PO Category'));
        }
        field(50008; "Procurement Method"; Code[50])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Purchase Header'), "Field Name" = filter('Procurement Method'));
        }
        field(50009; Earmarked; Text[150])
        {
            Caption = 'Earmarked By';
        }
        field(50010; "Category of Successful Bidder"; Code[50])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Purchase Header'), "Field Name" = filter('Category of Successful Bidder'));
        }
        field(50011; Price; Code[50])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Purchase Header'), "Field Name" = filter('Price'));
        }
        field(50012; Quality; Code[50])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Purchase Header'), "Field Name" = filter('Quality'));
        }
        field(50013; Responsiveness; Code[50])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Purchase Header'), "Field Name" = filter('Responsiveness'));
        }
        field(50014; Delivery; Code[50])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Purchase Header'), "Field Name" = filter('Delivery'));
        }
        //Don't use 50015..50017 - Purchase Hdr Archive table
        field(50018; "Date Earmarked"; Date) { }
        field(50019; "Amount Earmarked"; Decimal) { }
        field(50020; "Earmark ID"; Text[25]) { }
        field(50021; "Shipping Instructions"; Text[150]) { }
        field(50022; "Special Instruction"; Text[150]) { }
        field(50023; "Terms and Conditions"; Text[150]) { }
        field(50024; "Requested Delivery Date"; Date) { }
        field(50025; "Actual Delivery Date"; Date) { }
        field(50026; "Procurement Reference No."; Code[20]) { }
        field(50027; "Updated Estimated Cost (Rs)"; Decimal) { }
        field(50028; "Date Bidding Document Issued"; Date) { }
        field(50029; "Closing Date of Bids"; Date) { }
        field(50030; "Bidders Invited"; Integer)
        {
            Caption = 'No. of Bidders Invited (RB, RFQ and RFP)';
        }
        field(50031; "No of SMEs Invited"; Integer) { }
        field(50032; "No. of Bids Received"; Integer) { }
        field(50033; "No of Bids Received from SMEs"; Integer) { }
        field(50034; "No. of Responsive Bids"; Integer) { }
        field(50035; "Challenge  (Y/N)"; Option)
        {
            OptionMembers = ,Y,N;
        }
        field(50036; "Date Contract Awarded"; Date) { }
        field(50037; "Type of Procurement"; Code[50])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Purchase Header'), "Field Name" = filter('Type of Procurement'));
        }
        field(50038; "Margin Preference benefitted"; Code[50])
        {
            Caption = 'Margin of Preference benefitted';
            TableRelation = "New Categories".Code where("Table Name" = filter('Purchase Header'), "Field Name" = filter('Margin of Preference'));
        }
        field(50039; "Contract Amount Approved (Rs)"; Decimal) { }
        field(50040; Claim; Boolean) { }
        field(50041; "Request for Purchase No."; Text[250]) { }
        field(50042; "Request Dated"; date) { }
        field(50043; "Validated By"; Text[50])
        {
            Editable = false;
        }
        field(50044; "Validated On"; DateTime)
        {
            Editable = false;
        }

        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            var
                grecVendor: Record Vendor;
            begin
                if grecVendor.get("Buy-from Vendor No.") then
                    BRN := grecVendor.BRN;
            end;
        }
    }


    trigger OnInsert()
    begin
        "Created By" := UserId();
    end;
}