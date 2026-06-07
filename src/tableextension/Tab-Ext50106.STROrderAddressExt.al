tableextension 50106 "STR Order Address Ext" extends "Order Address"
{
    fields
    {
        field(50100; "STR Longitude"; Text[30])
        {
            Caption = 'Longitude';
            DataClassification = CustomerContent;
            ToolTip = 'The longitude coordinate of the order address location.';
        }
        field(50101; "STR Latitude"; Text[30])
        {
            Caption = 'Latitude';
            DataClassification = CustomerContent;
            ToolTip = 'The latitude coordinate of the order address location.';
        }
    }
}
