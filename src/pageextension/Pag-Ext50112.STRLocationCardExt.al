pageextension 50112 "STR Location Card Ext" extends "Location Card"
{
    layout
    {
        addafter(General)
        {
            group("Mannok Information")
            {
                Caption = 'Mannok Information';

                field("Installation Date"; Rec."STR Installation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'The date the location was installed.';
                }
                field(Capacity; Rec."STR Capacity")
                {
                    ApplicationArea = All;
                    ToolTip = 'The capacity assigned to the location, selected from the Master Data Setup list.';
                }
                field(Contents; Rec."STR Contents")
                {
                    ApplicationArea = All;
                    ToolTip = 'The contents stored at the location, selected from the Master Data Setup list.';
                }
                field("Material Type"; Rec."STR Material Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'The material type of the location, selected from the Master Data Setup list.';
                }
                field("Protection System"; Rec."STR Protection System")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the location has a protection system installed.';
                }
                field("Leak Detection"; Rec."STR Leak Detection")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the location has leak detection installed.';
                }
                field("Wet Stock Mgt"; Rec."STR Wet Stock Mgt")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the location is under Wet Stock Management.';
                }
                field("WSM Review Cycle"; Rec."STR WSM Review Cycle")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Wet Stock Management review cycle, for example 3M for every three months.';
                }
                field("Last WSM Review"; Rec."STR Last WSM Review")
                {
                    ApplicationArea = All;
                    ToolTip = 'The date the last Wet Stock Management review was carried out.';
                }
                field(Longitude; Rec."STR Longitude")
                {
                    ApplicationArea = All;
                    ToolTip = 'The longitude coordinate of the location.';
                }
                field(Latitude; Rec."STR Latitude")
                {
                    ApplicationArea = All;
                    ToolTip = 'The latitude coordinate of the location.';
                }
            }
        }
    }
}
