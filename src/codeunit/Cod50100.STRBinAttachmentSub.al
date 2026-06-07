codeunit 50100 "STR Bin Attachment Sub"
{
    [EventSubscriber(ObjectType::Page, Page::"Doc. Attachment List Factbox", 'OnAfterGetRecRefFail', '', false, false)]
    local procedure OnAfterGetRecRefFail(
        var DocumentAttachment: Record "Document Attachment";
        var RecRef: RecordRef)
    var
        Bin: Record Bin;
        LocCode: Code[10];
        BinCode: Code[20];
    begin
        if DocumentAttachment."Table ID" <> Database::Bin then
            exit;

        if RecRef.Number <> Database::Bin then
            RecRef.Open(Database::Bin);

        ResolveBinKeys(DocumentAttachment, LocCode, BinCode);
        if BinCode = '' then
            exit;

        if LocCode <> '' then begin
            if Bin.Get(LocCode, BinCode) then
                RecRef.GetTable(Bin);
            exit;
        end;

        Bin.SetRange(Code, BinCode);
        if Bin.FindFirst() then
            RecRef.GetTable(Bin);
    end;


    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        FieldRef: FieldRef;
        LocCodeFld: FieldRef;
        RecNo: Code[20];
        LocCode: Code[10];
        FieldNo: Integer;
    begin
        case RecRef.Number of
            DATABASE::Bin:
                begin
                    LocCodeFld := RecRef.Field(1);
                    FieldRef := RecRef.Field(2);
                    RecNo := CopyStr(Format(FieldRef.Value), 1, MaxStrLen(RecNo));
                    LocCode := CopyStr(Format(LocCodeFld.Value), 1, MaxStrLen(LocCode));
                    DocumentAttachment.SetRange("No.", RecNo);
                    DocumentAttachment.SetRange("STR Bin Location Code", LocCode);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        LocCodeFld: FieldRef;
        RecNo: Code[20];
        LocCode: Code[10];
    begin
        case RecRef.Number of
            DATABASE::Bin:
                begin
                    LocCodeFld := RecRef.Field(1);
                    FieldRef := RecRef.Field(2);
                    RecNo := CopyStr(Format(FieldRef.Value), 1, MaxStrLen(RecNo));
                    LocCode := CopyStr(Format(LocCodeFld.Value), 1, MaxStrLen(LocCode));
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachment.Validate("STR Bin Location Code", LocCode);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef1(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    var
        FieldRef: FieldRef;
        LocCodeFld: FieldRef;
        AppNo: Code[20];
        LocCode: Code[10];
    begin
        case RecRef.Number of
            DATABASE::Bin:
                begin
                    LocCodeFld := RecRef.Field(1);
                    FieldRef := RecRef.Field(2);
                    AppNo := CopyStr(Format(FieldRef.Value), 1, MaxStrLen(AppNo));
                    LocCode := CopyStr(Format(LocCodeFld.Value), 1, MaxStrLen(LocCode));
                    DocumentAttachment.SetRange("Table ID", RecRef.Number);
                    DocumentAttachment.SetRange("No.", AppNo);
                    DocumentAttachment.SetRange("STR Bin Location Code", LocCode);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", 'OnAfterGetRefTable', '', false, false)]
    local procedure DocAttachMgt_OnAfterGetRefTable(var RecRef: RecordRef; DocumentAttachment: Record "Document Attachment")
    var
        Bin: Record Bin;
        LocCode: Code[10];
        BinCode: Code[20];
    begin
        if DocumentAttachment."Table ID" <> Database::Bin then
            exit;

        RecRef.Open(Database::Bin);
        ResolveBinKeys(DocumentAttachment, LocCode, BinCode);
        if BinCode = '' then
            exit;

        if LocCode <> '' then begin
            if Bin.Get(LocCode, BinCode) then
                RecRef.GetTable(Bin);
            exit;
        end;

        Bin.SetRange(Code, BinCode);
        if Bin.FindFirst() then
            RecRef.GetTable(Bin);
    end;

    local procedure ResolveBinKeys(var DocumentAttachment: Record "Document Attachment"; var LocCode: Code[10]; var BinCode: Code[20])
    var
        OriginalGroup: Integer;
        Groups: List of [Integer];
        Group: Integer;
    begin
        BinCode := DocumentAttachment."No.";
        LocCode := DocumentAttachment."STR Bin Location Code";
        if (BinCode <> '') and (LocCode <> '') then
            exit;

        OriginalGroup := DocumentAttachment.FilterGroup();
        Groups.Add(0);
        Groups.Add(2);
        Groups.Add(4);
        Groups.Add(-1);

        foreach Group in Groups do begin
            DocumentAttachment.FilterGroup(Group);
            if BinCode = '' then
                if DocumentAttachment.GetFilter("No.") <> '' then
                    BinCode := CopyStr(DocumentAttachment.GetRangeMin("No."), 1, MaxStrLen(BinCode));
            if LocCode = '' then
                if DocumentAttachment.GetFilter("STR Bin Location Code") <> '' then
                    LocCode := CopyStr(DocumentAttachment.GetRangeMin("STR Bin Location Code"), 1, MaxStrLen(LocCode));
            if (BinCode <> '') and (LocCode <> '') then
                break;
        end;

        DocumentAttachment.FilterGroup(OriginalGroup);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", 'OnAfterTableHasNumberFieldPrimaryKey', '', false, false)]
    local procedure DocAttachMgt_OnAfterTableHasNumberFieldPrimaryKey(TableNo: Integer; var Result: Boolean; var FieldNo: Integer)
    begin
        if TableNo <> Database::Bin then
            exit;

        Result := true;
        FieldNo := 2;
    end;
}
