program BackupApp;

uses
  Vcl.Forms,
  UFrmPrincipalAPP in 'UFrmPrincipalAPP.pas' {Form1},
  UVerificaTempoExecucao in 'Uteis\UVerificaTempoExecucao.pas',
  UIInterface.Executa in 'Interfaces\UIInterface.Executa.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
