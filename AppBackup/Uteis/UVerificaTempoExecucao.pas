unit UVerificaTempoExecucao;

interface

uses
  UIInterface.Executa, System.SysUtils;

type
  TVerificaTempoExecucao = class(TInterfacedObject, IExecuta)
    private
      FInicio : TDateTime;
      FFim : TDateTime;
      FDescricao : String;
      FExecuta : IExecuta;
      FMensagem : String;
    public
      constructor Create(ADescricao : String; AExecuta : IExecuta); reintroduce;
      class function GetInstancia(ADescricao : String; AExecuta : IExecuta) : IExecuta;
      procedure Executar;
  end;

  TExecutaVerificaTempoExecucaoProcedureProc = procedure of Object;
  TVerificaTempoExecucaoProcedure = class(TInterfacedObject, IExecuta)
    private
      FProc : TExecutaVerificaTempoExecucaoProcedureProc;
    public
      constructor Create(AProc : TExecutaVerificaTempoExecucaoProcedureProc); reintroduce;
      procedure Executar;
  end;

implementation

uses
  System.DateUtils, Vcl.Dialogs, System.IOUtils;

constructor TVerificaTempoExecucao.Create(ADescricao : String; AExecuta : IExecuta);
begin
  inherited Create();
  Self.FExecuta := AExecuta;
  Self.FDescricao := ADescricao;
end;

procedure TVerificaTempoExecucao.Executar;
begin
  Self.FInicio := Now;
  Self.FExecuta.Executar();
  Self.FFim := Now;
  Self.FMensagem := Format(#13+'%s -> %s -> Milisegundos: %d Segundos: %d', [DateTimeToStr(Now), Self.FDescricao, MilliSecondsBetween(Self.FInicio, Self.FFim), SecondsBetween(Self.FInicio, Self.FFim)]);
  try
    TFile.AppendAllText(ExtractFilePath(ParamStr(0))+ExtractFileName(ParamStr(0))+'-TempoExecucao.txt', Self.FMensagem);
  except on E: Exception do
  end;
end;

class function TVerificaTempoExecucao.GetInstancia(ADescricao: String; AExecuta: IExecuta): IExecuta;
begin
  Result := TVerificaTempoExecucao.Create(ADescricao, AExecuta);
end;

constructor TVerificaTempoExecucaoProcedure.Create(AProc : TExecutaVerificaTempoExecucaoProcedureProc);
begin
  inherited Create();
  Self.FProc := AProc;
end;

procedure TVerificaTempoExecucaoProcedure.Executar;
begin
  Self.FProc();
end;

end.
