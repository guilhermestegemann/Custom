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
  TExecuta.GetInstancia(TCriaPastasIniciais.Create()).Executar();
  if not FileExists(ExtractFilePath(ParamStr(0))+ TConstantes.cPastaBackupNivel+'0\'+TConstantes.cNomeBackupNivel+'0'+TConstantes.cExtensaoBackupNivel) then
    TExecuta.GetInstancia(TGeraNiveisBackup.Create(Self.FConfig, '0')).Executar();
  if FileExists(ExtractFilePath(ParamStr(0))+ TConstantes.cPastaBackupNivel+'1\'+TConstantes.cNomeBackupNivel+'1'+TConstantes.cExtensaoBackupNivel) then
    if Self.FConfig.EstaNaHora() then
      DeleteFile(ExtractFilePath(ParamStr(0))+ TConstantes.cPastaBackupNivel+'1\'+TConstantes.cNomeBackupNivel+'1'+TConstantes.cExtensaoBackupNivel);
  TExecuta.GetInstancia(TGeraNiveisBackup.Create(Self.FConfig, '1')).Executar();
end;

end.
