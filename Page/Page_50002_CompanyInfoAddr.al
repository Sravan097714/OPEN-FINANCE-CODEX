page 50002 "Company Information Address"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = AddrCompany;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Currency; Currency)
                {
                    ApplicationArea = All;

                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Address"; "Bank Address")
                {
                    ApplicationArea = All;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = All;
                }
                field(IBAN; IBAN)
                {
                    ApplicationArea = All;
                }
                field("SWIFT Code"; "SWIFT Code")
                {
                    ApplicationArea = All;
                }
                field(Department; Department)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}