unit UEnvioFTP;

interface

uses
  UIInterface.Executa, System.SysUtils, IdFTP, UConfig;

type
  TEnvioFTP = class(TInterfacedObject, IExecuta)
    private
      FNomeArquivoBackupZip : String;
      FFTP : TIdFTP;
      FConfig : TConfig;
      FNivel : String;
      procedure ConfigurarFTP;
      procedure ConectarFTP;
      procedure DesconectarFTP;
      procedure ReconectarFTP;
      procedure CriarPastaCNPJ;
      procedure CriarPastaData;
      procedure CriarPastaNivel;
      procedure UparArquivo;
      procedure DeletarArquivoAnterior;
      function FTPFileExists(AFileName : String): Boolean;
    public
      constructor Create(ANomeArquivoBackupZip : String; AConfig : TConfig; ANivel : String);
      destructor Destroy; override;
      procedure Executar;
  end;

implementation

uses
  IdFTPCommon;

procedure TEnvioFTP.ConectarFTP;
begin
  Self.FFTP.Connect();
  Self.FFTP.Login();
end;

procedure TEnvioFTP.ConfigurarFTP;
begin
  Self.FFTP.Host := Self.FConfig.HostFTP;
  Self.FFTP.Username := 'adminbackup';
  Self.FFTP.Password := 'SbOX$HlAx3E6';
  Self.FFTP.Passive := True;
  Self.FFTP.TransferType:= ftBinary;
end;

constructor TEnvioFTP.Create(ANomeArquivoBackupZip : String; AConfig : TConfig; ANivel : String);
begin
  inherited Create();
  Self.FNomeArquivoBackupZip := ANomeArquivoBackupZip;
  Self.FConfig := AConfig;
  Self.FNivel := ANivel;
  Self.FFTP := TIdFTP.Create();
end;


procedure TEnvioFTP.CriarPastaCNPJ;
begin
  try
    Self.FFTP.ChangeDir(Self.FConfig.CNPJ);
  except
    on E : Exception do
    begin
      Self.FFTP.MakeDir(Self.FConfig.CNPJ);
      Self.FFTP.ChangeDir(Self.FConfig.CNPJ);
    end;
  end;
end;

procedure TEnvioFTP.CriarPastaData;
begin
  try
    Self.FFTP.ChangeDir(Self.FConfig.GetDataInicioBackupString());
  except
    on E : Exception do
    begin
      Self.FFTP.MakeDir(Self.FConfig.GetDataInicioBackupString());
      Self.FFTP.ChangeDir(Self.FConfig.GetDataInicioBackupString());
    end;
  end;
end;

procedure TEnvioFTP.CriarPastaNivel;
begin
  try
    Self.FFTP.ChangeDir(Self.FNivel);
  except
    on E : Exception do
    begin
      Self.FFTP.MakeDir(Self.FNivel);
      Self.FFTP.ChangeDir(Self.FNivel);
    end;
  end;
end;

procedure TEnvioFTP.DeletarArquivoAnterior;
begin
  if Self.FTPFileExists(Self.FNivel+'-old.zip') then
    Self.FFTP.Delete(Self.FNivel+'-old.zip');
end;

procedure TEnvioFTP.DesconectarFTP;
begin
  Self.FFTP.Disconnect();
end;

destructor TEnvioFTP.Destroy;
begin
  Self.FFTP.Free();
  inherited;
end;

procedure TEnvioFTP.Executar;
begin
  Self.ConfigurarFTP();
  Self.ConectarFTP();
  try
    Self.CriarPastaCNPJ();
    Self.UparArquivo();
    Self.DeletarArquivoAnterior();
  finally
    Self.DesconectarFTP();
  end;
end;

procedure TEnvioFTP.ReconectarFTP;
begin
  Self.DesconectarFTP();
  Self.ConectarFTP();
end;

procedure TEnvioFTP.UparArquivo;
begin
  if Self.FTPFileExists(Self.FNivel+'.zip') then
    Self.FFTP.Rename(Self.FNivel+'.zip', Self.FNivel+'-old.zip');
  Self.FFTP.Put(Self.FNomeArquivoBackupZip, Self.FNivel+'.zip', False);
end;

function TEnvioFTP.FTPFileExists(AFileName : String): Boolean;
begin
  try
    Self.FFTP.List(nil, aFileName, True);
    Result:= (Self.FFTP.ListResult.Count > 0);
  except
    on E : Exception do
      Result := False;
  end;
end;

end.
