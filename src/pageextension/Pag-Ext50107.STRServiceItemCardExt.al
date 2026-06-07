pageextension 50107 "STR Service Item Card Ext" extends "Service Item Card"
{
    layout
    {
        addafter(General)
        {
            group("Mannok Information")
            {
                Caption = 'Mannok Information';

                field("Unit Type"; Rec."STR Unit Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'The unit type assigned to the service item, selected from the Master Data Setup list.';
                }
                field("Unit Size"; Rec."STR Unit Size")
                {
                    ApplicationArea = All;
                    ToolTip = 'The unit size assigned to the service item, selected from the Master Data Setup list.';
                }
                field("Year of Manufacture"; Rec."STR Year of Manufacture")
                {
                    ApplicationArea = All;
                    ToolTip = 'The date the service item was manufactured.';
                }
                field("Unit Action"; Rec."STR Unit Action")
                {
                    ApplicationArea = All;
                    ToolTip = 'The unit action assigned to the service item, selected from the Master Data Setup list.';
                }
                field(Location; Rec."STR Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'The location where the service item is held.';
                }
            }
        }
    }
}
