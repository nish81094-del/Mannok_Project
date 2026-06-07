tableextension 50107 "STR Purchase Header Ext" extends "Purchase Header"
{
    fields
    {
        field(50100; "STR Workflow Type"; Code[20])
        {
            Caption = 'Workflow Type';
            DataClassification = CustomerContent;
            TableRelation = "STR Master Data Setup"."STR Code" where("STR Type" = const(Workflow));
            ToolTip = 'The workflow type assigned to the purchase document, selected from the Master Data Setup list.';
        }
    }
}
