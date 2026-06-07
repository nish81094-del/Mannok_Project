tableextension 50110 "STR Doc Attachment Ext" extends "Document Attachment"
{
    fields
    {
        field(50100; "STR Bin Location Code"; Code[10])
        {
            Caption = 'Bin Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
            ToolTip = 'The location code of the bin that the attachment belongs to. Used to disambiguate bin codes that repeat across locations.';
        }
    }
}
