unit ufrmmain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ComCtrls, Windows;

type

  { TFrmMain }

  TFrmMain = class(TForm)
    BtnGenNick: TButton;
    BtnGenPass: TButton;
    ChkNabor1: TCheckBox;
    ChkNabor2: TCheckBox;
    ChkNabor3: TCheckBox;
    ChkNabor4: TCheckBox;
    CheckBox5: TCheckBox;
    EdUser: TEdit;
    EdNick: TLabeledEdit;
    EdPassword: TLabeledEdit;
    EdCharCount: TLabeledEdit;
    GroupBox1: TGroupBox;
    UpDown1: TUpDown;
    procedure BtnGenNickClick(Sender: TObject);
    procedure BtnGenPassClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.lfm}

{ TFrmMain }

const
  Nabor1 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  Nabor2 = 'abcdefghijklmnopqrstuvwxyz';
  Nabor3 = '0123456789';
  Nabor4 = '~!@#$%^&*-_+=?';

const
  Weights: array[0..25, 0..25] of Integer = (
    (15, 97, 104, 184, 65, 28, 59, 142, 211, 15, 68, 504, 228, 1029, 19, 27,
    12, 691, 198, 184, 88, 130, 30, 24, 133, 45),
    (114, 13, 0, 4, 155, 0, 0, 3, 72, 1, 0, 26, 0, 1, 37, 0, 0, 135,
    4, 1, 21, 0, 0, 0, 28, 0),
    (201, 0, 6, 0, 148, 0, 0, 222, 97, 0, 62, 53, 0, 0, 116, 0, 3,
    18, 1, 12, 14, 0, 1, 0, 30, 0),
    (297, 0, 0, 23, 275, 3, 4, 4, 162, 0, 0, 14, 6, 9, 132, 0, 0, 79,
    8, 0, 38, 1, 11, 0, 61, 1),
    (150, 33, 32, 110, 103, 25, 36, 16, 79, 5, 30, 562, 114, 504, 57, 20, 4,
    536, 180, 175, 27, 96, 27, 19, 132, 13),
    (68, 0, 0, 0, 48, 23, 1, 0, 53, 1, 0, 21, 0, 1, 24, 0, 0, 48, 0,
    3, 5, 0, 1, 0, 5, 0),
    (150, 0, 0, 5, 98, 0, 12, 37, 81, 0, 0, 20, 1, 10, 35, 0, 0, 35,
    3, 4, 42, 0, 9, 0, 8, 1),
    (422, 3, 0, 3, 209, 0, 1, 0, 149, 0, 1, 15, 6, 16, 91, 0, 0, 24,
    2, 9, 45, 0, 2, 0, 24, 1),
    (430, 24, 166, 105, 281, 27, 56, 8, 2, 9, 77, 303, 92, 561, 99, 24, 10,
    158, 309, 175, 26, 54, 2, 12, 22, 29),
    (130, 0, 0, 0, 82, 0, 0, 0, 20, 0, 1, 0, 0, 0, 74, 0, 0, 0, 0, 0, 44, 0, 1, 0, 2, 0),
    (266, 0, 0, 0, 157, 0, 0, 8, 122, 0, 7, 7, 0, 3, 72, 0, 0, 18,
    7, 3, 17, 0, 2, 0, 38, 0),
    (540, 22, 9, 70, 439, 11, 6, 5, 496, 1, 11, 309, 26, 1, 199, 10, 0, 3, 23,
    35, 63, 32, 5, 0, 137, 0),
    (511, 29, 4, 2, 167, 1, 0, 2, 217, 0, 1, 6, 22, 4, 123, 11, 0,
    6, 3, 0, 28, 0, 0, 0, 25, 0),
    (625, 1, 71, 227, 392, 5, 95, 13, 295, 13, 14, 14, 0, 243, 129, 0, 1, 10,
    33, 130, 29, 2, 4, 1, 74, 12),
    (27, 27, 35, 61, 23, 7, 10, 28, 18, 3, 38, 173, 62, 500, 23, 28, 0, 338,
    104, 43, 37, 35, 33, 7, 27, 10),
    (93, 0, 0, 0, 75, 0, 0, 72, 33, 0, 0, 7, 0, 1, 21, 13, 0, 31, 3,
    3, 5, 0, 0, 0, 4, 0),
    (4, 0, 0, 0, 1, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 51, 0, 2, 0, 0, 0),
    (491, 22, 37, 84, 333, 3, 37, 13, 561, 5, 20, 91, 47, 71, 223, 5, 0, 110,
    44, 81, 61, 29, 14, 1, 114, 3),
    (233, 5, 24, 4, 151, 0, 1, 227, 123, 0, 14, 28, 23, 6, 89, 21, 0, 3, 90,
    186, 43, 5, 5, 0, 27, 1),
    (366, 2, 10, 0, 214, 1, 1, 183, 155, 2, 2, 11, 1, 6, 174, 0, 0, 88, 9,
    103, 38, 0, 4, 0, 59, 5),
    (38, 17, 32, 39, 52, 5, 19, 3, 37, 4, 15, 82, 39, 75, 11, 11, 0, 103, 120,
    21, 0, 8, 2, 2, 17, 10),
    (163, 0, 0, 0, 141, 0, 0, 0, 169, 0, 1, 5, 0, 0, 27, 0, 0, 7, 0,
    0, 2, 1, 0, 0, 9, 0),
    (73, 0, 0, 2, 57, 0, 0, 10, 57, 0, 1, 2, 1, 11, 11, 0, 0, 6, 4,
    1, 0, 0, 0, 0, 23, 2),
    (22, 0, 0, 0, 11, 0, 0, 1, 24, 0, 0, 1, 1, 0, 6, 0, 0, 0, 0, 7, 4, 0, 1, 0, 3, 0),
    (151, 6, 10, 23, 45, 0, 2, 0, 10, 0, 3, 82, 13, 130, 42, 4, 0,
    35, 35, 17, 12, 4, 1, 1, 1, 0),
    (89, 2, 0, 0, 46, 0, 0, 5, 52, 1, 0, 4, 0, 0, 23, 0, 0, 3, 2, 0, 22, 0, 2, 0, 7, 7)
    );

var
  Letters: array[0..25, 0..25] of Integer;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  C, T: Integer;
  I, J: Integer;
begin
  ChkNabor1.Caption := Nabor1;
  ChkNabor1.Checked := True;

  ChkNabor2.Caption := Nabor2;
  ChkNabor2.Checked := True;

  ChkNabor3.Caption := Nabor3;
  ChkNabor3.Checked := True;

  ChkNabor4.Caption := Nabor4;

  for I := 0 to 25 do
  begin
    C := 0;
    T := 0;

    for J := 0 to 25 do
      C := C + Weights[I][J];

    for J := 0 to 25 do
    begin
      T := T + Weights[I][J];
      Letters[I][J] := Round(T / C * 1000);
    end;
  end;

  BtnGenPass.Click;
end;

procedure TFrmMain.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  SC_DragMove = $F012;
begin
  ReleaseCapture;
  SendMessage(Self.Handle, WM_SYSCOMMAND, SC_DragMove, 0);
end;

procedure TFrmMain.UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
begin
  BtnGenPass.Click;
end;

procedure TFrmMain.BtnGenNickClick(Sender: TObject);
var
  NameLen: Integer;
  CurChar: Integer;
  Nam: String;
  FirstChar: Integer;
  Cnt: Integer;
  Ran: Integer;
  NextChar: Integer;
  J: Integer;
begin
  NameLen := 3 + Random(7);
  CurChar := Random(26);
  Nam := Nabor1[1 + CurChar];
  FirstChar := CurChar;
  for Cnt := 1 to NameLen do
  begin
    Ran := Random(1000);
    NextChar := 0;
    for J := 0 to 25 do
      if (Ran >= Letters[FirstChar][J]) then
        NextChar := NextChar + 1;
    FirstChar := NextChar;
    Nam := Nam + Nabor2[1 + NextChar];
  end;
  EdNick.Text := Nam;
end;

procedure TFrmMain.BtnGenPassClick(Sender: TObject);
var
  Alphabet: String;
  CharCount: Integer;
  Res: String;
  I: Integer;
begin
  Alphabet := '';

  if ChkNabor1.Checked then
    Alphabet := Alphabet + Nabor1;
  if ChkNabor2.Checked then
    Alphabet := Alphabet + Nabor2;
  if ChkNabor3.Checked then
    Alphabet := Alphabet + Nabor3;
  if ChkNabor4.Checked then
    Alphabet := Alphabet + Nabor4;

  if CheckBox5.Checked and (EdUser.Text <> '') then
    Alphabet := Alphabet + EdUser.Text;

  if Length(Alphabet) = 0 then
  begin
    EdPassword.Text := '';
    Exit;
  end;

  CharCount := StrToIntDef(EdCharCount.Text, 8);

  Res := '';
  for I := 0 to CharCount - 1 do
    Res := Res + Alphabet[1 + Random(Length(Alphabet))];

  EdPassword.Text := Res;
end;

initialization

  Randomize;

end.
