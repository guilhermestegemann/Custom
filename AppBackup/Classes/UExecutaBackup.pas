unit UExecutaBackup;

interface

uses
  UIInterface.Executa, System.SysUtils, UConfig;

type
  TExecutaBackup = class(TInterfacedObject, IExecuta)
    private
      FConfig : TConfig;
    public
      constructor Create(AConfig : TConfig);
      procedure Executar;
  end;

implementation

uses
  UCriaPastasIniciais, UConstantes, Vcl.Dialogs, UGeraNiveisBackup;

constructor TExecutaBackup.Create(AConfig : TConfig);
begin
  inherited Create();
  Self.FConfig := AConfig;
end;

procedure TExecutaBackup.Executar;
begin
  if Self.FConfig.EstaNaHora() then
  begin
    TExecuta.GetInstancia(TCriaPastasIniciais.Create()).Executar();
    if not FileExists(ExtractFilePath(ParamStr(0))+ TConstantes.cPastaBackupNivel+'0\'+TConstantes.cNomeBackupNivel+'0') then
      TExecuta.GetInstancia(TGeraNiveisBackup.Create(Self.FConfig, '0')).Executar();
    TExecuta.GetInstancia(TGeraNiveisBackup.Create(Self.FConfig, '1')).Executar();
  end;
    //TExecuta.GetInstancia(TCriaPastasIniciais.Create()).Executar();

end;

end.
