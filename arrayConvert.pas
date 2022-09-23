program arrayConvert;

{$mode objfpc}{$H+}

uses
 {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
   {$ENDIF} {$ENDIF}
  Classes,
  SysUtils,
  typinfo,
  fpg_base,
  fpg_main,
  fpg_form,
  fpg_button,
  fpg_memo;

type
  TMainForm = class(TfpgForm)
  private
    {@VFD_HEAD_BEGIN: MainForm}
    inputMemo: TfpgMemo;
    btnConvert: TfpgButton;
    outputMemo: TfpgMemo;
    {@VFD_HEAD_END: MainForm}
    procedure btnConvertClicked(Sender: TObject);
  public
    procedure AfterCreate; override;
  end;


  { TMainForm }

  procedure TMainForm.btnConvertClicked(Sender: TObject);
  var
    originalString, formattedString: string;
    i, x: smallint;
  begin
    x := 0;
    i := 0;
    formattedString := '';
    outputMemo.Lines.Clear;

    outputMemo.Lines.Add('array = (');

    for x := 0 to inputMemo.Lines.Count - 1 do
    begin
      formattedString := '(''';
      originalString := inputMemo.Lines[x];
      for i := 1 to Length(originalString) do
      begin
        if (i = Length(originalString)) then
          formattedString := formattedString + originalString[i] + ''''
        else
          formattedString := formattedString + originalString[i] + ''', ''';

      end;
      if (x = inputMemo.Lines.Count - 1) then
		formattedString := formattedString + ')'
	  else
		formattedString := formattedString + '),';
      outputMemo.Lines.Add(formattedString);
    end;
    outputMemo.Lines.Add(');');
  end;

  procedure TMainForm.AfterCreate;
  begin
    {@VFD_BODY_BEGIN: MainForm}
    Name := 'MainForm';
    SetPosition(627, 557, 566, 363);
    WindowTitle := 'Array Converter';
    Hint := '';
    IconName := 'stdimg.windowicon';
    windowPosition := wpOneThirdDown;

    inputMemo := TfpgMemo.Create(self);
    with inputMemo do
    begin
      Name := 'inputMemo';
      SetPosition(10, 40, 262, 312);
      Align := alLeft;
      Anchors := [anLeft, anTop, anBottom];
      FontDesc := '#Edit1';
      Hint := '';
      TabOrder := 0;
      UseTabs := True;
    end;

    btnConvert := TfpgButton.Create(self);
    with btnConvert do
    begin
      Name := 'btnConvert';
      SetPosition(242, 4, 80, 24);
      Align := alTop;
      Anchors := [anRight, anTop];
      Text := 'Convert';
      FontDesc := '#Label1';
      Hint := '';
      TabOrder := 2;
      OnClick := @btnConvertClicked;
    end;

    outputMemo := TfpgMemo.Create(self);
    with outputMemo do
    begin
      Name := 'outputMemo';
      SetPosition(296, 40, 264, 313);
      Anchors := [anLeft, anRight, anTop, anBottom];
      FontDesc := '#Edit1';
      Hint := '';
      TabOrder := 1;
    end;

    {@VFD_BODY_END: MainForm}
  end;

  procedure MainProc;
  var
    frm: TMainForm;
  begin
    fpgApplication.Initialize;
    frm := TMainForm.Create(nil);
    frm.Show;
    fpgApplication.Run;
    frm.Free;
  end;

begin
  MainProc;
end.
