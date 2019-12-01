unit UCarregaConfig;

interface

uses
  UIInterface.Executa, System.SysUtils, UConfig;

type
  TCarregaConfig = class(TInterfacedObject, IExecuta)
    private
      FConfig : TConfig;
    public
      constructor Create(AConfig : TConfig);
      procedure Executar;
  end;

implementation

uses
  System.IniFiles, UConstantes;

constructor TCarregaConfig.Create(AConfig : TConfig);
begin
  inherited Create();
  Self.FConfig := AConfig;
end;

procedure TCarregaConfig.Executar;
var
  ConfIni: TIniFile;
  I, LCountCopiasExtras : Integer;
begin
  ConfIni := TIniFile.Create(ExtractFilePath(ParamStr(0))+TConstantes.cIniFile);
  Self.FConfig.SetHoraInicio(ConfIni.ReadString('Backup', 'HoraInicio',''));
  Self.FConfig.SetHoraFim(ConfIni.ReadString('Backup', 'HoraFim',''));
  Self.FConfig.TempoTimer := ConfIni.ReadInteger('Backup', 'TempoTimer',15);
  Self.FConfig.PathInstalacaoFirebird := ConfIni.ReadString('Backup', 'PathInstalacaoFirebird','');
  Self.FConfig.BaseDados := ConfIni.ReadString('Backup', 'BaseDados','');
  LCountCopiasExtras := ConfIni.ReadInteger('Backup', 'CountCopiasExtras',0);
  for I := 0 to LCountCopiasExtras -1 do
  begin
    Self.FConfig.DiretoriosCopias.Add(ConfIni.ReadString('DiretoriosCopias', I.ToString(),''));
  end;
end;

end.
