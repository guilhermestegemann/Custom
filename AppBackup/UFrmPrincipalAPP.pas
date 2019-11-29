unit UFrmPrincipalAPP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, UConfig;

type
  TForm1 = class(TForm)
    Timer: TTimer;
    ButtonStart: TButton;
    ButtonStop: TButton;
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    FConfig : TConfig;
    procedure CarregarConfig;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  UIInterface.Executa, UCarregaConfig, UExecutaBackup;

{$R *.dfm}

procedure TForm1.ButtonStartClick(Sender: TObject);
begin
  Timer.Enabled := True;
  ButtonStart.Enabled := False;
  ButtonStop.Enabled := True;
  Self.CarregarConfig();
end;

procedure TForm1.ButtonStopClick(Sender: TObject);
begin
  Timer.Enabled := False;
  ButtonStart.Enabled := True;
  ButtonStop.Enabled := False;
end;

procedure TForm1.CarregarConfig;
begin
  TExecuta.GetInstancia(TCarregaConfig.Create(Self.FConfig)).Executar();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Self.FConfig := TConfig.Create();
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Self.FConfig.Free();
end;

procedure TForm1.TimerTimer(Sender: TObject);
begin
  try
    Timer.Enabled := False;
    TExecuta.GetInstancia(TExecutaBackup.Create(Self.FConfig)).Executar();
  finally
    Timer.Enabled := True;
  end;
end;

end.
