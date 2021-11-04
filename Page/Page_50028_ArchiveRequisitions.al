page 50028 "Archive Requisitions"
{
    AdditionalSearchTerms = 'supply planning,mrp,mps';
    ApplicationArea = Basic, Suite, Planning;
    AutoSplitKey = true;
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = Worksheet;
    PromotedActionCategories = 'New,Process,Report,Drop Shipment,Special Order,Line,Item Availability by';
    SaveValues = true;
    SourceTable = "Requisition Line Archive";
    UsageCategory = Lists;
    Editable = false;
    Caption = 'Archived Requests for Purchase Register';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Type; Type)
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the type of requisition worksheet line you are creating.';

                }
                field("Requisition No."; "Requisition No.") { ApplicationArea = All; }
                field("Requested By"; "Requested By") { ApplicationArea = All; }
                field("Requested Date"; "Requested Date") { ApplicationArea = All; }
                field("No."; "No.")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';

                }
                field("Price Calculation Method"; "Price Calculation Method")
                {
                    // Visibility should be turned on by an extension for Price Calculation
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the method that will be used for unit cost calculation in the line.';
                }
                field("Action Message"; "Action Message")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies an action to take to rebalance the demand-supply situation.';
                }
                field("Accept Action Message"; "Accept Action Message")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies whether to accept the action message proposed for the line.';
                }
                field("Variant Code"; "Variant Code")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the variant of the item on the line.';
                    Visible = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies text that describes the entry.';
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies additional text describing the entry, or a remark about the requisition worksheet line.';
                    Visible = false;
                }
                field("Transfer-from Code"; "Transfer-from Code")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies the code of the location that items are transferred from.';
                    Visible = false;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies a code for an inventory location where the items that are being ordered will be registered.';
                    Visible = true;
                }
                field("Original Quantity"; "Original Quantity")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the quantity stated on the production or purchase order, when an action message proposes to change the quantity on an order.';
                    Caption = 'Qty Required';
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the number of units of the item or resource specified on the line.';
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field("Direct Unit Cost"; "Direct Unit Cost")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the cost of one unit of the selected item or resource.';
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Planning;
                    AssistEdit = true;
                    ToolTip = 'Specifies the currency code for the requisition lines.';
                    Visible = false;

                }
                field("Line Discount %"; "Line Discount %")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the discount percentage that is granted for the item on the line.';
                    Visible = false;
                }
                field("Original Due Date"; "Original Due Date")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the due date stated on the production or purchase order, when an action message proposes to reschedule an order.';
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the date when you can expect to receive the items.';
                    Caption = 'Date Supplied';
                }
                field("Order Date"; "Order Date")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the date when the related order was created.';
                    Visible = false;
                }
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the number of the vendor who will ship the items in the purchase order.';

                }
                field("Vendor Item No."; "Vendor Item No.")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the number that the vendor uses for this item.';
                }
                field("Order Address Code"; "Order Address Code")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the order address of the related vendor.';
                    Visible = false;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the number of the customer.';
                    Visible = false;
                }
                field("Ship-to Code"; "Ship-to Code")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies a code for an alternate shipment address if you want to ship to another address than the one that has been entered automatically. This field is also used in case of drop shipment.';
                    Visible = false;
                }
                field("Prod. Order No."; "Prod. Order No.")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the number of the related production order.';
                    Visible = false;
                }
                field("Requester ID"; "Requester ID")
                {
                    ApplicationArea = Planning;
                    LookupPageID = "User Lookup";
                    ToolTip = 'Specifies the ID of the user who is ordering the items on the line.';
                    Visible = false;
                }
                field(Confirmed; Confirmed)
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies whether the items on the line have been approved for purchase.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                field("Ref. Order No."; "Ref. Order No.")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the number of the relevant production or purchase order.';
                    Visible = false;
                }
                field("Ref. Order Type"; "Ref. Order Type")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies whether the order is a purchase order, a production order, or a transfer order.';
                    Visible = false;
                }
                field("Replenishment System"; "Replenishment System")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies which kind of order to use to create replenishment orders and order proposals.';
                }
                field("Ref. Line No."; "Ref. Line No.")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the number of the purchase or production order line.';
                    Visible = false;
                }
                field("Planning Flexibility"; "Planning Flexibility")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies whether the supply represented by this line is considered by the planning system when calculating action messages.';
                    Visible = false;
                }
                field("Blanket Purch. Order Exists"; "Blanket Purch. Order Exists")
                {
                    ApplicationArea = Planning;
                    BlankZero = true;
                    ToolTip = 'Specifies if a blanket purchase order exists for the item on the requisition line.';
                    Visible = false;
                }
                field("Archive Type"; "Archive Type")
                {
                    ApplicationArea = All;
                }
                //field("PO Number"; "PO Number") { ApplicationArea = All; }
                field("CRP/RFP"; "CRP/RFP") { ApplicationArea = All; }
                field(Rate; Rate) { ApplicationArea = All; }
                field("Requisition Amount"; "Requisition Amount") { ApplicationArea = All; }
                field("Purchase Order No."; "Purchase Order No.") { ApplicationArea = All; }
                field("Supplier Quotation No."; "Supplier Quotation No.") { ApplicationArea = All; }
                field("Qty Supplied"; "Qty Supplied") { ApplicationArea = All; }
                field(Remarks; Remarks) { ApplicationArea = All; }
            }

        }
    }
}


