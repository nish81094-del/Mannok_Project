page 50100 "STR Master Data Setup List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "STR Master Data Setup";
    Caption = 'Master Data Setups';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Type"; Rec."STR Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'The category of master data that this entry belongs to.';
                }
                field("Code"; Rec."STR Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'The unique code that identifies this master data entry within its type.';
                }
                field("Description"; Rec."STR Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'The description of this master data entry.';
                }
            }
        }
    }
}
