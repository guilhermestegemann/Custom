unit UCopiaArquivo;

interface

uses
  UIInterface.Executa, UConfig;

type
  TCopiaArquivo = class(TInterfacedObject, IExecuta)
    private
      FNomeArquivoBackup : String;
      FConfig : TConfig;
      function ExtractName(const Filename: String): String;
    public
      constructor Create(AConfig : TConfig; ANomeArquivoBackup : String);
      procedure Executar;
  end;

implementation

uses
  Winapi.Windows, System.SysUtils;

const
  cExtensaoZip = '.zip';

constructor TCopiaArquivo.Create(AConfig : TConfig; ANomeArquivoBackup : String);
begin
  inherited Create();
  Self.FNomeArquivoBackup := ANomeArquivoBackup;
  Self.FConfig := AConfig;
end;

procedure TCopiaArquivo.Executar;
var
  I : Integer;
begin
  for I := 0 to Self.FConfig.DiretoriosCopias.Count -1 do
  begin
    CopyFile(PChar(ExtractFilePath(Self.FNomeArquivoBackup)+ExtractName(Self.FNomeArquivoBackup)+cExtensaoZip),PChar(Self.FConfig.DiretoriosCopias[I]+ExtractName(Self.FNomeArquivoBackup)+cExtensaoZip),False);
  end;
end;

function TCopiaArquivo.ExtractName(const Filename: String): String;
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
