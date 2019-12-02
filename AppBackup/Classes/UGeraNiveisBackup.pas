unit UGeraNiveisBackup;

interface

uses
  UIInterface.Executa, System.SysUtils, UConfig;

type
  TGeraNiveisBackup = class(TInterfacedObject, IExecuta)
    private
      FNivel : String;
      FConfig : TConfig;
      FNomeArquivoBackup : String;
      function GetComando : String;
      function VerificarArquivoEmUso : Boolean;
    public
      constructor Create(AConfig : TConfig; ANivel : String);
      procedure Executar;
  end;

implementation

uses
  UConstantes, Winapi.Windows, System.Classes, Vcl.Dialogs, UCompactaArquivo, UCopiaArquivo;

constructor TGeraNiveisBackup.Create(AConfig : TConfig; ANivel : String);
begin
  inherited Create();
  Self.FConfig := AConfig;
  Self.FNivel := ANivel;
  Self.FNomeArquivoBackup := ExtractFilePath(ParamStr(0))+TConstantes.cPastaBackupNivel+FNivel+'\'+TConstantes.cNomeBackupNivel+FNivel+TConstantes.cExtensaoBackupNivel;
end;

procedure TGeraNiveisBackup.Executar;
begin
  if Self.FConfig.EstaNaHora() then
  begin
    WinExec(PAnsiChar(AnsiString(Self.GetComando())),SW_NORMAL);
    while Self.VerificarArquivoEmUso() do
    begin
      Sleep(1000);
    end;
    TExecuta.GetInstancia(TCompactaArquivo.Create(Self.FNomeArquivoBackup)).Executar();
    TExecuta.GetInstancia(TCopiaArquivo.Create(Self.FConfig, Self.FNomeArquivoBackup)).Executar();
    Self.FConfig.DataUltimaCopia := Now;
  end;
end;



function TGeraNiveisBackup.GetComando: String;

begin
  Result := Self.FConfig.PathInstalacaoFirebird + TConstantes.cNBackup; //exe nbackup
  Result := Result + ' -B ' + FNivel + ' '; //ajustaNivel
  Result := Result + Self.FConfig.BaseDados + ' '; //banco de dados
  Result := Result + Self.FNomeArquivoBackup; //nome backup
  Result := Result + ' -U sysdba -P masterkey'; //usuario e senha database
end;

function TGeraNiveisBackup.VerificarArquivoEmUso : Boolean;
var
  S: TStream;
  LDestruirObjeto : Boolean;
begin
  LDestruirObjeto := False;
  Result := False;
  try
    try
      S := TFileStream.Create(Self.FNomeArquivoBackup, fmOpenRead or fmShareExclusive);
      LDestruirObjeto := True;
    except
      on EFOpenError do
      begin
        Result := True;
      end;
    end;
  finally
    if LDestruirObjeto then
      S.Free();
  end;
end;

end.
