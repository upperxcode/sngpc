inherited frmLocProdutoEstoque: TfrmLocProdutoEstoque
  Caption = 'Localiza Medicamento'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited rgConsultar: TRadioGroup
      Items.Strings = (
        'C'#243'digo MS'
        'Nome/Descri'#231#227'o')
    end
    inherited btnConsultar: TBitBtn
      OnClick = btnConsultarClick
    end
  end
  inherited Panel1: TPanel
    inherited grdConsultar: TDBGrid
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'PRO_RG_MS_MEDICAMENTO'
          Title.Alignment = taCenter
          Title.Caption = 'C'#211'DIGO MS'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Verdana'
          Title.Font.Style = [fsBold]
          Width = 99
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_MEDICAMENTO'
          Title.Caption = 'DESCRI'#199#195'O'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Verdana'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANT'
          Title.Alignment = taRightJustify
          Title.Caption = 'ESTOQUE'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Verdana'
          Title.Font.Style = [fsBold]
          Width = 81
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EST_CDLOJA'
          Visible = False
        end>
    end
  end
  inherited datasetConsultar: TSQLDataSet
    CommandText = 
      'select P.PRO_RG_MS_MEDICAMENTO, P.PRO_MEDICAMENTO, E.est_cdloja,' +
      ' Sum(E.est_quantidade) as QUANT'#13#10'from PRODUTOS P'#13#10'Inner Join EST' +
      'OQUE E on P.pro_rg_ms_medicamento = E.est_cdprod'#13#10'Group by P.PRO' +
      '_RG_MS_MEDICAMENTO, P.PRO_MEDICAMENTO, E.est_cdloja'#13#10'order by P.' +
      'PRO_MEDICAMENTO'
  end
  inherited cdsConsultar: TClientDataSet
    object cdsConsultarPRO_RG_MS_MEDICAMENTO: TStringField
      FieldName = 'PRO_RG_MS_MEDICAMENTO'
      Required = True
      EditMask = '9.9999.9999.999-9;0;_'
      FixedChar = True
      Size = 13
    end
    object cdsConsultarPRO_MEDICAMENTO: TStringField
      FieldName = 'PRO_MEDICAMENTO'
      Required = True
      Size = 50
    end
    object cdsConsultarEST_CDLOJA: TIntegerField
      FieldName = 'EST_CDLOJA'
      Required = True
    end
    object cdsConsultarQUANT: TFMTBCDField
      FieldName = 'QUANT'
      ReadOnly = True
      Precision = 18
      Size = 3
    end
  end
end
