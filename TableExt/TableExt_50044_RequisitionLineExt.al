tableextension 50044 RequisitionLineExt extends "Requisition Line"
{
    fields
    {
        field(50000; Approved; Boolean)
        {
            trigger OnValidate()
            begin
                if Approved then begin
                    if ("Requested By" = '') then
                        Error('You cannot proceed becuase "Requested By" on line no. %1 is blank.', "Line No.");
                    if ("Requested Date" = 0D) then
                        Error('You cannot proceed becuase "Requested Date" on line no. %1 is blank.', "Line No.");
                    if ("Requisition No." = '') then
                        Error('You cannot proceed becuase "Requisition No." on line no. %1 is blank.', "Line No.");
                end;
            end;
        }
        field(50001; "Requested By"; Code[50])
        {
            TableRelation = "New Categories".Code where("Table Name" = filter('Item Journal'), "Field Name" = filter('Requested By'));
        }
        field(50002; "Requested Date"; Date) { }
        field(50003; "Requisition No."; Code[20])
        {
            Editable = false;
        }
        field(50004; "CRP/RFP"; Code[20]) { }
        field(50005; Rate; Decimal) { }
        field(50006; "Purchase Order No."; Code[20]) { }
        field(50007; "Supplier Quotation No."; Code[20]) { }
        field(50008; "Qty Supplied"; Decimal) { }
        field(50009; Remarks; Text[100]) { }
        field(50010; "Requisition Amount"; Decimal) { }
    }

    trigger OnInsert()
    begin
        grecPurchPayableSetup.get;
        "Requisition No." := NoSeriesMgt.GetNextNo(grecPurchPayableSetup."Requisition No. Series", "Requested Date", TRUE)
    end;

    trigger OnModify()
    begin
        grecPurchPayableSetup.get;
        "Requisition No." := NoSeriesMgt.GetNextNo(grecPurchPayableSetup."Requisition No. Series", "Requested Date", TRUE)
    end;

    var
        grecPurchPayableSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        grecArchiveRequisition: Record "Requisition Line Archive";
}