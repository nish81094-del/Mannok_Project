tableextension 50103 "STR Item Ext" extends Item
{
    fields
    {
        field(50100; "STR Workflow Type"; Code[20])
        {
            Caption = 'Workflow Type';
            DataClassification = CustomerContent;
            TableRelation = "STR Master Data Setup"."STR Code" where("STR Type" = const(Workflow));
            ToolTip = 'The workflow type assigned to the item, selected from the Master Data Setup list.';
        }
    }
}
