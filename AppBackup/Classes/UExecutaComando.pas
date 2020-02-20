unit UExecutaComando;

interface

uses
  UIInterface.Executa, System.SysUtils, System.Classes;

type
  TExecutaComando = class(TInterfacedObject, IExecuta)
    private
      FParametros : TStringList;
      function GetComando : String;
    public
      constructor Create(AParametros : TStringList);
      procedure Executar;
  end;

implementation

uses
  Winapi.Windows;


constructor TExecutaComando.Create(AParametros : TStringList);
begin
  inherited Create();
  Self.FParametros := AParametros;
end;


procedure TExecutaComando.Executar;
begin
  WinExec(PAnsiChar(AnsiString(Self.GetComando())),SW_HIDE);
end;


function TExecutaComando.GetComando: String;
var
  I : Integer;
begin
  for I := 0 to Self.FParametros.Count - 1 do
    Result := Result + Self.FParametros[I];
end;

end.
