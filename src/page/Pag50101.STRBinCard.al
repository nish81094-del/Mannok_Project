page 50101 "STR Bin Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = Bin;
    Caption = 'Bin Card';
    Editable = true;
    InsertAllowed = true;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'The code of the location that the bin belongs to.';
                }
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'The code that identifies the bin.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'The description of the bin.';
                }
                field("Bin Ranking"; Rec."Bin Ranking")
                {
                    ApplicationArea = All;
                    ToolTip = 'The ranking used to prioritise the bin during put-away and pick.';
                }
                field(Empty; Rec.Empty)
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the bin is currently empty.';
                }
                field(Dedicated; Rec.Dedicated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the bin is dedicated to a specific resource or activity.';
                }
            }
            group("Mannok Information")
            {
                Caption = 'Mannok Information';

                field("Installation Date"; Rec."STR Installation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'The date the bin was installed.';
                }
                field(Capacity; Rec."STR Capacity")
                {
                    ApplicationArea = All;
                    ToolTip = 'The capacity assigned to the bin, selected from the Master Data Setup list.';
                }
                field(Contents; Rec."STR Contents")
                {
                    ApplicationArea = All;
                    ToolTip = 'The contents stored in the bin, selected from the Master Data Setup list.';
                }
                field("Material Type"; Rec."STR Material Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'The material type of the bin, selected from the Master Data Setup list.';
                }
                field("Protection System"; Rec."STR Protection System")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the bin has a protection system installed.';
                }
                field("Leak Detection"; Rec."STR Leak Detection")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the bin has leak detection installed.';
                }
                field("Wet Stock Mgt"; Rec."STR Wet Stock Mgt")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the bin is under Wet Stock Management.';
                }
                field("WSM Review Cycle"; Rec."STR WSM Review Cycle")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Wet Stock Management review cycle, for example 3M for every three months.';
                }
                field("Last WSM Review"; Rec."STR Last WSM Review")
                {
                    ApplicationArea = All;
                    ToolTip = 'The date the last Wet Stock Management review was carried out.';
                }
                field(Longitude; Rec."STR Longitude")
                {
                    ApplicationArea = All;
                    ToolTip = 'The longitude coordinate of the bin location.';
                }
                field(Latitude; Rec."STR Latitude")
                {
                    ApplicationArea = All;
                    ToolTip = 'The latitude coordinate of the bin location.';
                }
            }
        }
        area(FactBoxes)
        {
            part(AttachedDocuments; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::Bin),
                              "No." = field("Code"),
                              "STR Bin Location Code" = field("Location Code");
            }
            systempart(Notes; Notes) { }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                ToolTip = 'The files, notes, and links attached to the bin record.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(Attachments_Promoted; Attachments) { }
            }
        }
    }
}
