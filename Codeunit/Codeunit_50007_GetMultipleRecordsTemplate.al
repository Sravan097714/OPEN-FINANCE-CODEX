codeunit 50007 "GetMultipleRecords Template"
{

    trigger OnRun()
    begin
    end;

    var
        tmpItem: Record 27 temporary;
        tmpCustomer: Record 18 temporary;
        tmpVendor: Record 23 temporary;
        tmpSalesperson: Record 13 temporary;

    procedure GetItem(var OrecItem: Record 27; IblnErrorIfNotFound: Boolean; IcodItemNo: Code[20]) OblnRecordFound: Boolean
    var
        LrecItem: Record 27;
    begin
        OblnRecordFound :=
          (tmpItem."No." = IcodItemNo);

        IF NOT OblnRecordFound THEN
            OblnRecordFound := tmpItem.GET(IcodItemNo);

        IF NOT OblnRecordFound THEN BEGIN
            CLEAR(tmpItem);
            IF IblnErrorIfNotFound THEN BEGIN
                LrecItem.GET(IcodItemNo);
                OblnRecordFound := TRUE;
            END
            ELSE
                OblnRecordFound := LrecItem.GET(IcodItemNo);

            IF OblnRecordFound THEN BEGIN
                tmpItem := LrecItem;
                tmpItem.INSERT(FALSE);
            END;
        END;

        OrecItem := tmpItem;
    end;

    procedure GetCustomer(var OrecCustomer: Record 18; IblnErrorIfNotFound: Boolean; IcodCustomerNo: Code[20]) OblnRecordFound: Boolean
    var
        LrecCustomer: Record 18;
    begin
        OblnRecordFound :=
          (tmpCustomer."No." = IcodCustomerNo);

        IF NOT OblnRecordFound THEN
            OblnRecordFound := tmpCustomer.GET(IcodCustomerNo);

        IF NOT OblnRecordFound THEN BEGIN
            CLEAR(tmpCustomer);
            IF IblnErrorIfNotFound THEN BEGIN
                IF LrecCustomer.GET(IcodCustomerNo) THEN
                    OblnRecordFound := TRUE
                ELSE
                    OblnRecordFound := FALSE;
            END
            ELSE
                OblnRecordFound := LrecCustomer.GET(IcodCustomerNo);

            IF OblnRecordFound THEN BEGIN
                tmpCustomer := LrecCustomer;
                tmpCustomer.INSERT(FALSE);
            END;
        END;

        OrecCustomer := tmpCustomer;
    end;

    procedure GetVendor(var OrecVendor: Record 23; IblnErrorIfNotFound: Boolean; IcodVendorNo: Code[20]) OblnRecordFound: Boolean
    var
        LrecVendor: Record 23;
    begin
        OblnRecordFound :=
          (tmpVendor."No." = IcodVendorNo);

        IF NOT OblnRecordFound THEN
            OblnRecordFound := tmpVendor.GET(IcodVendorNo);

        IF NOT OblnRecordFound THEN BEGIN
            CLEAR(tmpVendor);
            IF IblnErrorIfNotFound THEN BEGIN
                IF LrecVendor.GET(IcodVendorNo) THEN
                    OblnRecordFound := TRUE
                ELSE
                    OblnRecordFound := FALSE;
            END
            ELSE
                OblnRecordFound := LrecVendor.GET(IcodVendorNo);

            IF OblnRecordFound THEN BEGIN
                tmpVendor := LrecVendor;
                tmpVendor.INSERT(FALSE);
            END;
        END;

        OrecVendor := tmpVendor;
    end;

    procedure GetSalesperson(var OrecSalesperson: Record 13; IblnErrorIfNotFound: Boolean; IcodSalespersonCode: Code[20]) OblnRecordFound: Boolean
    var
        LrecSalesperson: Record 13;
    begin
        OblnRecordFound :=
          (tmpSalesperson.Code = IcodSalespersonCode);

        IF NOT OblnRecordFound THEN
            OblnRecordFound := tmpSalesperson.GET(IcodSalespersonCode);

        IF NOT OblnRecordFound THEN BEGIN
            CLEAR(tmpSalesperson);
            IF IblnErrorIfNotFound THEN BEGIN
                IF LrecSalesperson.GET(IcodSalespersonCode) THEN
                    OblnRecordFound := TRUE
                ELSE
                    OblnRecordFound := FALSE;
            END
            ELSE
                OblnRecordFound := LrecSalesperson.GET(IcodSalespersonCode);

            IF OblnRecordFound THEN BEGIN
                tmpSalesperson := LrecSalesperson;
                tmpSalesperson.INSERT(FALSE);
            END;
        END;

        OrecSalesperson := tmpSalesperson;
    end;
}

