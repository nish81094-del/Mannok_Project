pageextension 50102 "STR Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addafter(General)
        {
            group("Mannok Information")
            {
                Caption = 'Mannok Information';

                field("Linked Customer No."; Rec."STR Linked Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'The number of the customer that is linked to this customer.';

                    trigger OnDrillDown()
                    var
                        LinkedCustomer: Record Customer;
                        CustomerCardPage: Page "Customer Card";
                    begin
                        if Rec."STR Linked Customer No." = '' then
                            exit;
                        if LinkedCustomer.Get(Rec."STR Linked Customer No.") then begin
                            CustomerCardPage.SetRecord(LinkedCustomer);
                            CustomerCardPage.Run();
                        end;
                    end;
                }
                field("Customer VAT Exempt"; Rec."STR Customer VAT Exempt")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the customer is exempt from VAT.';
                }
                field("EDI Number (Temp)"; Rec."STR EDI Number (Temp)")
                {
                    ApplicationArea = All;
                    ToolTip = 'The temporary EDI number that identifies the customer in electronic data interchange.';
                }
                field(Mileage; Rec."STR Mileage")
                {
                    ApplicationArea = All;
                    ToolTip = 'The distance, in miles, to the customer''s location.';
                }
                field(Longitude; Rec."STR Longitude")
                {
                    ApplicationArea = All;
                    ToolTip = 'The longitude coordinate of the customer''s location.';
                }
                field(Latitude; Rec."STR Latitude")
                {
                    ApplicationArea = All;
                    ToolTip = 'The latitude coordinate of the customer''s location.';
                }
            }
        }
    }
}
