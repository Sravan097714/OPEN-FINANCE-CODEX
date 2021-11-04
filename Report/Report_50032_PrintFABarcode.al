report 50032 "Print Fixed Asset Barcode"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\PrintFABarcode.rdl';

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            RequestFilterFields = "No.", "FA Class Code", "FA Location Code", "Insurance Type";
            column(Barcode; recTmpBlob1.Blob) { }
            column(No_; "No.") { }

            trigger OnAfterGetRecord()
            begin
                //cduBarcodeMgt.EncodeEAN13(gcodeFANo, 1, false, recTmpBlob1);
                //cduBarcodeMgt.EncodeCode128(txcCode128, 1, false, recTmpBlob2);
                cduBarcodeMgt.EncodeCode39("No.", 1, false, false, recTmpBlob1);
                //cduBarcodeMgt.EncodeEAN8(txcEAN8, 1, true, recTmpBlob4);
            end;
        }
    }

    var
        gcodeFANo: Code[20];
        cduBarcodeMgt: Codeunit "Barcode Mgt.";
        recTmpBlob1: Record TempBlob temporary;
}