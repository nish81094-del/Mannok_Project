pageextension 50106 "STR Item Card Ext" extends "Item Card"
{
    layout
    {
        addafter(Item)
        {
            group("Mannok Information")
            {
                Caption = 'Mannok Information';

                field("Workflow Type"; Rec."STR Workflow Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'The workflow type assigned to the item, selected from the Master Data Setup list.';
                }
            }
        }
    }
}
