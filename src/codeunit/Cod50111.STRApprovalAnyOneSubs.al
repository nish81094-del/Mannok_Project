codeunit 50111 "STR Approval Any One Subs."
{
    SingleInstance = true;
    Permissions = tabledata "Approval Entry" = rm,
                  tabledata "Workflow - Record Change" = r;

    var
        ProcessingPeers: Boolean;
        ProcessingLowerLevels: Boolean;

    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnAfterModifyEvent', '', false, false)]
    local procedure ApprovalEntry_OnAfterModify_CloseSequencePeers(var Rec: Record "Approval Entry"; var xRec: Record "Approval Entry"; RunTrigger: Boolean)
    var
        PeerApprovalEntry: Record "Approval Entry";
    begin
        if ProcessingPeers then
            exit;
        if Rec.IsTemporary() then
            exit;
        if Rec.Status <> Rec.Status::Approved then
            exit;

        ProcessingPeers := true;
        PeerApprovalEntry.SetRange("Workflow Step Instance ID", Rec."Workflow Step Instance ID");
        PeerApprovalEntry.SetRange("Sequence No.", Rec."Sequence No.");
        PeerApprovalEntry.SetFilter(Status, '%1|%2', PeerApprovalEntry.Status::Open, PeerApprovalEntry.Status::Created);
        PeerApprovalEntry.SetFilter("Entry No.", '<>%1', Rec."Entry No.");
        if PeerApprovalEntry.FindSet() then
            repeat
                PeerApprovalEntry.Status := PeerApprovalEntry.Status::Approved;
                PeerApprovalEntry."Last Date-Time Modified" := CurrentDateTime();
                PeerApprovalEntry."Last Modified By User ID" := CopyStr(UserId(), 1, MaxStrLen(PeerApprovalEntry."Last Modified By User ID"));
                PeerApprovalEntry.Modify(false);
            until PeerApprovalEntry.Next() = 0;
        ProcessingPeers := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure ApprovalEntry_OnAfterInsert_AutoApproveIfPeerApproved(var Rec: Record "Approval Entry"; RunTrigger: Boolean)
    var
        PeerApprovalEntry: Record "Approval Entry";
    begin
        if ProcessingPeers then
            exit;
        if Rec.IsTemporary() then
            exit;
        if Rec.Status = Rec.Status::Approved then
            exit;

        PeerApprovalEntry.SetRange("Workflow Step Instance ID", Rec."Workflow Step Instance ID");
        PeerApprovalEntry.SetRange("Sequence No.", Rec."Sequence No.");
        PeerApprovalEntry.SetRange(Status, PeerApprovalEntry.Status::Approved);
        PeerApprovalEntry.SetFilter("Entry No.", '<>%1', Rec."Entry No.");
        if not PeerApprovalEntry.IsEmpty() then begin
            Rec.Status := Rec.Status::Approved;
            Rec."Last Date-Time Modified" := CurrentDateTime();
            Rec."Last Modified By User ID" := CopyStr(UserId(), 1, MaxStrLen(Rec."Last Modified By User ID"));
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure ApprovalEntry_OnAfterInsert_SnapshotDetails(var Rec: Record "Approval Entry"; RunTrigger: Boolean)
    var
        SnapshotText: Text;
    begin
        if Rec.IsTemporary() then
            exit;
        if Rec."STR Description" <> '' then
            exit;
        SnapshotText := BuildDetailsSnapshot(Rec);
        if SnapshotText = '' then
            exit;
        Rec."STR Description" := CopyStr(SnapshotText, 1, MaxStrLen(Rec."STR Description"));
        Rec.Modify(false);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnAfterModifyEvent', '', false, false)]
    local procedure ApprovalEntry_OnAfterModify_GrowSnapshot(var Rec: Record "Approval Entry"; var xRec: Record "Approval Entry"; RunTrigger: Boolean)
    var
        SnapshotText: Text;
    begin
        if Rec.IsTemporary() then
            exit;
        if Rec.Status = Rec.Status::Approved then
            exit;
        SnapshotText := BuildDetailsSnapshot(Rec);
        if StrLen(SnapshotText) <= StrLen(Rec."STR Description") then
            exit;
        Rec."STR Description" := CopyStr(SnapshotText, 1, MaxStrLen(Rec."STR Description"));
        Rec.Modify(false);
    end;

    local procedure BuildDetailsSnapshot(ApprovalEntry: Record "Approval Entry"): Text
    var
        WorkflowRecordChange: Record "Workflow - Record Change";
        RecRef: RecordRef;
        FieldRef: FieldRef;
        Result: Text;
        EmptyGuid: Guid;
        RecRefFound: Boolean;
        DisplayName: Text;
    begin
        Result := Format(ApprovalEntry."Record ID to Approve");

        RecRefFound := RecRef.Get(ApprovalEntry."Record ID to Approve");
        if RecRefFound then begin
            DisplayName := GetRecordDisplayName(RecRef);
            if DisplayName <> '' then
                Result := StrSubstNo('%1: %2', RecRef.Caption, DisplayName);
        end;

        if ApprovalEntry."Workflow Step Instance ID" = EmptyGuid then
            exit(Result);

        WorkflowRecordChange.SetRange("Workflow Step Instance ID", ApprovalEntry."Workflow Step Instance ID");
        if not WorkflowRecordChange.FindSet() then
            exit(Result);

        if not RecRefFound then
            exit(Result);

        repeat
            if (WorkflowRecordChange."Field No." > 0) and RecRef.FieldExist(WorkflowRecordChange."Field No.") then begin
                FieldRef := RecRef.Field(WorkflowRecordChange."Field No.");
                Result := StrSubstNo('%1; %2 changed from %3 to %4',
                    Result,
                    FieldRef.Caption,
                    WorkflowRecordChange."Old Value",
                    WorkflowRecordChange."New Value");
            end;
        until WorkflowRecordChange.Next() = 0;

        exit(Result);
    end;

    local procedure GetRecordDisplayName(var RecRef: RecordRef): Text
    var
        FieldRef: FieldRef;
        NameFieldNo: Integer;
    begin
        case RecRef.Number of
            Database::Customer,
            Database::Vendor,
            Database::Contact:
                NameFieldNo := 2;
            Database::Item:
                NameFieldNo := 3;
        end;

        if NameFieldNo = 0 then
            exit('');
        if not RecRef.FieldExist(NameFieldNo) then
            exit('');

        FieldRef := RecRef.Field(NameFieldNo);
        exit(Format(FieldRef.Value));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Notification Entry", 'OnBeforeInsertEvent', '', false, false)]
    local procedure SetCustomLinkToRequestsToApprove(var Rec: Record "Notification Entry"; RunTrigger: Boolean)
    var
        ApprovalEntry: Record "Approval Entry";
        RecRef: RecordRef;
        dfhrrh: report "Notification Email";
    begin

        if Rec."Triggered By Record".TableNo <> Database::"Approval Entry" then
            exit;
        if not RecRef.Get(Rec."Triggered By Record") then
            exit;

        RecRef.SetTable(ApprovalEntry);

        Rec."Custom Link" := CopyStr(
            GetUrl(ClientType::Web, CompanyName(), ObjectType::Page,
                   Page::"Requests to Approve", ApprovalEntry),
            1, MaxStrLen(Rec."Custom Link"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeSendEmail', '', false, false)]
    local procedure DocumentMailing_OnBeforeSendEmail_RenameCustomLinkLabel(var TempEmailItem: Record "Email Item" temporary; var IsFromPostedDoc: Boolean; var PostedDocNo: Code[20]; var HideDialog: Boolean; var ReportUsage: Integer; var EmailSentSuccesfully: Boolean; var IsHandled: Boolean; EmailDocName: Text[250]; SenderUserID: Code[50]; EmailScenario: Enum "Email Scenario")
    var
        BodyText: Text;
    begin
        if EmailScenario <> Enum::"Email Scenario"::Notification then
            exit;
        if not TempEmailItem.Body.HasValue() then
            exit;
        BodyText := TempEmailItem.GetBodyTextFromBlob();
        if not BodyText.Contains('(Custom Link)') then
            exit;
        BodyText := BodyText.Replace('(Custom Link)', 'Request to approval');
        TempEmailItem.SetBodyText(BodyText);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure ApprovalEntry_OnAfterInsert_KeepCustomerBlocked(var Rec: Record "Approval Entry"; RunTrigger: Boolean)
    var
        Customer: Record Customer;
        RecRef: RecordRef;
    begin
        if Rec.IsTemporary() then
            exit;
        if not (Rec.Status in [Rec.Status::Open, Rec.Status::Created]) then
            exit;
        if not RecRef.Get(Rec."Record ID to Approve") then
            exit;
        if RecRef.Number <> Database::Customer then
            exit;

        RecRef.SetTable(Customer);
        if not Customer.Get(Customer."No.") then
            exit;
        if Customer.Blocked <> Customer.Blocked::" " then
            exit;

        Customer.Blocked := Customer.Blocked::All;
        Customer."Last Date Modified" := Today();
        Customer.Modify(false);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnAfterModifyEvent', '', false, false)]
    local procedure ApprovalEntry_OnAfterModify_UnblockCustomer(var Rec: Record "Approval Entry"; var xRec: Record "Approval Entry"; RunTrigger: Boolean)
    var
        PendingApprovalEntry: Record "Approval Entry";
        Customer: Record Customer;
        RecRef: RecordRef;
    begin
        if Rec.IsTemporary() then
            exit;
        if Rec.Status <> Rec.Status::Approved then
            exit;
        if not RecRef.Get(Rec."Record ID to Approve") then
            exit;
        if RecRef.Number <> Database::Customer then
            exit;

        PendingApprovalEntry.SetRange("Record ID to Approve", Rec."Record ID to Approve");
        PendingApprovalEntry.SetRange("Date-Time Sent for Approval", Rec."Date-Time Sent for Approval");
        PendingApprovalEntry.SetFilter(Status, '%1|%2', PendingApprovalEntry.Status::Open, PendingApprovalEntry.Status::Created);
        if not PendingApprovalEntry.IsEmpty() then
            exit;

        RecRef.SetTable(Customer);
        if not Customer.Get(Customer."No.") then
            exit;
        if Customer.Blocked = Customer.Blocked::" " then
            exit;

        Customer.Validate(Blocked, Customer.Blocked::" ");
        Customer.Modify(true);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnAfterModifyEvent', '', false, false)]
    local procedure ApprovalEntry_OnAfterModify_CloseLowerLevels(var Rec: Record "Approval Entry"; var xRec: Record "Approval Entry"; RunTrigger: Boolean)
    var
        LowerApprovalEntry: Record "Approval Entry";
    begin
        if ProcessingLowerLevels then
            exit;
        if Rec.IsTemporary() then
            exit;
        if Rec.Status <> Rec.Status::Approved then
            exit;
        if Rec."Sequence No." <= 1 then
            exit;

        ProcessingLowerLevels := true;
        LowerApprovalEntry.SetRange("Workflow Step Instance ID", Rec."Workflow Step Instance ID");
        LowerApprovalEntry.SetFilter("Sequence No.", '<%1', Rec."Sequence No.");
        LowerApprovalEntry.SetFilter(Status, '%1|%2', LowerApprovalEntry.Status::Open, LowerApprovalEntry.Status::Created);
        if LowerApprovalEntry.FindSet() then
            repeat
                LowerApprovalEntry.Status := LowerApprovalEntry.Status::Approved;
                LowerApprovalEntry."Last Date-Time Modified" := CurrentDateTime();
                LowerApprovalEntry."Last Modified By User ID" := CopyStr(UserId(), 1, MaxStrLen(LowerApprovalEntry."Last Modified By User ID"));
                LowerApprovalEntry.Modify(false);
            until LowerApprovalEntry.Next() = 0;
        ProcessingLowerLevels := false;
    end;
}
