pageextension 50110 "STR Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        addafter(General)
        {
            group("Mannok Information")
            {
                Caption = 'Mannok Information';

                field("Workflow Type"; Rec."STR Workflow Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'The workflow type assigned to the purchase document, selected from the Master Data Setup list.';
                }
            }
        }
    }
}
