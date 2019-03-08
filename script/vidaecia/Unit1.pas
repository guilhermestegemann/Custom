unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    ListBox2: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  ListBox1.Items.LoadFromFile('C:\Users\Topsystem\Desktop\vida.txt');
end;

procedure TForm1.Button2Click(Sender: TObject);
const
  cSql = 'DELETE FROM %s WHERE %s.FILIAL = 1; COMMIT;';
var
  I : Integer;
begin
  for I := 0 to ListBox1.Items.Count -1 do
  begin
    ListBox2.Items.Add(Format(cSql,[ListBox1.Items[I], ListBox1.Items[I]]));
  end;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ListBox2.Items.SaveToFile('C:\Users\Topsystem\Desktop\vidaconvertido.txt');
end;

end.
