unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP, IdFTPCommon;

type
  TFrmPrincipal = class(TForm)
    ButtonCompacta: TButton;
    EditHost: TLabeledEdit;
    EditUsuario: TLabeledEdit;
    EditSenha: TLabeledEdit;
    EditPasta: TLabeledEdit;
    EditTicket: TLabeledEdit;
    ButtonSalvarConfig: TButton;
    CheckBoxERP: TCheckBox;
    CheckBoxTopServerService: TCheckBox;
    CheckBoxServerERP: TCheckBox;
    FTP: TIdFTP;
    ButtonTestarConexao: TButton;
    ButtonUpar: TButton;
    ButtonCompactarUpar: TButton;
    StaticTextStatus: TStaticText;
    procedure ButtonCompactaClick(Sender: TObject);
    procedure ButtonSalvarConfigClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonTestarConexaoClick(Sender: TObject);
    procedure ButtonUparClick(Sender: TObject);
    procedure ButtonCompactarUparClick(Sender: TObject);
  private
    procedure GerarZip(AZipFile, AFileName: String);
    procedure Compactar();
    procedure ExcluirArquivos();
    procedure CarregarConfig();
    procedure TestarConexao();
    procedure ConfigurarFTP();
    procedure Upar();
    procedure ValidarTicket();
    function FTPFileExists (AFileName : String) : Boolean;
    procedure ConectarFTP;
    procedure DesconectarFTP;
  public
    { Public declarations }
  end;

const
  cTopServerServiceZip = 'TopServerService.zip';
  cServerERPZip = 'ServerERP.zip';
  cERPZip = 'ERP.zip';

  cTopServerServiceExe = 'TopServerService.exe';
  cServerERPExe = 'ServerERP.exe';
  cERPExe = 'ERP.exe';


var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  System.Zip, IniFiles;

{$R *.dfm}

procedure TFrmPrincipal.ButtonCompactaClick(Sender: TObject);
begin
  Self.Compactar();
end;

procedure TFrmPrincipal.ButtonCompactarUparClick(Sender: TObject);
begin
  Self.Compactar();
  Self.Upar();
end;

procedure TFrmPrincipal.ButtonSalvarConfigClick(Sender: TObject);
var
  LIniFile : TIniFile;
begin
  LIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0))+'compactaexe.ini');
  try
    LIniFile.WriteString('Conexao', 'Host', EditHost.Text);
    LIniFile.WriteString('Conexao', 'Usuario', EditUsuario.Text);
    LIniFile.WriteString('Conexao', 'Senha', EditSenha.Text);
    LIniFile.WriteString('Geral', 'Pasta', EditPasta.Text);
    LIniFile.WriteBool('Geral', 'ERP', CheckBoxERP.Checked);
    LIniFile.WriteBool('Geral', 'TopServerService', CheckBoxTopServerService.Checked);
    LIniFile.WriteBool('Geral', 'ServerERP', CheckBoxServerERP.Checked);
  finally
    LIniFile.Free();
  end;
end;

procedure TFrmPrincipal.ButtonTestarConexaoClick(Sender: TObject);
begin
  Self.TestarConexao();
end;

procedure TFrmPrincipal.ButtonUparClick(Sender: TObject);
begin
  Self.Upar();
end;

procedure TFrmPrincipal.CarregarConfig;
var
  LIniFile : TIniFile;
begin
  LIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0))+'compactaexe.ini');
  try
    EditHost.Text := LIniFile.ReadString('Conexao', 'Host', EmptyStr);
    EditUsuario.Text := LIniFile.ReadString('Conexao', 'Usuario', EmptyStr);
    EditSenha.Text := LIniFile.ReadString('Conexao', 'Senha', EmptyStr);
    EditPasta.Text := LIniFile.ReadString('Geral', 'Pasta', EmptyStr);
    CheckBoxERP.Checked := LIniFile.ReadBool('Geral', 'ERP', True);
    CheckBoxTopServerService.Checked := LIniFile.ReadBool('Geral', 'TopServerService', True);
    CheckBoxServerERP.Checked := LIniFile.ReadBool('Geral', 'ServerERP', True);
  finally
    LIniFile.Free();
  end;
end;

procedure TFrmPrincipal.GerarZip(AZipFile, AFileName: String);
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

procedure TFrmPrincipal.ExcluirArquivos;
begin
  if CheckBoxERP.Checked then
  begin
    if FileExists(ExtractFileDir(ParamStr(0))+'\'+cERPZip) then
      DeleteFile(ExtractFileDir(ParamStr(0))+'\'+cERPZip);
  end;
  if CheckBoxTopServerService.Checked then
  begin
    if FileExists(ExtractFileDir(ParamStr(0))+'\'+cTopServerServiceZip) then
      DeleteFile(ExtractFileDir(ParamStr(0))+'\'+cTopServerServiceZip);
  end;
  if CheckBoxServerERP.Checked then
  begin
    if FileExists(ExtractFileDir(ParamStr(0))+'\'+cServerERPZip) then
      DeleteFile(ExtractFileDir(ParamStr(0))+'\'+cServerERPZip);
  end;
end;

procedure TFrmPrincipal.Compactar;
begin
  Self.ExcluirArquivos();
  if CheckBoxERP.Checked then
    Self.GerarZip(cERPZip, cERPExe);
  if CheckBoxTopServerService.Checked then
    Self.GerarZip(cTopServerServiceZip, cTopServerServiceExe);
  if CheckBoxServerERP.Checked then
    Self.GerarZip(cServerERPZip, cServerERPExe);
end;

procedure TFrmPrincipal.ConectarFTP;
begin
  if FTP.Connected then
    FTP.Disconnect();
  FTP.Connect();
  FTP.Login();
end;

procedure TFrmPrincipal.ConfigurarFTP;
begin
  FTP.Host := EditHost.Text;
  FTP.Username := EditUsuario.Text;
  FTP.Password := EditSenha.Text;
  FTP.Passive := True;
  FTP.Connect();
  FTP.Login();
end;

procedure TFrmPrincipal.DesconectarFTP;
begin
  FTP.Disconnect();
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  Self.CarregarConfig();
  Self.ConfigurarFTP();
end;

function TFrmPrincipal.FTPFileExists(AFileName : String): Boolean;
begin
  try
    FTP.List(nil, aFileName, True);
    Result:= (FTP.ListResult.Count > 0);
  except
    Result := False;
  end;
end;

procedure TFrmPrincipal.TestarConexao;
begin
  FTP.Disconnect();
  try
    FTP.Connect();
    FTP.Login();
    ShowMessage('FTP conectado!');
  except
    ShowMessage('Conexão com FTP falhou!');
  end;
end;

procedure TFrmPrincipal.Upar;
begin
  //Self.ValidarTicket();
  Self.ConectarFTP();
  FTP.ChangeDir(EditPasta.Text);
  try
    FTP.ChangeDir(EditTicket.Text);
  except
    on E: Exception do
    begin
      Self.ConectarFTP();
      FTP.ChangeDir(EditPasta.Text);
      FTP.MakeDir(EditTicket.Text);
      FTP.ChangeDir(EditTicket.Text);
    end;
  end;
  try
    FTP.TransferType:= ftBinary;
    if CheckBoxERP.Checked then
    begin
      StaticTextStatus.Caption := 'ERP';
      Application.ProcessMessages();
      FTP.Put(ExtractFileDir(ParamStr(0))+'\'+cERPZIP, cERPZip, False);
    end;
    if CheckBoxTopServerService.Checked then
    begin
      StaticTextStatus.Caption := 'TopServerService';
      Application.ProcessMessages();
      FTP.Put(ExtractFileDir(ParamStr(0))+'\'+cTopServerServiceZip, cTopServerServiceZip, False);
    end;
    if CheckBoxServerERP.Checked then
    begin
      StaticTextStatus.Caption := 'ServerERP';
      Application.ProcessMessages();
      FTP.Put(ExtractFileDir(ParamStr(0))+'\'+cServerERPZIP, cServerERPZip, False);
    end;
  finally
    Self.DesconectarFTP();
  end;
end;

procedure TFrmPrincipal.ValidarTicket;
begin
  if EditTicket.Text = EmptyStr then
    raise Exception.Create('Informar número do ticket');
end;

end.
