unit UGeraNiveisBackup;

interface

uses
  UIInterface.Executa, System.SysUtils, UConfig;

type
  TGeraNiveisBackup = class(TInterfacedObject, IExecuta)
    private
      FNivel : String;
      FConfig : TConfig;
      function GetComando : String;
    public
      constructor Create(AConfig : TConfig; ANivel : String);
      procedure Executar;
  end;

implementation

uses
  UConstantes, Winapi.Windows;

constructor TGeraNiveisBackup.Create(AConfig : TConfig; ANivel : String);
begin
  inherited Create();
  Self.FConfig := AConfig;
  Self.FNivel := ANivel;
end;

procedure TGeraNiveisBackup.Executar;
begin
  if Self.FConfig.EstaNaHora() then
  begin
    WinExec(PAnsiChar(AnsiString(Self.GetComando())),SW_NORMAL);
    //TExecuta.GetInstancia().Executar();
    Self.FConfig.DataUltimaCopia := Now;
  end;
end;



function TGeraNiveisBackup.GetComando: String;

begin
  Result := Self.FConfig.PathInstalacaoFirebird + TConstantes.cNBackup; //exe nbackup
  Result := Result + ' -B ' + FNivel + ' '; //ajustaNivel
  Result := Result + Self.FConfig.BaseDados + ' '; //banco de dados
  Result := Result + ExtractFilePath(ParamStr(0))+TConstantes.cPastaBackupNivel+FNivel+'\'+TConstantes.cNomeBackupNivel+FNivel+TConstantes.cExtensaoBackupNivel; //nome backup
  Result := Result + ' -U sysdba -P masterkey'; //usuario e senha database
end;

end.
