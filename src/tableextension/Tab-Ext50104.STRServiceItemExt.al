tableextension 50104 "STR Service Item Ext" extends "Service Item"
{
    fields
    {
        field(50100; "STR Unit Type"; Code[20])
        {
            Caption = 'Unit Type';
            DataClassification = CustomerContent;
            TableRelation = "STR Master Data Setup"."STR Code" where("STR Type" = const("Unit Type"));
            ToolTip = 'The unit type assigned to the service item, selected from the Master Data Setup list.';
        }
        field(50101; "STR Unit Size"; Code[20])
        {
            Caption = 'Unit Size';
            DataClassification = CustomerContent;
            TableRelation = "STR Master Data Setup"."STR Code" where("STR Type" = const("Unit Size"));
            ToolTip = 'The unit size assigned to the service item, selected from the Master Data Setup list.';
        }
        field(50102; "STR Year of Manufacture"; Date)
        {
            Caption = 'Year of Manufacture';
            DataClassification = CustomerContent;
            ToolTip = 'The date the service item was manufactured.';
        }
        field(50103; "STR Unit Action"; Code[20])
        {
            Caption = 'Unit Action';
            DataClassification = CustomerContent;
            TableRelation = "STR Master Data Setup"."STR Code" where("STR Type" = const("Unit Action"));
            ToolTip = 'The unit action assigned to the service item, selected from the Master Data Setup list.';
        }
        field(50104; "STR Location Code"; Code[10])
        {
            Caption = 'Location';
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
            ToolTip = 'The location where the service item is held.';
        }
    }
}
