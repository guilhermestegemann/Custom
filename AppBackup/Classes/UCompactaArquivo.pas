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
  System.Zip;

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
  Zip: TZipFile;
begin
  Zip := TZipFile.Create;
  try
    if FileExists(AZipFile) then
      Zip.Open(AZipFile, zmReadWrite)
    else
      Zip.Open(AZipFile, zmWrite);
    Zip.Add(AFileName, extractFileName(AFileName));
    Zip.Close;
  finally
    Zip.Free;
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
