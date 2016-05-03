object frmLocalizaPadrao: TfrmLocalizaPadrao
  Left = 189
  Top = 152
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 323
  ClientWidth = 574
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 574
    Height = 59
    Align = alTop
    TabOrder = 0
    object lblConsultar: TLabel
      Left = 136
      Top = 5
      Width = 84
      Height = 13
      Caption = 'Nome/Descri'#231#227'o:'
    end
    object rgConsultar: TRadioGroup
      Left = 4
      Top = 1
      Width = 127
      Height = 55
      Caption = 'Consultar por:'
      ItemIndex = 1
      Items.Strings = (
        'C'#243'digo'
        'Nome/Descri'#231#227'o')
      TabOrder = 0
      OnClick = rgConsultarClick
    end
    object edtConsultar: TEdit
      Left = 135
      Top = 21
      Width = 330
      Height = 19
      CharCase = ecUpperCase
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      OnChange = edtConsultarChange
      OnKeyDown = edtConsultarKeyDown
      OnKeyPress = edtConsultarKeyPress
    end
    object btnConsultar: TBitBtn
      Left = 472
      Top = 17
      Width = 95
      Height = 25
      Hint = 'Ver registro'
      Caption = '&Ver Registro'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
  object Panel3: TPanel
    Left = 540
    Top = 59
    Width = 34
    Height = 264
    Align = alRight
    TabOrder = 1
    object sbProximo: TSpeedButton
      Left = 5
      Top = 83
      Width = 25
      Height = 35
      Hint = 'Pr'#243'ximo registro'
      Enabled = False
      Flat = True
      Glyph.Data = {
        76060000424D7606000000000000360400002800000018000000180000000100
        0800000000004002000000000000000000000001000000000000FFFFFF00FFE6
        E600FEE5E500FCE3E300FBE1E100F9DFE000F7DDDE00F7DDDD00F5DBDB00F4DB
        DB00F2D9D900E6D9D900F0D6D700EED4D400EBD2D200E9D0D000E9CFD000E7CD
        CD00E5CBCB00E3C9C900E0C7C700DEC4C400DCC2C200CCC0C000D9C0BF00D7BE
        BD00D4BBBB00D3B9B900D0B7B700CFB5B500CEB4B400CCB3B300C9B0B000C7AE
        AE00C5ACAC00C3AAAA00C1A8A800C1A7A700BFA5A500BDA3A300BCA3A300BAA0
        A100BAA1A000B89E9E00B59C9C00B39A9A00AF969600AD949400A88F8F00A68D
        8D00A18888009F8686009B8382009A818100998080006633330000000000C0C0
        C000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000393939393939
        3939393939393939393939393939393939393939393939393939393939393939
        3939393939393939393939393939393939393939393939393939393939393939
        3939393939393939393939393939393939393939393939393939393939393939
        3939393939393939393939393939393939393939393939393939393939003939
        3939393939393939393939393939393939393939000037393939393939393939
        39393939393939393939390000370D3839393939393939393939393939393939
        39390000370D260D383939393939393939393939393939393900003706260D2E
        1138393939393939393939393939393900003706260D2C112E15383939393939
        3939393939393900003705210D2B112E15311938393939393939393939390000
        3706210D261038143019331D383939393939393939000037012106260D383938
        18331D331D38393939393939000037012106260D3839393938193321331D3839
        393939393937011D05250C3839393939393821331D170B383939393939393801
        25063839393939393939381D170B383939393939393939380638393939393939
        393939380B383939393939393939393938393939393939393939393938393939
        3939393939393939393939393939393939393939393939393939393939393939
        3939393939393939393939393939393939393939393939393939393939393939
        3939393939393939393939393939393939393939393939393939393939393939
        3939393939393939393939393939393939393939393939393939}
      ParentShowHint = False
      ShowHint = True
      OnClick = sbProximoClick
    end
    object sbUltimo: TSpeedButton
      Left = 5
      Top = 122
      Width = 25
      Height = 35
      Hint = #218'ltimo registro'
      Enabled = False
      Flat = True
      Glyph.Data = {
        96010000424D9601000000000000760000002800000018000000180000000100
        0400000000002001000000000000000000001000000000000000FFFFFF006130
        30006E3D3D00916161009E6E6E00C2919100CF9E9E00C0C0C000000000000000
        0000000000000000000000000000000000000000000000000000777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777777777777777777777777777077777777777777777777770027777777
        7777777777777002327777777777777777770023432777777777777777700234
        3432777777777777770023434343277777777777700234343434327777777777
        0025656565656547777777700256565656565654777777772121212121212121
        2777777777777777777777777777777000000000000000007777777034343434
        3434343617777770456565656565656527777770365656565656565617777770
        4565656565656565277777771212121212121212177777777777777777777777
        7777777777777777777777777777777777777777777777777777}
      ParentShowHint = False
      ShowHint = True
      OnClick = sbUltimoClick
    end
    object sbAnterior: TSpeedButton
      Left = 5
      Top = 44
      Width = 25
      Height = 35
      Hint = 'Registro anterior'
      Enabled = False
      Flat = True
      Glyph.Data = {
        76060000424D7606000000000000360400002800000018000000180000000100
        0800000000004002000000000000000000000001000000000000FFFFFF00FEE5
        E400FDE3E300FBE1E100F9DFE000F7DEDD00F4DBDB00F2D9D900E6D9D900F0D7
        D700EED4D400EBD2D200E9CFCF00E7CECD00E5CBCB00E3C9C900E0C6C700DEC4
        C500DBC2C200D9C0C000CDC0C000CCC0C000D7BDBD00D5BBBB00D3B9B900D1B7
        B700CFB6B500CFB5B500CDB4B400CCB3B300C7AEAE00C6ACAC00C1A8A800BFA6
        A600BAA0A100B89E9E00B39A9A00B1989800AD949400AA919100A68D8D00A38A
        8A009F8686009D8484009C8283009A818100998080006633330000000000C0C0
        C000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000313131313131
        3131313131313131313131313131313131313131313131313131313131313131
        3131313131313131313131313131313131313131313131313131313131313131
        3131313131313131313131313131313131313131313131313131313131313131
        3131313131313131313131313131313131313131313131003131313131313131
        313131003131313131313131313100002F31313131313131313100002F313131
        313131313100002F01303131313131313100002F1A3031313131313100002F01
        1E0530313131313100002F1A2A1A303131313131312F011E05210A3031313100
        002F1E2A1A1408303131313131313004210A230D303100002F1E2A1A14083031
        313131313131313005210D241130002F1A2A1A16083031313131313131313131
        300A240D26162F1A2A1A140830313131313131313131313131300D2611281A2A
        1A1408303131313131313131313131313131301128162A1A1408303131313131
        313131313131313131313130162A1A1408303131313131313131313131313131
        3131313130191408303131313131313131313131313131313131313131300830
        3131313131313131313131313131313131313131313130313131313131313131
        3131313131313131313131313131313131313131313131313131313131313131
        3131313131313131313131313131313131313131313131313131313131313131
        3131313131313131313131313131313131313131313131313131313131313131
        3131313131313131313131313131313131313131313131313131}
      ParentShowHint = False
      ShowHint = True
      OnClick = sbAnteriorClick
    end
    object sbPrimeiro: TSpeedButton
      Left = 5
      Top = 6
      Width = 25
      Height = 35
      Hint = 'Primeiro registro'
      Enabled = False
      Flat = True
      Glyph.Data = {
        96010000424D9601000000000000760000002800000018000000180000000100
        0400000000002001000000000000000000001000000000000000FFFFFF006130
        30006E3D3D00916161009E6E6E00C2919100CF9E9E00C0C0C000000000000000
        0000000000000000000000000000000000000000000000000000777777777777
        7777777777777777777777777777777777777777777777777777777777777770
        0000000000000000777777703434343434343436177777704565656565656565
        2777777036565656565656561777777045656565656565652777777712121212
        1212121217777777777777777777777777777777777777777777777777777770
        0000000000000000777777771212121212121212177777777143434343434341
        7777777777143434343656177777777777714343436561777777777777771434
        3656177777777777777771436561777777777777777777165617777777777777
        7777777161777777777777777777777717777777777777777777777777777777
        7777777777777777777777777777777777777777777777777777}
      ParentShowHint = False
      ShowHint = True
      OnClick = sbPrimeiroClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 59
    Width = 540
    Height = 264
    Align = alClient
    TabOrder = 2
    object grdConsultar: TDBGrid
      Left = 1
      Top = 1
      Width = 538
      Height = 262
      Align = alClient
      Ctl3D = False
      DataSource = dsConsultar
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = grdConsultarDblClick
    end
  end
  object dsConsultar: TDataSource
    DataSet = cdsConsultar
    OnDataChange = dsConsultarDataChange
    Left = 164
    Top = 194
  end
  object datasetConsultar: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmDados.sqlSNGPN
    Left = 244
    Top = 194
  end
  object dspConsultar: TDataSetProvider
    DataSet = datasetConsultar
    Options = [poAllowCommandText]
    Left = 316
    Top = 194
  end
  object cdsConsultar: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsultar'
    Left = 372
    Top = 194
  end
end