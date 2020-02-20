program BackupService;

uses
  Vcl.SvcMgr,
  UFrmPrincipalService in 'UFrmPrincipalService.pas' {Backup: TService},
  UVerificaTempoExecucao in 'Uteis\UVerificaTempoExecucao.pas',
  UIInterface.Executa in 'Interfaces\UIInterface.Executa.pas',
  UCarregaConfig in 'Classes\UCarregaConfig.pas',
  UConfig in 'Classes\UConfig.pas',
  UConstantes in 'Classes\UConstantes.pas',
  UCriaPastasIniciais in 'Classes\UCriaPastasIniciais.pas',
  UExecutaBackup in 'Classes\UExecutaBackup.pas',
  UGeraNiveisBackup in 'Classes\UGeraNiveisBackup.pas',
  UCompactaArquivo in 'Classes\UCompactaArquivo.pas',
  UCopiaArquivo in 'Classes\UCopiaArquivo.pas',
  UEnvioFTP in 'Classes\UEnvioFTP.pas',
  UExecutaComando in 'Classes\UExecutaComando.pas';

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TBackup, Backup);
  Application.Run;
end.
