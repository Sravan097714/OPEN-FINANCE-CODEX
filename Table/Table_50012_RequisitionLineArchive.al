table 50012 "Requisition Line Archive"
{
    Caption = 'Requisition Line Archive';
    DataCaptionFields = "Journal Batch Name", "Line No.";
    //DrillDownPageID = "Requisition Lines";
    //LookupPageID = "Requisition Lines";
    Permissions = TableData "Prod. Order Capacity Need" = rimd,
                  TableData "Routing Header" = r,
                  TableData "Production BOM Header" = r;

    fields
    {
        field(1; "Worksheet Template Name"; Code[10])
        {
            Caption = 'Worksheet Template Name';
            TableRelation = "Req. Wksh. Template";
        }
        field(2; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Requisition Wksh. Name".Name WHERE("Worksheet Template Name" = FIELD("Worksheet Template Name"));
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item';
            OptionMembers = " ","G/L Account",Item;

        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST(Item),
                                     "Worksheet Template Name" = FILTER(<> ''),
                                     "Journal Batch Name" = FILTER(<> '')) Item WHERE(Type = CONST(Inventory))
            ELSE
            IF (Type = CONST(Item),
                                              "Worksheet Template Name" = CONST(''),
                                              "Journal Batch Name" = CONST('')) Item;

        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(7; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(9; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(10; "Direct Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost';
        }
        field(12; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(13; "Requester ID"; Code[50])
        {
            Caption = 'Requester ID';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                UserSelection: Codeunit "User Selection";
            begin
                UserSelection.ValidateUserName("Requester ID");
            end;
        }
        field(14; Confirmed; Boolean)
        {
            Caption = 'Confirmed';
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(16; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(17; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(18; "Recurring Method"; Option)
        {
            BlankZero = true;
            Caption = 'Recurring Method';
            OptionCaption = ',Fixed,Variable';
            OptionMembers = ,"Fixed",Variable;
        }
        field(19; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(20; "Recurring Frequency"; DateFormula)
        {
            Caption = 'Recurring Frequency';
        }
        field(21; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(22; "Vendor Item No."; Text[50])
        {
            Caption = 'Vendor Item No.';
        }
        field(23; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            Editable = false;
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(24; "Sales Order Line No."; Integer)
        {
            Caption = 'Sales Order Line No.';
            Editable = false;
        }
        field(25; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(26; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            Editable = false;
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));
        }
        field(28; "Order Address Code"; Code[10])
        {
            Caption = 'Order Address Code';
            TableRelation = "Order Address".Code WHERE("Vendor No." = FIELD("Vendor No."));
        }
        field(29; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(30; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(31; "Reserved Quantity"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry".Quantity WHERE("Source ID" = FIELD("Worksheet Template Name"),
                                                                  "Source Ref. No." = FIELD("Line No."),
                                                                  "Source Type" = CONST(246),
                                                                  "Source Subtype" = CONST("0"),
                                                                  "Source Batch Name" = FIELD("Journal Batch Name"),
                                                                  "Source Prod. Order Line" = CONST(0),
                                                                  "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(5401; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            Editable = false;
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                            "Item Filter" = FIELD("No."),
                                            "Variant Filter" = FIELD("Variant Code"));

        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
        }
        field(5408; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5431; "Reserved Qty. (Base)"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Source ID" = FIELD("Worksheet Template Name"),
                                                                           "Source Ref. No." = FIELD("Line No."),
                                                                           "Source Type" = CONST(246),
                                                                           "Source Subtype" = CONST("0"),
                                                                           "Source Batch Name" = FIELD("Journal Batch Name"),
                                                                           "Source Prod. Order Line" = CONST(0),
                                                                           "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5520; "Demand Type"; Integer)
        {
            Caption = 'Demand Type';
            Editable = false;
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Table));
        }
        field(5521; "Demand Subtype"; Option)
        {
            Caption = 'Demand Subtype';
            Editable = false;
            OptionCaption = '0,1,2,3,4,5,6,7,8,9';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9";
        }
        field(5522; "Demand Order No."; Code[20])
        {
            Caption = 'Demand Order No.';
            Editable = false;
        }
        field(5525; "Demand Line No."; Integer)
        {
            Caption = 'Demand Line No.';
            Editable = false;
        }
        field(5526; "Demand Ref. No."; Integer)
        {
            Caption = 'Demand Ref. No.';
            Editable = false;
        }
        field(5527; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
        }
        field(5530; "Demand Date"; Date)
        {
            Caption = 'Demand Date';
            Editable = false;
        }
        field(5532; "Demand Quantity"; Decimal)
        {
            Caption = 'Demand Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5533; "Demand Quantity (Base)"; Decimal)
        {
            Caption = 'Demand Quantity (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5538; "Needed Quantity"; Decimal)
        {
            BlankZero = true;
            Caption = 'Needed Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5539; "Needed Quantity (Base)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Needed Quantity (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5540; Reserve; Boolean)
        {
            Caption = 'Reserve';
        }
        field(5541; "Qty. per UOM (Demand)"; Decimal)
        {
            Caption = 'Qty. per UOM (Demand)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5542; "Unit Of Measure Code (Demand)"; Code[10])
        {
            Caption = 'Unit Of Measure Code (Demand)';
            Editable = false;
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(5552; "Supply From"; Code[20])
        {
            Caption = 'Supply From';
            TableRelation = IF ("Replenishment System" = CONST(Purchase)) Vendor
            ELSE
            IF ("Replenishment System" = CONST(Transfer)) Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(5553; "Original Item No."; Code[20])
        {
            Caption = 'Original Item No.';
            Editable = false;
            TableRelation = Item;
        }
        field(5554; "Original Variant Code"; Code[10])
        {
            Caption = 'Original Variant Code';
            Editable = false;
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Original Item No."));
        }
        field(5560; Level; Integer)
        {
            Caption = 'Level';
            Editable = false;
        }
        field(5563; "Demand Qty. Available"; Decimal)
        {
            Caption = 'Demand Qty. Available';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5590; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
            TableRelation = User."User Name";
        }
        field(5701; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = IF (Type = CONST(Item)) "Item Category";
        }
        field(5702; Nonstock; Boolean)
        {
            Caption = 'Catalog';
        }
        field(5703; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
        }
        field(5705; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            ObsoleteReason = 'Product Groups became first level children of Item Categories.';
            ObsoleteState = Removed;
            ObsoleteTag = '15.0';
        }
        field(5706; "Transfer-from Code"; Code[10])
        {
            Caption = 'Transfer-from Code';
            Editable = false;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(5707; "Transfer Shipment Date"; Date)
        {
            AccessByPermission = TableData "Transfer Header" = R;
            Caption = 'Transfer Shipment Date';
            Editable = false;
        }
        field(7000; "Price Calculation Method"; Enum "Price Calculation Method")
        {
            Caption = 'Price Calculation Method';
        }
        field(7002; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(7100; "Blanket Purch. Order Exists"; Boolean)
        {
            CalcFormula = Exist("Purchase Line" WHERE("Document Type" = CONST("Blanket Order"),
                                                       Type = CONST(Item),
                                                       "No." = FIELD("No."),
                                                       "Outstanding Quantity" = FILTER(<> 0)));
            Caption = 'Blanket Purch. Order Exists';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7110; "Custom Sorting Order"; Code[50])
        {
        }
        field(99000750; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            TableRelation = "Routing Header";
        }
        field(99000751; "Operation No."; Code[10])
        {
            Caption = 'Operation No.';
            TableRelation = "Prod. Order Routing Line"."Operation No." WHERE(Status = CONST(Released),
                                                                              "Prod. Order No." = FIELD("Prod. Order No."),
                                                                              "Routing No." = FIELD("Routing No."));
        }
        field(99000752; "Work Center No."; Code[20])
        {
            Caption = 'Work Center No.';
            TableRelation = "Work Center";
        }
        field(99000754; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
            Editable = false;
            TableRelation = "Prod. Order Line"."Line No." WHERE(Status = CONST(Finished),
                                                                 "Prod. Order No." = FIELD("Prod. Order No."));
        }
        field(99000755; "MPS Order"; Boolean)
        {
            Caption = 'MPS Order';
        }
        field(99000756; "Planning Flexibility"; Enum "Reservation Planning Flexibility")
        {
            Caption = 'Planning Flexibility';
        }
        field(99000757; "Routing Reference No."; Integer)
        {
            Caption = 'Routing Reference No.';
        }
        field(99000882; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(99000883; "Gen. Business Posting Group"; Code[20])
        {
            Caption = 'Gen. Business Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(99000884; "Low-Level Code"; Integer)
        {
            AccessByPermission = TableData "Production Order" = R;
            Caption = 'Low-Level Code';
            Editable = false;
        }
        field(99000885; "Production BOM Version Code"; Code[20])
        {
            Caption = 'Production BOM Version Code';
            TableRelation = "Production BOM Version"."Version Code" WHERE("Production BOM No." = FIELD("Production BOM No."));
        }
        field(99000886; "Routing Version Code"; Code[20])
        {
            Caption = 'Routing Version Code';
            TableRelation = "Routing Version"."Version Code" WHERE("Routing No." = FIELD("Routing No."));
        }
        field(99000887; "Routing Type"; Option)
        {
            Caption = 'Routing Type';
            OptionCaption = 'Serial,Parallel';
            OptionMembers = Serial,Parallel;
        }
        field(99000888; "Original Quantity"; Decimal)
        {
            BlankZero = true;
            Caption = 'Original Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(99000889; "Finished Quantity"; Decimal)
        {
            Caption = 'Finished Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(99000890; "Remaining Quantity"; Decimal)
        {
            Caption = 'Remaining Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(99000891; "Original Due Date"; Date)
        {
            Caption = 'Original Due Date';
            Editable = false;
        }
        field(99000892; "Scrap %"; Decimal)
        {
            AccessByPermission = TableData "Production Order" = R;
            Caption = 'Scrap %';
            DecimalPlaces = 0 : 5;
        }
        field(99000894; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

        }
        field(99000895; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
        }
        field(99000896; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(99000897; "Ending Time"; Time)
        {
            Caption = 'Ending Time';
        }
        field(99000898; "Production BOM No."; Code[20])
        {
            Caption = 'Production BOM No.';
            TableRelation = "Production BOM Header"."No.";
        }
        field(99000899; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            DecimalPlaces = 0 : 5;
        }
        field(99000900; "Overhead Rate"; Decimal)
        {
            Caption = 'Overhead Rate';
            DecimalPlaces = 0 : 5;
        }
        field(99000901; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            MinValue = 0;

            trigger OnValidate()
            begin
                TestField(Type, Type::Item);
                TestField("No.");

                Item.Get("No.");
                if Item."Costing Method" = Item."Costing Method"::Standard then begin
                    if CurrFieldNo = FieldNo("Unit Cost") then
                        Error(
                          Text006,
                          FieldCaption("Unit Cost"), Item.FieldCaption("Costing Method"), Item."Costing Method");
                    "Unit Cost" := Item."Unit Cost" * "Qty. per Unit of Measure";
                end;
                "Cost Amount" := Round("Unit Cost" * Quantity);
            end;
        }
        field(99000902; "Cost Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount';
            Editable = false;
            MinValue = 0;
        }
        field(99000903; "Replenishment System"; Enum "Replenishment System")
        {
            Caption = 'Replenishment System';
        }
        field(99000904; "Ref. Order No."; Code[20])
        {
            Caption = 'Ref. Order No.';
            Editable = false;
            TableRelation = IF ("Ref. Order Type" = CONST("Prod. Order")) "Production Order"."No." WHERE(Status = FIELD("Ref. Order Status"))
            ELSE
            IF ("Ref. Order Type" = CONST(Purchase)) "Purchase Header"."No." WHERE("Document Type" = CONST(Order))
            ELSE
            IF ("Ref. Order Type" = CONST(Transfer)) "Transfer Header"."No." WHERE("No." = FIELD("Ref. Order No."))
            ELSE
            IF ("Ref. Order Type" = CONST(Assembly)) "Assembly Header"."No." WHERE("Document Type" = CONST(Order));
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                PurchHeader: Record "Purchase Header";
                ProdOrder: Record "Production Order";
                TransHeader: Record "Transfer Header";
                AsmHeader: Record "Assembly Header";
            begin
                case "Ref. Order Type" of
                    "Ref. Order Type"::Purchase:
                        if PurchHeader.Get(PurchHeader."Document Type"::Order, "Ref. Order No.") then
                            PAGE.Run(PAGE::"Purchase Order", PurchHeader)
                        else
                            Message(Text007, PurchHeader.TableCaption);
                    "Ref. Order Type"::"Prod. Order":
                        if ProdOrder.Get("Ref. Order Status", "Ref. Order No.") then
                            case ProdOrder.Status of
                                ProdOrder.Status::Planned:
                                    PAGE.Run(PAGE::"Planned Production Order", ProdOrder);
                                ProdOrder.Status::"Firm Planned":
                                    PAGE.Run(PAGE::"Firm Planned Prod. Order", ProdOrder);
                                ProdOrder.Status::Released:
                                    PAGE.Run(PAGE::"Released Production Order", ProdOrder);
                            end
                        else
                            Message(Text007, ProdOrder.TableCaption);
                    "Ref. Order Type"::Transfer:
                        if TransHeader.Get("Ref. Order No.") then
                            PAGE.Run(PAGE::"Transfer Order", TransHeader)
                        else
                            Message(Text007, TransHeader.TableCaption);
                    "Ref. Order Type"::Assembly:
                        if AsmHeader.Get("Ref. Order Status", "Ref. Order No.") then
                            PAGE.Run(PAGE::"Assembly Order", AsmHeader)
                        else
                            Message(Text007, AsmHeader.TableCaption);
                    else
                        Message(Text008);
                end;
            end;
        }
        field(99000905; "Ref. Order Type"; Option)
        {
            Caption = 'Ref. Order Type';
            Editable = false;
            OptionCaption = ' ,Purchase,Prod. Order,Transfer,Assembly';
            OptionMembers = " ",Purchase,"Prod. Order",Transfer,Assembly;
        }
        field(99000906; "Ref. Order Status"; Option)
        {
            BlankZero = true;
            Caption = 'Ref. Order Status';
            Editable = false;
            OptionCaption = ',Planned,Firm Planned,Released';
            OptionMembers = ,Planned,"Firm Planned",Released;
        }
        field(99000907; "Ref. Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Ref. Line No.';
            Editable = false;
        }
        field(99000908; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(99000909; "Expected Operation Cost Amt."; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Planning Routing Line"."Expected Operation Cost Amt." WHERE("Worksheet Template Name" = FIELD("Worksheet Template Name"),
                                                                                            "Worksheet Batch Name" = FIELD("Journal Batch Name"),
                                                                                            "Worksheet Line No." = FIELD("Line No.")));
            Caption = 'Expected Operation Cost Amt.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000910; "Expected Component Cost Amt."; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Planning Component"."Cost Amount" WHERE("Worksheet Template Name" = FIELD("Worksheet Template Name"),
                                                                        "Worksheet Batch Name" = FIELD("Journal Batch Name"),
                                                                        "Worksheet Line No." = FIELD("Line No.")));
            Caption = 'Expected Component Cost Amt.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000911; "Finished Qty. (Base)"; Decimal)
        {
            Caption = 'Finished Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(99000912; "Remaining Qty. (Base)"; Decimal)
        {
            Caption = 'Remaining Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(99000913; "Related to Planning Line"; Integer)
        {
            Caption = 'Related to Planning Line';
            Editable = false;
        }
        field(99000914; "Planning Level"; Integer)
        {
            Caption = 'Planning Level';
            Editable = false;
        }
        field(99000915; "Planning Line Origin"; Option)
        {
            Caption = 'Planning Line Origin';
            Editable = false;
            OptionCaption = ' ,Action Message,Planning,Order Planning';
            OptionMembers = " ","Action Message",Planning,"Order Planning";
        }
        field(99000916; "Action Message"; Enum "Action Message Type")
        {
            Caption = 'Action Message';
        }
        field(99000917; "Accept Action Message"; Boolean)
        {
            Caption = 'Accept Action Message';

            trigger OnValidate()
            begin
                if "Action Message" = "Action Message"::" " then
                    Validate("Action Message", "Action Message"::New);
            end;
        }
        field(99000918; "Net Quantity (Base)"; Decimal)
        {
            Caption = 'Net Quantity (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(99000919; "Starting Date-Time"; DateTime)
        {
            Caption = 'Starting Date-Time';

            trigger OnValidate()
            begin
                "Starting Date" := DT2Date("Starting Date-Time");
                "Starting Time" := DT2Time("Starting Date-Time");

                Validate("Starting Date");
            end;
        }
        field(99000920; "Ending Date-Time"; DateTime)
        {
            Caption = 'Ending Date-Time';

            trigger OnValidate()
            begin
                "Ending Date" := DT2Date("Ending Date-Time");
                "Ending Time" := DT2Time("Ending Date-Time");

                Validate("Ending Date");
            end;
        }
        field(99000921; "Order Promising ID"; Code[20])
        {
            Caption = 'Order Promising ID';
        }
        field(99000922; "Order Promising Line No."; Integer)
        {
            Caption = 'Order Promising Line No.';
        }
        field(99000923; "Order Promising Line ID"; Integer)
        {
            Caption = 'Order Promising Line ID';
        }
        field(50000; Approved; Boolean) { }
        field(50001; "Requested By"; Code[50])
        {
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
        field(50011; "Archive Type"; Text[20]) { }
        field(50012; "PO Number"; Text[20]) { }
    }

    keys
    {
        key(Key1; "Worksheet Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Worksheet Template Name", "Journal Batch Name", "Vendor No.", "Sell-to Customer No.", "Ship-to Code", "Order Address Code", "Currency Code", "Ref. Order Type", "Ref. Order Status", "Ref. Order No.", "Location Code", "Transfer-from Code", "Purchasing Code")
        {
            MaintainSQLIndex = false;
        }
        key(Key3; Type, "No.", "Variant Code", "Location Code", "Sales Order No.", "Planning Line Origin", "Due Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Quantity (Base)";
        }
        key(Key4; Type, "No.", "Variant Code", "Location Code", "Sales Order No.", "Order Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Quantity (Base)";
        }
        key(Key5; Type, "No.", "Variant Code", "Location Code", "Starting Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Quantity (Base)";
        }
        key(Key6; "Worksheet Template Name", "Journal Batch Name", Type, "No.", "Due Date")
        {
            MaintainSQLIndex = false;
        }
        key(Key7; "Ref. Order Type", "Ref. Order Status", "Ref. Order No.", "Ref. Line No.")
        {
        }
        key(Key8; "Replenishment System", Type, "No.", "Variant Code", "Transfer-from Code", "Transfer Shipment Date")
        {
            MaintainSQLIndex = false;
            SumIndexFields = "Quantity (Base)";
        }
        key(Key9; "Order Promising ID", "Order Promising Line ID", "Order Promising Line No.")
        {
        }
        key(Key10; "User ID", "Demand Type", "Worksheet Template Name", "Journal Batch Name", "Line No.")
        {
        }
        key(Key11; "User ID", "Demand Type", "Demand Subtype", "Demand Order No.", "Demand Line No.", "Demand Ref. No.")
        {
        }
        key(Key12; "User ID", "Worksheet Template Name", "Journal Batch Name", "Line No.")
        {
            MaintainSQLIndex = false;
        }
        key(Key13; "Worksheet Template Name", "Journal Batch Name", "Custom Sorting Order")
        {
        }
    }

    trigger OnInsert()
    begin
        grecReLineArchive.reset;
        if grecReLineArchive.FindLast() then begin
            Rec."Line No." := grecReLineArchive."Line No." + 10000;
        end else
            Rec."Line No." := 10000;
    end;

    var
        Text004: Label 'You cannot rename a %1.';
        Text005: Label '%1 %2 does not exist.';
        Text006: Label 'You cannot change %1 when %2 is %3.';
        Text007: Label 'There is no %1 for this line.';
        Text008: Label 'There is no replenishment order for this line.';
        ReqWkshTmpl: Record "Req. Wksh. Template";
        ReqWkshName: Record "Requisition Wksh. Name";
        ReqLine: Record "Requisition Line";
        Item: Record Item;
        WorkCenter: Record "Work Center";
        MfgSetup: Record "Manufacturing Setup";
        Location: Record Location;
        Bin: Record Bin;
        TempPlanningErrorLog: Record "Planning Error Log" temporary;
        ReserveReqLine: Codeunit "Req. Line-Reserve";
        UOMMgt: Codeunit "Unit of Measure Management";
        AddOnIntegrMgt: Codeunit AddOnIntegrManagement;
        DimMgt: Codeunit DimensionManagement;
        LeadTimeMgt: Codeunit "Lead-Time Management";
        GetPlanningParameters: Codeunit "Planning-Get Parameters";
        VersionMgt: Codeunit VersionManagement;
        PlanningLineMgt: Codeunit "Planning Line Management";
        WMSManagement: Codeunit "WMS Management";
        CurrentFieldNo: Integer;
        BlockReservation: Boolean;
        Text028: Label 'The %1 on this %2 must match the %1 on the sales order line it is associated with.';
        Subcontracting: Boolean;
        Text029: Label 'Line %1 has a %2 that exceeds the %3.';
        Text030: Label 'You cannot reserve components with status Planned.';
        PlanningResiliency: Boolean;
        Text031: Label '%1 %2 is blocked.';
        Text032: Label '%1 %2 has no %3 defined.';
        Text033: Label '%1 %2 %3 is not certified.';
        Text034: Label '%1 %2 %3 %4 %5 is not certified.';
        Text035: Label '%1 %2 %3 specified on %4 %5 does not exist.';
        Text036: Label '%1 %2 %3 does not allow default numbering.';
        Text037: Label 'The currency exchange rate for the %1 %2 that vendor %3 uses on the order date %4, does not have an %5 specified.';
        Text038: Label 'The currency exchange rate for the %1 %2 that vendor %3 uses on the order date %4, does not exist.';
        Text039: Label 'You cannot assign new numbers from the number series %1 on %2.';
        Text040: Label 'You cannot assign new numbers from the number series %1.';
        Text041: Label 'You cannot assign new numbers from the number series %1 on a date before %2.';
        Text042: Label 'You cannot assign new numbers from the number series %1 line %2 because the %3 is not defined.';
        Text043: Label 'The number %1 on number series %2 cannot be extended to more than 20 characters.';
        Text044: Label 'You cannot assign numbers greater than %1 from the number series %2.';
        ReplenishmentErr: Label 'Requisition Worksheet cannot be used to create Prod. Order replenishment.';
        SourceDropShipment: Boolean;
        grecReLineArchive: Record "Requisition Line Archive";


}

