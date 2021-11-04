pageextension 50101 RequisitionWorksheetExt extends "Req. Worksheet"
{
    Caption = 'Requests for Purchase Register';
    layout
    {
        modify("Original Quantity")
        {
            Caption = 'Qty Required';
            Editable = true;
        }
        addlast(Control1)
        {
            field(Approve; Approved)
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("Requisition No."; "Requisition No.") { ApplicationArea = All; }
            field("Requested By"; "Requested By") { ApplicationArea = All; }
            field("Requested Date"; "Requested Date") { ApplicationArea = All; }
            field("CRP/RFP"; "CRP/RFP") { ApplicationArea = All; }
            field(Rate; Rate) { ApplicationArea = All; }
            field("Requisition Amount"; "Requisition Amount") { ApplicationArea = All; }
            field("Purchase Order No."; "Purchase Order No.") { ApplicationArea = All; }
            field("Supplier Quotation No."; "Supplier Quotation No.") { ApplicationArea = All; }
            field("Qty Supplied"; "Qty Supplied") { ApplicationArea = All; }
            field(Remarks; Remarks) { ApplicationArea = All; }
        }
        modify("Location Code")
        {
            Visible = true;
        }
        modify("Due Date")
        {
            Caption = 'Date Supplied';
        }
    }

    actions
    {
        addlast(processing)
        {
            action("Approve ")
            {
                Image = Approve;
                trigger OnAction()
                begin
                    grecRequisitionLine.Reset();
                    grecRequisitionLine.SetRange("Worksheet Template Name", 'REQ');
                    grecRequisitionLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    if grecRequisitionLine.FindFirst() then begin
                        repeat
                            if (grecRequisitionLine."Requested By" = '') then
                                Error('You cannot proceed becuase "Requested By" on line no. %1 is blank.', grecRequisitionLine."Line No.");
                            if (grecRequisitionLine."Requested Date" = 0D) then
                                Error('You cannot proceed becuase "Requested Date" on line no. %1 is blank.', grecRequisitionLine."Line No.");
                            if (grecRequisitionLine."Requisition No." = '') then
                                Error('You cannot proceed becuase "Requisition No." on line no. %1 is blank.', grecRequisitionLine."Line No.");
                        until grecRequisitionLine.Next() = 0
                    end;

                    if grecRequisitionLine.FindFirst() then begin
                        grecRequisitionLine.ModifyAll(Approved, true);
                    end;
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        grecArchiveRequisition: Record "Requisition Line Archive";
    begin
        grecArchiveRequisition.Init();
        grecArchiveRequisition.TransferFields(Rec);
        grecArchiveRequisition."Archive Type" := 'Deleted';
        grecArchiveRequisition.Insert(true);
    end;

    var
        grecRequisitionLine: Record "Requisition Line";
}