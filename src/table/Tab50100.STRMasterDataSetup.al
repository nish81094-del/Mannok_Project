table 50100 "STR Master Data Setup"
{
    Caption = 'Master Data Setup';
    DataClassification = CustomerContent;
    LookupPageId = "STR Master Data Setup List";
    DrillDownPageId = "STR Master Data Setup List";

    fields
    {
        field(1; "STR Type"; Enum "STR Master Data Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            ToolTip = 'The category of master data that this entry belongs to.';
        }
        field(2; "STR Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
            ToolTip = 'The unique code that identifies this master data entry within its type.';
        }
        field(3; "STR Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'The description of this master data entry.';
        }
    }

    keys
    {
        key(PK; "STR Type", "STR Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "STR Code", "STR Description", "STR Type")
        {
        }
        fieldgroup(Brick; "STR Code", "STR Description", "STR Type")
        {
        }
    }
}
