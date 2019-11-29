unit UCriaPastasIniciais;

interface

uses
  UIInterface.Executa, System.SysUtils;

type
  TCriaPastasIniciais = class(TInterfacedObject, IExecuta)
    private

    public
      constructor Create;
      procedure Executar;
  end;

implementation

uses
  UConstantes;

constructor TCriaPastasIniciais.Create;
begin
  inherited Create();
end;

procedure TCriaPastasIniciais.Executar;
begin
  if not DirectoryExists(ExtractFilePath(ParamStr(0))+TConstantes.cPastaBackupNivel+'0') then
    ForceDirectories(ExtractFilePath(ParamStr(0))+TConstantes.cPastaBackupNivel+'0');
  if not DirectoryExists(ExtractFilePath(ParamStr(0))+TConstantes.cPastaBackupNivel+'1') then
    ForceDirectories(ExtractFilePath(ParamStr(0))+TConstantes.cPastaBackupNivel+'1');
end;

end.
