unit UCompactaArquivo;

interface

uses
  UIInterface.Executa, System.SysUtils;

type
  TCompactaArquivo = class(TInterfacedObject, IExecuta)
    private
      FNomeArquivoBackup : String;
      procedure ExcluirArquivo;
      procedure CompactarArquivo(AZipFile, AFileName: String);
      function ExtractName(const Filename: String): String;
    public
      constructor Create(ANomeArquivoBackup : String);
      procedure Executar;
  end;

implementation

uses
  ZipMstr;

const
  cExtensaoZip = '.zip';

constructor TCompactaArquivo.Create(ANomeArquivoBackup : String);
begin
  inherited Create();
  Self.FNomeArquivoBackup := ANomeArquivoBackup;
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
end;

procedure TCompactaArquivo.CompactarArquivo(AZipFile, AFileName: String);
var
  ZipMaster: TZipMaster;
begin
  ZipMaster := TZipMaster.Create(nil);
  try
    ZipMaster.Active := True;
    ZipMaster.DLLDirectory := GetCurrentDir + '\dll';
    ZipMaster.ZipFilename  := AZipFile;
    ZipMaster.FSpecArgs.Clear();
    ZipMaster.FSpecArgs.Add(AFileName);
    ZipMaster.Add();
  finally
    ZipMaster.Free;
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

end.
