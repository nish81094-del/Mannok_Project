pageextension 50103 "STR Ship-to Address Ext" extends "Ship-to Address"
{
    layout
    {
        addafter(General)
        {
            group("Mannok Information")
            {
                Caption = 'Mannok Information';

                field(Mileage; Rec."STR Mileage")
                {
                    ApplicationArea = All;
                    ToolTip = 'The distance, in miles, to the ship-to address.';
                }
                field(Longitude; Rec."STR Longitude")
                {
                    ApplicationArea = All;
                    ToolTip = 'The longitude coordinate of the ship-to address.';
                }
                field(Latitude; Rec."STR Latitude")
                {
                    ApplicationArea = All;
                    ToolTip = 'The latitude coordinate of the ship-to address.';
                }
            }
        }
    }
}
