pageextension 50108 "STR Vendor Card Ext" extends "Vendor Card"
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
                    ToolTip = 'The longitude coordinate of the vendor''s location.';
                }
                field(Latitude; Rec."STR Latitude")
                {
                    ApplicationArea = All;
                    ToolTip = 'The latitude coordinate of the vendor''s location.';
                }
            }
        }
    }
}
