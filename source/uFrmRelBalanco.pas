unit uFrmRelBalanco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmRelPadrao, StdCtrls, Buttons, ExtCtrls, Mask, ToolEdit,
  Grids, DBGrids, DB, ppDB, ppDBPipe, ppComm, ppRelatv, ppProd, ppClass,
  ppReport, ppCtrls, ppVar, ppPrnabl, ppBands, ppCache, ppStrtch, ppMemo,
  DBCtrls;

type
  TfrmRelBalanco = class(TfrmRelPadrao)
    Label21: TLabel;
    cmbLojas3: TComboBox;
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    edtDTINIC: TDateEdit;
    edtDTFINA: TDateEdit;
    Label3: TLabel;
    Panel3: TPanel;
    dsDados: TDataSource;
    ppReport1: TppReport;
    ppDBPipeline1: TppDBPipeline;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppLine1: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLine2: TppLine;
    ppLabel1: TppLabel;
    lblPeriodo: TppLabel;
    lblFantasia: TppLabel;
    lblRazao: TppLabel;
    lblEndereco: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel9: TppLabel;
    ppLabel11: TppLabel;
    ppMemo1: TppMemo;
    BitBtn1: TBitBtn;
    ppDBText7: TppDBText;
    ppMemo2: TppMemo;
    ppMemo3: TppMemo;
    ppShape1: TppShape;
    ppLabel10: TppLabel;
    lblReg: TLabel;
    ppSummaryBand1: TppSummaryBand;
    ppLine6: TppLine;
    ppLabel12: TppLabel;
    ppDBCalc1: TppDBCalc;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    rgProdutos: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure edtDTINICExit(Sender: TObject);
    procedure edtDTFINAExit(Sender: TObject);
    procedure btnVisualizarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure dsDadosDataChange(Sender: TObject; Field: TField);
    procedure edtDTINICEnter(Sender: TObject);
    procedure edtDTFINAEnter(Sender: TObject);
    procedure cmbLojas3Enter(Sender: TObject);
    procedure edtDTINICKeyPress(Sender: TObject; var Key: Char);
    procedure edtDTFINAKeyPress(Sender: TObject; var Key: Char);
    procedure cmbLojas3KeyPress(Sender: TObject; var Key: Char);
    procedure rgProdutosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelBalanco: TfrmRelBalanco;

implementation

uses udmDados, udmPesquisa, uFuncoes;

{$R *.dfm}

procedure TfrmRelBalanco.FormShow(Sender: TObject);
begin
  inherited;
        dmPesquisa.cdsProdutosEstoque.Close;
        //
        dmDados.CarregarLojas(cmbLojas3);
        //
        btnVisualizar.Enabled := fALSE;
end;

procedure TfrmRelBalanco.edtDTINICExit(Sender: TObject);
begin
  inherited;
    dmDados.RefreshCDS(dmDados.cdsConfig);
    //
    If not uFuncoes.Empty(uFuncoes.RemoveChar(edtDTINIC.Text)) Then
    Begin
        try
            StrToDate(edtDTINIC.Text);
            edtDTINIC.Date := StrToDate(edtDTINIC.Text);
            //
            If (edtDTINIC.Date <= dmDados.cdsConfigCFG_DTINVENTARIO.AsDateTime) Then
            begin
                 Application.MessageBox(PChar('Data n�o pode ser inferior ou igual '
                                         +#13+'a data do fechamento do Invent�rio na anvisa: '+dmDados.cdsConfigCFG_DTINVENTARIO.AsString),'ATEN��O',
                      MB_OK+MB_ICONEXCLAMATION+MB_APPLMODAL);
                 edtDTINIC.SetFocus;
                 Exit;
            End;
            //
        except
          on EConvertError do
          Begin
               ShowMessage ('Data Inv�lida!');
               edtDTINIC.SetFocus;
               Exit;
          End;
        end;
    End;
end;

procedure TfrmRelBalanco.edtDTFINAExit(Sender: TObject);
begin
  inherited;
   If not uFuncoes.Empty(uFuncoes.RemoveChar(edtDTFINA.Text)) Then
    Begin
        try
            StrToDate(edtDTFINA.Text);
            edtDTFINA.Date := StrToDate(edtDTFINA.Text);
            //
            If (edtDTFINA.Date < edtDTINIC.Date) Then
              begin
                   Application.MessageBox(PChar('Data n�o pode ser inferior a data inicial.'),'ATEN��O',
                      MB_OK+MB_ICONEXCLAMATION+MB_APPLMODAL);
                   edtDTFINA.SetFocus;
                   Exit;
              End;
              //
            If (edtDTFINA.Date <= dmDados.cdsConfigCFG_DTINVENTARIO.AsDateTime) Then
            begin
                 Application.MessageBox(PChar('Data n�o pode ser inferior ou igual '
                                         +#13+'a data do fechamento do Invent�rio na anvisa: '+dmDados.cdsConfigCFG_DTINVENTARIO.AsString),'ATEN��O',
                      MB_OK+MB_ICONEXCLAMATION+MB_APPLMODAL);
                 edtDTFINA.SetFocus;
                 Exit;
            End;
        except
          on EConvertError do
          Begin
               ShowMessage ('Data Inv�lida!');
               edtDTFINA.SetFocus;
               Exit;
          End;
        end;
    End;
end;

procedure TfrmRelBalanco.btnVisualizarClick(Sender: TObject);
Var
   iLoja : Integer;
begin
  inherited;
      //
      If not (dmPesquisa.cdsProdutosEstoque.IsEmpty) Then
       begin
            //
            With ppReport1 do
              begin
                   lblPeriodo.Caption  := 'PER�ODO : ' + edtDTINIC.Text + ' � ' + edtDTFINA.Text;
                   iLoja := dmDados.GetCodigoLoja(cmbLojas3.Text);
                   dmDados.FilterCDS(dmDados.cdsLojas, fsInteger, InttoStr(iLoja));
                   //
                   If not (dmDados.cdsLojas.IsEmpty) Then
                   begin
                       lblFantasia.Caption := 'NOME FANTASIA : '+ dmDados.cdsLojasEMP_FANTASIA.AsString;
                       lblRazao.Caption    := 'RAZ�O SOCIAL  : '+ dmDados.cdsLojasEMP_RAZAO.AsString;
                       lblEndereco.Caption := 'ENDERE�O : '+ dmDados.cdsLojasEMP_ENDERECO.AsString + ', '+ dmDados.cdsLojasEMP_NUMERO.AsString+' - '+
                                                                  dmDados.cdsLojasEMP_BAIRRO.AsString + ' - '+dmDados.cdsLojasEMP_CIDADE.AsString +'/'+dmDados.cdsLojasEMP_UFEMPR.AsString;
                       //'CNPJ : '+ uFuncoes.FormataCNPJ(dmDados.cdsLojasEMP_CNPJ.AsString);
                   End;
                   //
                   PrintReport;
              End;
       End;
end;

procedure TfrmRelBalanco.BitBtn1Click(Sender: TObject);
Var
   iLoja, iOrdem : Integer;
   aOpcao : String;
begin
  inherited;
      if uFuncoes.Empty(cmbLojas3.Text) Then
       begin
            cmbLojas3.SetFocus;
            Exit;
       End;
      if uFuncoes.Empty(uFuncoes.RemoveChar(edtDTINIC.Text)) Then
       begin
            edtDTINIC.SetFocus;
            Exit;
       End;
       //
      if uFuncoes.Empty(uFuncoes.RemoveChar(edtDTFINA.Text)) Then
       begin
            edtDTFINA.SetFocus;
            Exit;
       End;
       //
      iLoja := dmDados.GetCodigoLoja(cmbLojas3.Text);
      if (RadioGroup1.ItemIndex = 0) Then
          iOrdem := 1
      Else
          iOrdem := 2;
      //
      Case rgProdutos.ItemIndex of
         0 : aOpcao := 'S';
         1 : aOpcao := 'N';
         2 : aOpcao := 'T';
      End;
      //
      udmPesquisa.iLoja := iLoja;
      udmPesquisa.aDtInicial := edtDTINIC.Date;
      udmPesquisa.aDtFinal   := edtDTFINA.Date;
      //
      lblReg.Caption := 'Mensagem: Aguarde consultando dados...';
      BitBtn1.Enabled := False;
      Application.ProcessMessages;
      try
          Screen.Cursor := crHourGlass;
          dmPesquisa.GeraBalancoCalculado(iLoja, iOrdem, edtDTINIC.Date, edtDTFINA.Date, aOpcao);
          If not (dmPesquisa.cdsBalancoProdutos.IsEmpty) Then
              dmPesquisa.cdsBalancoProdutos.First;
      Finally
          Screen.Cursor := crDefault;
          BitBtn1.Enabled := true;
      End;
      Application.ProcessMessages;
end;

procedure TfrmRelBalanco.dsDadosDataChange(Sender: TObject; Field: TField);
begin
  inherited;
    btnVisualizar.Enabled := (dsDados.DataSet.Active) AND NOT (dsDados.DataSet.IsEmpty) ;
    //
    if not (dsDados.DataSet.IsEmpty) Then
      lblReg.Caption := 'Registro: ' + InttoStr(dsDados.DataSet.RecNo)+'/'+InttoStr(dsDados.DataSet.RecordCount)
    Else
      lblReg.Caption := 'Registro:'
end;

procedure TfrmRelBalanco.edtDTINICEnter(Sender: TObject);
begin
  inherited;
     dmPesquisa.cdsBalancoProdutos.Close;
end;

procedure TfrmRelBalanco.edtDTFINAEnter(Sender: TObject);
begin
  inherited;
    dmPesquisa.cdsBalancoProdutos.Close;
end;

procedure TfrmRelBalanco.cmbLojas3Enter(Sender: TObject);
begin
  inherited;
    dmPesquisa.cdsBalancoProdutos.Close;
end;

procedure TfrmRelBalanco.edtDTINICKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
      if (key = #13) and not uFuncoes.Empty(uFuncoes.RemoveChar(edtDTINIC.Text)) Then
      begin
           key := #0;
           edtDTFINA.SetFocus;
      End;
end;

procedure TfrmRelBalanco.edtDTFINAKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if (key = #13) and not uFuncoes.Empty(uFuncoes.RemoveChar(edtDTFINA.Text)) Then
      begin
           key := #0;
           RadioGroup1.SetFocus;
      End;
end;

procedure TfrmRelBalanco.cmbLojas3KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (key = #13) and not uFuncoes.Empty(cmbLojas3.Text) Then
      begin
           key := #0;
           edtDTINIC.SetFocus;
      End;
end;

procedure TfrmRelBalanco.rgProdutosClick(Sender: TObject);
begin
  inherited;
      dsDados.DataSet.Close;
end;

end.
