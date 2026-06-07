tableextension 50101 "STR Ship-to Address Ext" extends "Ship-to Address"
{
    fields
    {
        field(50100; "STR Mileage"; Integer)
        {
            Caption = 'Mileage';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 9999;
            ToolTip = 'The distance, in miles, to the ship-to address.';
        }
        field(50101; "STR Longitude"; Text[30])
        {
            Caption = 'Longitude';
            DataClassification = CustomerContent;
            ToolTip = 'The longitude coordinate of the ship-to address.';
        }
        field(50102; "STR Latitude"; Text[30])
        {
            Caption = 'Latitude';
            DataClassification = CustomerContent;
            ToolTip = 'The latitude coordinate of the ship-to address.';
        }
    }
}
