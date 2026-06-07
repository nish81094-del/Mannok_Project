tableextension 50102 "STR Approval Entry Ext" extends "Approval Entry"
{
    fields
    {
        field(50100; "STR Description"; Text[2048])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'The Details text captured when the approval request was created, preserved after the entry is approved.';
        }
    }
}
