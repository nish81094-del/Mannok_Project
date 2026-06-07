tableextension 50108 "STR Bin Ext" extends Bin
{
    fields
    {
        field(50100; "STR Installation Date"; Date)
        {
            Caption = 'Installation Date';
            DataClassification = CustomerContent;
            ToolTip = 'The date the bin was installed.';
        }
        field(50101; "STR Capacity"; Code[20])
        {
            Caption = 'Capacity';
            DataClassification = CustomerContent;
            TableRelation = "STR Master Data Setup"."STR Code" where("STR Type" = const(Capacity));
            ToolTip = 'The capacity assigned to the bin, selected from the Master Data Setup list.';
        }
        field(50102; "STR Contents"; Code[20])
        {
            Caption = 'Contents';
            DataClassification = CustomerContent;
            TableRelation = "STR Master Data Setup"."STR Code" where("STR Type" = const(Contents));
            ToolTip = 'The contents stored in the bin, selected from the Master Data Setup list.';
        }
        field(50103; "STR Material Type"; Code[20])
        {
            Caption = 'Material Type';
            DataClassification = CustomerContent;
            TableRelation = "STR Master Data Setup"."STR Code" where("STR Type" = const("Material Type"));
            ToolTip = 'The material type of the bin, selected from the Master Data Setup list.';
        }
        field(50104; "STR Protection System"; Boolean)
        {
            Caption = 'Protection System';
            DataClassification = CustomerContent;
            ToolTip = 'Indicates the bin has a protection system installed.';
        }
        field(50105; "STR Leak Detection"; Boolean)
        {
            Caption = 'Leak Detection';
            DataClassification = CustomerContent;
            ToolTip = 'Indicates the bin has leak detection installed.';
        }
        field(50106; "STR Wet Stock Mgt"; Boolean)
        {
            Caption = 'Wet Stock Mgt';
            DataClassification = CustomerContent;
            ToolTip = 'Indicates the bin is under Wet Stock Management.';
        }
        field(50107; "STR WSM Review Cycle"; DateFormula)
        {
            Caption = 'WSM Review Cycle';
            DataClassification = CustomerContent;
            ToolTip = 'The Wet Stock Management review cycle, for example 3M for every three months.';
        }
        field(50108; "STR Last WSM Review"; Date)
        {
            Caption = 'Last WSM Review';
            DataClassification = CustomerContent;
            ToolTip = 'The date the last Wet Stock Management review was carried out.';
        }
        field(50109; "STR Longitude"; Text[30])
        {
            Caption = 'Longitude';
            DataClassification = CustomerContent;
            ToolTip = 'The longitude coordinate of the bin location.';
        }
        field(50110; "STR Latitude"; Text[30])
        {
            Caption = 'Latitude';
            DataClassification = CustomerContent;
            ToolTip = 'The latitude coordinate of the bin location.';
        }
    }
}
