object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 446
  ClientWidth = 803
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LabelArquivoSelecionado: TLabel
    Left = 136
    Top = 24
    Width = 3
    Height = 13
  end
  object LabelPercentual: TLabel
    Left = 208
    Top = 176
    Width = 3
    Height = 13
  end
  object LabelSelecionarDescompactar: TLabel
    Left = 392
    Top = 240
    Width = 3
    Height = 13
  end
  object LabelTesteCor: TLabel
    Left = 256
    Top = 384
    Width = 195
    Height = 13
    Caption = 'LabelTesteCorcororcorosdofsdogfdfgdfg'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object ButtonCompactar: TButton
    Left = 144
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Compactar'
    TabOrder = 0
    OnClick = ButtonCompactarClick
  end
  object ButtonSelecionarArquivo: TButton
    Left = 63
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Selecionar'
    TabOrder = 1
    OnClick = ButtonSelecionarArquivoClick
  end
  object ButtonDescompactar: TButton
    Left = 225
    Top = 96
    Width = 88
    Height = 25
    Caption = 'Descompactar'
    TabOrder = 2
    OnClick = ButtonDescompactarClick
  end
  object Button1: TButton
    Left = 96
    Top = 145
    Width = 123
    Height = 25
    Caption = 'Compactar Teste'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 225
    Top = 145
    Width = 128
    Height = 25
    Caption = 'Descompactar Teste'
    TabOrder = 4
    OnClick = Button2Click
  end
  object ButtonSelecionarDescompactar: TButton
    Left = 319
    Top = 96
    Width = 146
    Height = 25
    Caption = 'Selecionar Descompactar'
    TabOrder = 5
    OnClick = ButtonSelecionarDescompactarClick
  end
  object Button3: TButton
    Left = 560
    Top = 344
    Width = 113
    Height = 25
    Caption = 'muda cor navy'
    TabOrder = 6
    OnClick = Button3Click
  end
  object ButtonCompactar7zip: TButton
    Left = 112
    Top = 224
    Width = 129
    Height = 25
    Caption = 'Compactar 7Zip'
    TabOrder = 7
    OnClick = ButtonCompactar7zipClick
  end
  object OpenDialogArquivo: TOpenDialog
    Left = 48
    Top = 32
  end
end
