program BackupApp;

uses
  Vcl.Forms,
  UFrmPrincipalAPP in 'UFrmPrincipalAPP.pas' {Form1},
  UVerificaTempoExecucao in 'Uteis\UVerificaTempoExecucao.pas',
  UIInterface.Executa in 'Interfaces\UIInterface.Executa.pas',
  UConfig in 'Classes\UConfig.pas',
  UCarregaConfig in 'Classes\UCarregaConfig.pas',
  UExecutaBackup in 'Classes\UExecutaBackup.pas',
  UCriaPastasIniciais in 'Classes\UCriaPastasIniciais.pas',
  UConstantes in 'Classes\UConstantes.pas',
  UGeraNiveisBackup in 'Classes\UGeraNiveisBackup.pas',
  UCompactaArquivo in 'Classes\UCompactaArquivo.pas',
  UCopiaArquivo in 'Classes\UCopiaArquivo.pas',
  UBackup in 'Classes\UBackup.pas',
  UEnvioFTP in 'Classes\UEnvioFTP.pas',
  UExecutaComando in 'Classes\UExecutaComando.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
