unit UCompactaArquivo;

interface

uses
  UIInterface.Executa, System.SysUtils, UConfig;

type
  TCompactaArquivo = class(TInterfacedObject, IExecuta)
    private
      FNomeArquivoBackup : String;
      FConfig : TConfig;
      FNivel : String;
      procedure ExcluirArquivo;
      procedure CompactarArquivo(AZipFile, AFileName: String);
      function ExtractName(const Filename: String): String;
      function VerificarArquivoEmUso(AArquivo : String) : Boolean;
    public
      constructor Create(ANomeArquivoBackup : String; AConfig : TConfig; ANivel : String);
      procedure Executar;
  end;

implementation

uses
  UEnvioFTP, System.Classes, UExecutaComando;

const
  cExtensaoZip = '.zip';

constructor TCompactaArquivo.Create(ANomeArquivoBackup : String; AConfig : TConfig; ANivel : String);
begin
  inherited Create();
  Self.FNomeArquivoBackup := ANomeArquivoBackup;
  Self.FConfig := AConfig;
  Self.FNivel := ANivel;
end;

procedure TCompactaArquivo.ExcluirArquivo;
begin
  if FileExists(ExtractFilePath(Self.FNomeArquivoBackup)+ExtractName(Self.FNomeArquivoBackup)+cExtensaoZip) then
    DeleteFile(ExtractFilePath(Self.FNomeArquivoBackup)+ExtractName(Self.FNomeArquivoBackup)+cExtensaoZip);
end;

procedure TCompactaArquivo.Executar;
begin
  Self.ExcluirArquivo();
  Self.CompactarArquivo(ExtractFilePath(Self.FNomeArquivoBackup)+ExtractName(Self.FNomeArquivoBackup)+cExtensaoZip, Self.FNomeArquivoBackup);
  TExecuta.GetInstancia(TEnvioFTP.Create(ExtractFilePath(Self.FNomeArquivoBackup)+ExtractName(Self.FNomeArquivoBackup)+cExtensaoZip, Self.FConfig, Self.FNivel)).Executar();
end;

procedure TCompactaArquivo.CompactarArquivo(AZipFile, AFileName: String);
var
  //ZipMaster: TZipMaster;
  LComando : TStringList;
begin
  {ZipMaster := TZipMaster.Create(nil);
  try
    ZipMaster.Active := True;
    ZipMaster.DLLDirectory := GetCurrentDir + '\dll';
    ZipMaster.ZipFilename  := AZipFile;
    ZipMaster.FSpecArgs.Clear();
    ZipMaster.FSpecArgs.Add(AFileName);
    ZipMaster.Add();
  finally
    ZipMaster.Free;
  end;}
  LComando := TStringList.Create();
  try
    LComando.Add(ExtractFilePath(ParamStr(0)) + '7z.exe a -t7z ');
    LComando.Add(' "' + AZipFile + '" ');
    LComando.Add(' "' + AFileName + '" ');
    TExecuta.GetInstancia(TExecutaComando.Create(LComando)).Executar();
    while Self.VerificarArquivoEmUso(AZipFile) do
    begin
      Sleep(60000);
    end;
  finally
    LComando.Free();
  end;
end;

function TCompactaArquivo.ExtractName(const Filename: String): String;
var
  LExt : String;
  LPos : Integer;
begin
  LExt := ExtractFileExt(Filename);
  Result := ExtractFileName(Filename);
  if LExt <> '' then
  begin
    LPos := Pos(LExt,Result);
    if LPos > 0 then
    begin
      Delete(Result,LPos,Length(LExt));
    end;
  end;
end;



function TCompactaArquivo.VerificarArquivoEmUso(AArquivo : String): Boolean;
var
  S: TStream;
  LDestruirObjeto : Boolean;
begin
  LDestruirObjeto := False;
  Result := False;
  try
    try
      S := TFileStream.Create(AArquivo, fmOpenRead or fmShareExclusive);
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
