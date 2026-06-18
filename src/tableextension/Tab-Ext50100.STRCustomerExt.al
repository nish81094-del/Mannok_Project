tableextension 50100 "STR Customer Ext" extends Customer
{
    fields
    {
        field(50100; "STR Linked Customer No."; Code[20])
        {
            Caption = 'Linked Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
            ToolTip = 'The number of the customer that is linked to this customer.';
        }
        field(50101; "STR Customer VAT Exempt"; Boolean)
        {
            Caption = 'Customer VAT Exempt';
            DataClassification = CustomerContent;
            ToolTip = 'Indicates the customer is exempt from VAT.';
        }
        field(50102; "STR EDI Number (Temp)"; Code[30])
        {
            Caption = 'EDI Number (Temp)';
            DataClassification = CustomerContent;
            ToolTip = 'The temporary EDI number that identifies the customer in electronic data interchange.';
        }
        field(50103; "STR Mileage"; Integer)
        {
            Caption = 'Mileage';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 9999;
            ToolTip = 'The distance, in miles, to the customer''s location.';
        }
        field(50104; "STR Longitude"; Text[30])
        {
            Caption = 'Longitude';
            DataClassification = CustomerContent;
            ToolTip = 'The longitude coordinate of the customer''s location.';
        }
        field(50105; "STR Latitude"; Text[30])
        {
            Caption = 'Latitude';
            DataClassification = CustomerContent;
            ToolTip = 'The latitude coordinate of the customer''s location.';
        }
        field(50106; "STR Business Type"; Code[20])
        {
            Caption = 'Business Type';
            DataClassification = CustomerContent;
            TableRelation = "STR Master Data Setup"."STR Code" where("STR Type" = const("Business Type"));
            ToolTip = 'The business type of the customer.';
        }
    }
}
