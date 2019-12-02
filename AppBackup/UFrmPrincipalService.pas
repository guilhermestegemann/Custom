unit UFrmPrincipalService;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  Vcl.ExtCtrls, UConfig;

type
  TBackup = class(TService)
    Timer: TTimer;
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure TimerTimer(Sender: TObject);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    FConfig : TConfig;
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  Backup: TBackup;

implementation

uses
  UIInterface.Executa, UCarregaConfig, UExecutaBackup;

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  Backup.Controller(CtrlCode);
end;

function TBackup.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TBackup.ServiceStart(Sender: TService; var Started: Boolean);
begin
  Self.FConfig := TConfig.Create();
  TExecuta.GetInstancia(TCarregaConfig.Create(Self.FConfig)).Executar();
  Timer.Interval := Self.FConfig.TempoTimer;
end;

procedure TBackup.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  Self.FConfig.Free();
end;

procedure TBackup.TimerTimer(Sender: TObject);
begin
  try
    Timer.Enabled := False;
    TExecuta.GetInstancia(TExecutaBackup.Create(Self.FConfig)).Executar();
  finally
    Timer.Enabled := True;
  end;
end;

end.
