page 50034 "Supplier Categories"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    SourceTable = "Supplier Categories";
    SourceTableView = sorting("Supplier Code", "Entry No");

    layout
    {
        area(Content)
        {
            group(Filter)
            {
                field("Categories Filter"; gtextCategoriesFilter)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if gtextCategoriesFilter <> '' then
                            SetFilter(Categories, gtextCategoriesFilter)
                        else
                            SetRange(Categories);
                        CurrPage.Update(false);
                    end;
                }
                field("Sub Categories Filter"; gtextSubCategoriesFilter)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if gtextSubCategoriesFilter <> '' then
                            SetFilter("Sub Categories", gtextSubCategoriesFilter)
                        else
                            SetRange("Sub Categories");
                        CurrPage.Update(false);
                    end;
                }
                field("Type Filter"; gtextTypeFilter)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if gtextTypeFilter <> '' then
                            SetFilter(Type, gtextTypeFilter)
                        else
                            SetRange(Type);
                        CurrPage.Update(false);
                    end;
                }
            }
            repeater("Suppliers")
            {
                field(SN; "Entry No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Supplier Code"; "Supplier Code") { ApplicationArea = All; }
                field(Name; Name) { ApplicationArea = All; }
                field("Address 1"; "Address 1") { ApplicationArea = All; }
                field("Address 2"; "Address 2") { ApplicationArea = All; }
                field("Post Code"; "Post Code") { ApplicationArea = All; }
                field("Phone No."; "Phone No.") { ApplicationArea = All; }
                field("Mobile No."; "Mobile No.") { ApplicationArea = All; }
                field("Country Code"; "Country Code") { ApplicationArea = All; }
                field("Contact Name"; "Contact Name") { ApplicationArea = All; }
                field("FAX No."; "FAX No.") { ApplicationArea = All; }
                field(Email; Email) { ApplicationArea = All; }
                field(Homepage; Homepage) { ApplicationArea = All; }
                field("Payment Terms Code"; "Payment Terms Code") { ApplicationArea = All; }
                field("VAT Registration No."; "VAT Registration No.") { ApplicationArea = All; }
                field("Business Registration No."; "Business Registration No.") { ApplicationArea = All; }
                field(Categories; Categories) { ApplicationArea = All; }
                field("Sub Categories"; "Sub Categories") { ApplicationArea = All; }
                field(Type; Type) { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Clear Filter")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = ClearFilter;

                trigger OnAction();
                begin
                    gtextCategoriesFilter := '';
                    gtextSubCategoriesFilter := '';
                    gtextTypeFilter := '';
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Rec.SetAscending("Supplier Code", true);
    end;


    var
        gtextCategoriesFilter: Text;
        gtextSubCategoriesFilter: Text;
        gtextTypeFilter: Text;
}