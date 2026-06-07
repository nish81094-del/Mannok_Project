pageextension 50109 "STR Order Address Ext" extends "Order Address"
{
    layout
    {
        addafter(General)
        {
            group("Mannok Information")
            {
                Caption = 'Mannok Information';

                field(Longitude; Rec."STR Longitude")
                {
                    ApplicationArea = All;
                    ToolTip = 'The longitude coordinate of the order address location.';
                }
                field(Latitude; Rec."STR Latitude")
                {
                    ApplicationArea = All;
                    ToolTip = 'The latitude coordinate of the order address location.';
                }
            }
        }
    }
}
