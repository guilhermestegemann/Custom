unit UFormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Zip;

type
  TForm1 = class(TForm)
    OpenDialogArquivo: TOpenDialog;
    LabelArquivoSelecionado: TLabel;
    ButtonCompactar: TButton;
    ButtonSelecionarArquivo: TButton;
    LabelPercentual: TLabel;
    ButtonDescompactar: TButton;
    Button1: TButton;
    Button2: TButton;
    ButtonSelecionarDescompactar: TButton;
    LabelSelecionarDescompactar: TLabel;
    LabelTesteCor: TLabel;
    Button3: TButton;
    ButtonCompactar7zip: TButton;
    procedure ButtonSelecionarArquivoClick(Sender: TObject);
    procedure ButtonCompactarClick(Sender: TObject);
    procedure ButtonDescompactarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ButtonSelecionarDescompactarClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ButtonCompactar7zipClick(Sender: TObject);
    function GetComando() : String;
  private
    procedure EventoOnProgress(Sender: TObject; FileName: string; Header: TZipHeader; Position: Int64);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.ZLib, System.UITypes;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  LInput, LOutput: TFileStream;
  LZip: TZCompressionStream;
begin
  { Create the Input, Output, and Compressed streams. }
  LInput := TFileStream.Create(LabelArquivoSelecionado.Caption, fmOpenRead);
  LOutput := TFileStream.Create(GetCurrentDir + '\teste.zip', fmCreate);
  LZip := TZCompressionStream.Create(clDefault, LOutput);
  try
    { Compress data. }
    LZip.CopyFrom(LInput, LInput.Size);
  finally
    { Free the streams. }
    LZip.Free;
    LInput.Free;
    LOutput.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  LInput, LOutput: TFileStream;
  LUnZip: TZDecompressionStream;
begin
  { Create the Input, Output, and Decompressed streams. }
  LInput := TFileStream.Create(LabelSelecionarDescompactar.Caption, fmOpenRead);
  LOutput := TFileStream.Create(GetCurrentDir + '\teste.fdb', fmCreate);
  LUnZip := TZDecompressionStream.Create(LInput);

  { Decompress data. }
  LOutput.CopyFrom(LUnZip, 0);

  { Free the streams. }
  LUnZip.Free;
  LInput.Free;
  LOutput.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  LabelTesteCor.Font.Color := TColorRec.Navy;
end;

procedure TForm1.ButtonSelecionarDescompactarClick(Sender: TObject);
begin
  if OpenDialogArquivo.Execute then
    LabelSelecionarDescompactar.Caption := OpenDialogArquivo.FileName;
end;

procedure TForm1.ButtonCompactar7zipClick(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(Self.GetComando())),SW_NORMAL);
end;

procedure TForm1.ButtonCompactarClick(Sender: TObject);
var
  ZipFile : TZipFile;
begin
  if LabelArquivoSelecionado.Caption <> '' then
  begin
    ZipFile := TZipFile.Create();
    try
      ZipFile.OnProgress := EventoOnProgress;
      ZipFile.Open(GetCurrentDir + '\ArquivoCompactado.zip', zmWrite);
      ZipFile.Add(LabelArquivoSelecionado.Caption);
      MessageDlg('Compactação concluída!', mtInformation, [mbOK], 0);
    finally
      ZipFile.Free();
    end;
  end;
end;

procedure TForm1.ButtonDescompactarClick(Sender: TObject);
var
  UnZipper: TZipFile;
begin
  UnZipper := TZipFile.Create();
  try
    UnZipper.Open(LabelArquivoSelecionado.Caption, zmRead);
    UnZipper.ExtractAll(GetCurrentDir);
    UnZipper.Close;
  finally
    FreeAndNil(UnZipper);
  end;
end;

procedure TForm1.ButtonSelecionarArquivoClick(Sender: TObject);
begin
  if OpenDialogArquivo.Execute then
    LabelArquivoSelecionado.Caption := OpenDialogArquivo.FileName;
end;

procedure TForm1.EventoOnProgress(Sender: TObject; FileName: string; Header: TZipHeader; Position: Int64);
begin
  Application.ProcessMessages;
  // Exibe a porcentagem de compactação do arquivo
  LabelPercentual.Caption := FormatFloat('#.## %', Position / Header.UncompressedSize * 100);
end;

function TForm1.GetComando: String;
begin
  Result := ExtractFilePath(ParamStr(0)) + '7z.exe a -t7z ';
  Result := Result + ExtractFilePath(ParamStr(0)) + 'teste.zip ';
  Result := Result + LabelArquivoSelecionado.Caption;
end;

end.
