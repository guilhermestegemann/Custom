unit UIInterface.Executa;

interface

type

  IExecuta = interface
    ['{E248CD79-7A49-46F2-873D-10259550D198}']
    procedure Executar;
  end;

  TExecuta = class(TInterfacedObject, IExecuta)
    procedure Executar;
    class function GetInstancia(AExecuta : IExecuta) : IExecuta;
    class function GetInstanciaGravaTempoExecucao(ADescricao : String; AExecuta : IExecuta) : IExecuta;
    class procedure ExecutarDestruir(AExecuta : IExecuta);
  end;

implementation

uses
  UVerificaTempoExecucao;

procedure TExecuta.Executar;
begin
end;

class function TExecuta.GetInstancia(AExecuta: IExecuta): IExecuta;
begin
  Result := AExecuta;
end;

class function TExecuta.GetInstanciaGravaTempoExecucao(ADescricao: String; AExecuta: IExecuta): IExecuta;
begin
  Result := TVerificaTempoExecucao.Create(ADescricao, AExecuta);
end;

class procedure TExecuta.ExecutarDestruir(AExecuta: IExecuta);
begin
  AExecuta.Executar;
  AExecuta := nil;
end;

end.

