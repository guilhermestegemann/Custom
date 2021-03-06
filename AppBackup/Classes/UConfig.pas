unit UConfig;

interface

uses
  System.SysUtils, System.Classes;

type TConfig = class(TObject)
  private
    FHoraInicio : TTime;
    FHoraFim : TTime;
    FPathInstalacaoFirebird : String;
    FBaseDados : String;
    FDiretoriosCopias : TStringList;
    FDataUltimaCopia : TDate;
    FDataInicioBackup : TDate;
    FTempoTimer: Integer;
    FCNPJ : String;
    FHostFTP : String;
    function ValidarHora(AValue : String) : TTime;
    procedure SetPathInstalacaoFirebird(const Value: String);
    procedure SetTempoTimer(const Value: Integer);
  public
    property HoraInicio : TTime read FHoraInicio;
    property HoraFim : TTime read FHoraFim;
    property PathInstalacaoFirebird : String read FPathInstalacaoFirebird write SetPathInstalacaoFirebird;
    property BaseDados : String read FBaseDados write FBaseDados;
    property DiretoriosCopias : TStringList read FDiretoriosCopias write FDiretoriosCopias;
    property DataUltimaCopia : TDate read FDataUltimaCopia write FDataUltimaCopia;
    property DataInicioBackup : TDate read FDataInicioBackup write FDataInicioBackup;
    property TempoTimer : Integer read FTempoTimer write SetTempoTimer;
    property CNPJ : String read FCNPJ write FCNPJ;
    property HostFTP : String read FHostFTP write FHostFTP;
    procedure SetHoraInicio(AValue : String);
    procedure SetHoraFim(AValue : String);
    function EstaNaHora : Boolean;
    function GetDataInicioBackupString : String;
    function GetDataInicioBackupAnteriorString : String;
    constructor Create;
    destructor Destroy; override;
end;

implementation

{ TConfig }

constructor TConfig.Create;
begin
  inherited;
  Self.FDataUltimaCopia := Now - 1;
  Self.FDiretoriosCopias := TStringList.Create;
end;

destructor TConfig.Destroy;
begin
  Self.FDiretoriosCopias.Free();
  inherited;
end;

function TConfig.EstaNaHora: Boolean;
begin
  Result := ((Time >= Self.FHoraInicio) and (Time <= Self.FHoraFim) and (Date > Self.FDataUltimaCopia));
end;

function TConfig.GetDataInicioBackupAnteriorString: String;
begin
  Result := FormatDateTime('DDMMYYY', Self.FDataInicioBackup -1);
end;

function TConfig.GetDataInicioBackupString: String;
begin
  Result := FormatDateTime('DDMMYYY', Self.FDataInicioBackup);
end;

procedure TConfig.SetHoraFim(AValue: String);
begin
  Self.FHoraFim := Self.ValidarHora(AValue);
end;

procedure TConfig.SetHoraInicio(AValue: String);
begin
  Self.FHoraInicio := Self.ValidarHora(AValue);
end;

procedure TConfig.SetPathInstalacaoFirebird(const Value: String);
begin
  Self.FPathInstalacaoFirebird := IncludeTrailingBackslash(Value);
end;

procedure TConfig.SetTempoTimer(const Value: Integer);
begin
  FTempoTimer := Value * 60000;
end;

function TConfig.ValidarHora(AValue: String): TTime;
begin
  try
    Result := StrToTime(AValue);
  except
    raise Exception.Create('Informar uma hora v�lida!');
  end;
end;

end.
