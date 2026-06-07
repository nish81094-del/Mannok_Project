pageextension 50104 "STR Ship-to List Ext" extends "Ship-to Address List"
{
    layout
    {
        addafter("Location Code")
        {
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
