pageextension 50105 "STR Approval Entries Ext" extends "Approval Entries"
{
    layout
    {
        addbefore("Sequence No.")
        {
            field(Description; Rec."STR Description")
            {
                ApplicationArea = Suite;
                Caption = 'Description';
                ToolTip = 'The Details text captured at request time, preserved after the entry is approved.';
                Editable = false;
            }
        }
    }
}
