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
    function ValidarHora(AValue : String) : TTime;
    procedure SetPathInstalacaoFirebird(const Value: String);
  public
    property HoraInicio : TTime read FHoraInicio;
    property HoraFim : TTime read FHoraFim;
    property PathInstalacaoFirebird : String read FPathInstalacaoFirebird write SetPathInstalacaoFirebird;
    property BaseDados : String read FBaseDados write FBaseDados;
    property DiretoriosCopias : TStringList read FDiretoriosCopias write FDiretoriosCopias;
    property DataUltimaCompra : TDate read FDataUltimaCopia write FDataUltimaCopia;
    procedure SetHoraInicio(AValue : String);
    procedure SetHoraFim(AValue : String);
    function EstaNaHora : Boolean;
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
  Result := ((Time >= Self.FHoraInicio) and (Time <= Self.FHoraFim) and (Now > Self.FDataUltimaCopia));
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

function TConfig.ValidarHora(AValue: String): TTime;
begin
  try
    Result := StrToTime(AValue);
  except
    raise Exception.Create('Informar uma hora válida!');
  end;
end;

end.
