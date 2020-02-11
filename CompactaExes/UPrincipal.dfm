object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Compacta Exe'
  ClientHeight = 381
  ClientWidth = 455
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonCompacta: TButton
    Left = 159
    Top = 22
    Width = 90
    Height = 325
    Caption = 'Compactar'
    TabOrder = 0
    OnClick = ButtonCompactaClick
  end
  object EditHost: TLabeledEdit
    Left = 8
    Top = 24
    Width = 145
    Height = 21
    EditLabel.Width = 22
    EditLabel.Height = 13
    EditLabel.Caption = 'Host'
    TabOrder = 1
  end
  object EditUsuario: TLabeledEdit
    Left = 8
    Top = 72
    Width = 145
    Height = 21
    EditLabel.Width = 36
    EditLabel.Height = 13
    EditLabel.Caption = 'Usu'#225'rio'
    TabOrder = 2
  end
  object EditSenha: TLabeledEdit
    Left = 8
    Top = 120
    Width = 145
    Height = 21
    EditLabel.Width = 30
    EditLabel.Height = 13
    EditLabel.Caption = 'Senha'
    PasswordChar = '*'
    TabOrder = 3
  end
  object EditPasta: TLabeledEdit
    Left = 8
    Top = 160
    Width = 145
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Pasta'
    TabOrder = 4
  end
  object EditTicket: TLabeledEdit
    Left = 8
    Top = 200
    Width = 145
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Ticket'
    TabOrder = 5
  end
  object ButtonSalvarConfig: TButton
    Left = 8
    Top = 322
    Width = 145
    Height = 25
    Caption = 'Salvar Config'
    TabOrder = 6
    OnClick = ButtonSalvarConfigClick
  end
  object CheckBoxERP: TCheckBox
    Left = 8
    Top = 240
    Width = 145
    Height = 17
    Caption = 'ERP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object CheckBoxTopServerService: TCheckBox
    Left = 8
    Top = 266
    Width = 145
    Height = 17
    Caption = 'TopServerService'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
  end
  object CheckBoxServerERP: TCheckBox
    Left = 8
    Top = 289
    Width = 145
    Height = 17
    Caption = 'ServerERP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
  end
  object ButtonTestarConexao: TButton
    Left = 8
    Top = 353
    Width = 145
    Height = 25
    Caption = 'Testar Conex'#227'o'
    TabOrder = 10
    OnClick = ButtonTestarConexaoClick
  end
  object ButtonUpar: TButton
    Left = 255
    Top = 22
    Width = 90
    Height = 325
    Caption = 'Upar'
    TabOrder = 11
    OnClick = ButtonUparClick
  end
  object ButtonCompactarUpar: TButton
    Left = 351
    Top = 22
    Width = 90
    Height = 325
    Caption = 'Compactar/Upar'
    TabOrder = 12
    OnClick = ButtonCompactarUparClick
  end
  object StaticTextStatus: TStaticText
    Left = 160
    Top = 352
    Width = 281
    Height = 26
    Alignment = taCenter
    AutoSize = False
    BorderStyle = sbsSingle
    TabOrder = 13
  end
  object FTP: TIdFTP
    IPVersion = Id_IPv4
    ConnectTimeout = 0
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 360
    Top = 304
  end
end
