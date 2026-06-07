tableextension 50105 "STR Vendor Ext" extends Vendor
{
    fields
    {
        field(50100; "STR Longitude"; Text[30])
        {
            Caption = 'Longitude';
            DataClassification = CustomerContent;
            ToolTip = 'The longitude coordinate of the vendor''s location.';
        }
        field(50101; "STR Latitude"; Text[30])
        {
            Caption = 'Latitude';
            DataClassification = CustomerContent;
            ToolTip = 'The latitude coordinate of the vendor''s location.';
        }
    }
}
