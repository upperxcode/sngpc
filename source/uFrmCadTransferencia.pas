unit uFrmCadTransferencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCadastro, FMTBcd, DBClient, Provider, DB, SqlExpr, jpeg,
  ExtCtrls, Buttons, Grids, DBGrids, StdCtrls, ComCtrls, Mask, DBCtrls,
  ToolEdit, RXDBCtrl, CurrEdit;

type
  TFrmCadTransferencia = class(TfrmCadastro)
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    grdProdutos: TDBGrid;
    Label1: TLabel;
    dbeCodigo: TDBEdit;
    Label2: TLabel;
    dbeCNPJOrigem: TDBEdit;
    Label3: TLabel;
    dbeNumeroNota: TDBEdit;
    Label6: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    dbeDataNota: TDBDateEdit;
    dbeDataTransferencia: TDBDateEdit;
    dbeCNPJDestino: TDBEdit;
    edtNomeLoja: TEdit;
    dsProdutos: TDataSource;
    Label16: TLabel;
    edtCDPROD: TEdit;
    edtNMDESC: TEdit;
    spLocalizar: TSpeedButton;
    Label17: TLabel;
    edtNRLOTE: TEdit;
    Label19: TLabel;
    edtQuantidade: TCurrencyEdit;
    procedure BtCancelarClick(Sender: TObject);
    procedure BtGravarClick(Sender: TObject);
    procedure BtAdicionarClick(Sender: TObject);
    procedure dbeCNPJDestinoExit(Sender: TObject);
    procedure dbeDataNotaExit(Sender: TObject);
    procedure spLocalizarClick(Sender: TObject);
    procedure edtCDPRODExit(Sender: TObject);
    procedure edtCDPRODKeyPress(Sender: TObject; var Key: Char);
    procedure edtCDPRODEnter(Sender: TObject);
    procedure edtQuantidadeEnter(Sender: TObject);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNRLOTEExit(Sender: TObject);
    procedure BtExcluirExit(Sender: TObject);
    procedure BtExcluirClick(Sender: TObject);
    procedure dsProdutosDataChange(Sender: TObject; Field: TField);
    procedure edtNRLOTEKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure Limpar_Itens;
    procedure MOSTRA;
  public
    { Public declarations }
  end;

var
  FrmCadTransferencia: TFrmCadTransferencia;

implementation

uses udmDados, uFuncoes, ufrmLocProduto, uFormMainSngpc, uFrmCadProdutos;

{$R *.dfm}

procedure TFrmCadTransferencia.BtCancelarClick(Sender: TObject);
begin
      dsCadastro.DataSet.Cancel;
      Limpar_Itens;
      dmDados.cdsDados.EmptyDataSet;
  inherited;
      TabSheet2.TabVisible := False;
end;

procedure TFrmCadTransferencia.BtGravarClick(Sender: TObject);
Var
    iLoja, idLojaDestino : Integer;
begin
     If uFuncoes.Empty(dbeNumeroNota.Text) Then
     begin
           Application.MessageBox('Digite o n�mero da nota.','ATEN��O',
               MB_OK+MB_ICONEXCLAMATION+MB_APPLMODAL);
           dbeNumeroNota.SetFocus;
           Exit;
     End;
     //
     If uFuncoes.Empty(uFuncoes.RemoveChar(dbeDataNota.Text)) Then
       Begin
             Application.MessageBox('Digite a data de Emiss�o da nota.','ATEN��O',
               MB_OK+MB_ICONEXCLAMATION+MB_APPLMODAL);
           dbeDataNota.SetFocus;
           Exit;
       End;
     //
     If uFuncoes.Empty(uFuncoes.RemoveChar(dbeCNPJDestino.Text)) Then
       Begin
           Application.MessageBox('Digite o CNPJ de destino.','ATEN��O',
               MB_OK+MB_ICONEXCLAMATION+MB_APPLMODAL);
           dbeCNPJDestino.SetFocus;
           Exit;
       End;
     //
     iLoja := dmDados.cdsTransferenciaID_LOJA.AsInteger;
     idLojaDestino := dmDados.GetIdLojaDestino(dmDados.cdsTransferenciaCNPJ_DESTINO.AsString);
     //
     dmDados.Start;
     try
         if (dsCadastro.DataSet.State = dsInsert) Then
          begin
                dmDados.RefreshCDS(dmDados.cdsConfig);
                dmDados.cdsConfig.Edit;
                dmDados.cdsConfigCFG_TRANSFERENCIA.AsInteger := dmDados.cdsConfigCFG_TRANSFERENCIA.AsInteger + 1;
                dmDados.cdsConfig.Post;
                //
                dmDados.cdsTransferenciaID_TRANSFERENCIA.AsInteger := dmDados.cdsConfigCFG_TRANSFERENCIA.AsInteger;
                dmDados.cdsTransferenciaID_LOJA.AsInteger          := dmDados.cdsConfigCFG_LOJA_PADRAO.AsInteger;
                dmDados.cdsTransferenciaDATA_TRANSFERENCIA.AsDateTime := dmDados.cdsConfigCFG_DATA_ATUAL.AsDateTime;
                dmDados.cdsTransferenciaDATA_CADASTRO.AsDateTime   := Date();
                dmDados.cdsTransferenciaTIPO_OPERACAO.AsInteger    := 2;   // Transferencia
          End;
          //dsCadastro.DataSet.Post;
          dmDados.cdsTransferencia.ApplyUpdates(0);
          // Gravar Itens Transfer�ncia
          if  (dmDados.AdicionarTransferenciaProduto(dmDados.cdsTransferenciaID_TRANSFERENCIA.AsInteger,
                    iLoja, idLojaDestino, dmDados.cdsDados)) Then
            begin
                 //
                 dmDados.cdsConfig.ApplyUpdates(0);
                 //
                 dmDados.Comit(dmDados.Transc);
                 //
                 Application.MessageBox(PChar(MSG_OK), 'Conclu�do', MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
                 //
                 Limpar_Itens;
                 dsCadastro.DataSet.Close;
                 dmDados.cdsDados.Close;
                 //
                 inherited;
                   TabSheet2.TabVisible := False;
            End;
     Except
          if (dmDados.sqlSNGPN.InTransaction) Then
              dmDados.Rollback;
     End;

end;

procedure TFrmCadTransferencia.BtAdicionarClick(Sender: TObject);
Var
   M_NRCNPJ : String;
begin
     // habilitaControles(True);
     edtNomeLoja.Clear;
     dmDados.RefreshCDS(dmDados.cdsConfig);
     dmDados.RefreshCDS(dmDados.cdsListaEmpresa);
     dmDados.RefreshCDS(dmDados.cdsDados);
     dmDados.cdsDados.EmptyDataSet;
     //
     dmDados.FilterCDS(dmDados.cdsTransferencia, fsInteger, '-1');
     With dmDados.cdsTransferencia do
     begin
           Append;
           dmDados.cdsTransferenciaID_TRANSFERENCIA.AsInteger := dmDados.cdsConfigCFG_TRANSFERENCIA.AsInteger + 1;
           dmDados.cdsTransferenciaID_LOJA.AsInteger          := dmDados.cdsConfigCFG_LOJA_PADRAO.AsInteger;
           dmDados.cdsTransferenciaDATA_TRANSFERENCIA.AsDateTime := dmDados.cdsConfigCFG_DATA_ATUAL.AsDateTime;
           dmDados.cdsTransferenciaDATA_CADASTRO.AsDateTime   := Date();
           dmDados.cdsTransferenciaTIPO_OPERACAO.AsInteger    := 2;   // Transferencia
           //
           dmDados.FilterCDS(dmDados.cdsLojas, fsInteger, InttoStr(dmDados.cdsConfigCFG_LOJA_PADRAO.AsInteger));
           If not (dmDados.cdsLojas.IsEmpty) Then
            begin
               M_NRCNPJ := dmDados.cdsLojasEMP_CNPJ.AsString;
               edtNomeLoja.Text := dmDados.cdsLojasEMP_FANTASIA.AsString;
            End
           Else
               M_NRCNPJ := dmDados.cdsConfigCFG_CNPJ.AsString;
           //
           dmDados.cdsTransferenciaCNPJ_ORIGEM.AsString := M_NRCNPJ
     End;
     //
     dbeNumeroNota.SetFocus;
  inherited;    
end;

procedure TFrmCadTransferencia.dbeCNPJDestinoExit(Sender: TObject);
Var
   iLoja, idLojaDestino : integer;
begin
    if (dsCadastro.DataSet.State in [dsInsert, dsEdit]) Then
    begin
         if not (uFuncoes.Empty(ufuncoes.RemoveChar(dbeCNPJDestino.Text))) Then
         begin
             try
               If not (uFuncoes.CGC(uFuncoes.StrZero(dbeCNPJDestino.Text,14))) Then
               Begin
                   Application.MessageBox(PChar('CNPJ inv�lido!!!'),
                      'ATEN��O', MB_OK+MB_ICONWARNING+MB_APPLMODAL);
                   dbeCNPJDestino.Clear;
                   dbeCNPJDestino.SetFocus;
                   Exit;
               End;
             Except
                   dbeCNPJDestino.Clear;
                   dbeCNPJDestino.SetFocus;
                   raise Exception.Create('Erro no CNPJ.');
             End;
             //
             if not uFuncoes.Empty(dbeCNPJDestino.Text) Then
             begin
                If (dbeCNPJOrigem.Text = dbeCNPJDestino.Text) Then
                Begin
                     Application.MessageBox(PChar('CNPJ de destino n�o pode ser igual ao de origem.'),
                        'ATEN��O', MB_OK+MB_ICONWARNING+MB_APPLMODAL);
                     dbeCNPJOrigem.SetFocus;
                     Exit;
                End;
                //
                if dmDados.GetIdLojaDestino(dbeCNPJDestino.Text) = 0 Then
                begin
                     Application.MessageBox(PChar('CNPJ de destino n�o cadastrado.'+#13+'Verifique o cadastro de loja.'),
                        'ATEN��O', MB_OK+MB_ICONWARNING+MB_APPLMODAL);
                     dbeCNPJDestino.SetFocus;
                     Exit;
                End;
                //
                 If (dmDados.VerificarNotaTransferencia(dbeCNPJOrigem.Text,
                    dsCadastro.DataSet.FieldByname('ID_LOJA').AsInteger, StrtoInt(dbeNumeroNota.text))) Then
                 begin
                    Application.MessageBox(PChar('N�mero de nota de tranfer�ncia j� cadastrada '+#13
                       +'para este Fornecedor.'),
                     'ATEN��O', MB_OK+MB_ICONWARNING+MB_APPLMODAL);
                    dbeCNPJDestino.SetFocus;
                    Exit;
                End;
             End;
         End;
    End;
end;

procedure TFrmCadTransferencia.dbeDataNotaExit(Sender: TObject);
begin
     if (dsCadastro.DataSet.State in [dsInsert, dsEdit]) Then
      begin
          If not (uFuncoes.Empty(ufuncoes.RemoveChar(dbeDataNota.Text))) Then
           try
               dbeDataNota.Date := StrToDate(dbeDataNota.Text);
               //
               If (dbeDataNota.Date > dbeDataTransferencia.Date) Then
                 begin
                      dbeDataNota.SetFocus;
                      raise Exception.Create('Data n�o pode ser superior a data movimento.');
                 End;
           except
                 on EConvertError do
                 begin
                     ShowMessage ('Data Inv�lida!');
                     dbeDataNota.SetFocus;
                 End;
           end;
      End;
  inherited;

end;

procedure TFrmCadTransferencia.Limpar_Itens;
begin
     edtCDPROD.Clear;
     edtNMDESC.Clear;
     edtNRLOTE.Clear;
     edtQuantidade.Clear;
end;

procedure TFrmCadTransferencia.spLocalizarClick(Sender: TObject);
begin
  inherited;
    edtCDPROD.SetFocus;
    frmLocProduto := TfrmLocProduto.create(application);
    try
        frmLocProduto.showmodal;
    finally
        If not (frmLocProduto.cdsConsultar.IsEmpty) Then
        begin
            edtCDPROD.Text := frmLocProduto.cdsConsultarPRO_RG_MS_MEDICAMENTO.AsString;
            Perform(WM_NEXTDLGCTL, 0, 0);
            //edtCDPROD.SetFocus;
        End;
        //
        frmLocProduto.Release;
        frmLocProduto := nil;
    end;
end;

procedure TFrmCadTransferencia.edtCDPRODExit(Sender: TObject);
Var
   iLoja : Integer;
   aProduto : String;
begin
     aProduto :=  uFuncoes.StrZero(edtCDPROD.Text,13);
     //
     If not uFuncoes.Empty(edtCDPROD.Text) Then
       If (dmDados.PROCURAR_PRODUTO(uFuncoes.StrZero(edtCDPROD.Text,13))= False)  Then
       begin
            Application.MessageBox('C�digo de produto n�o cadatrado!!!',
               'ATEN��O', MB_OK+MB_ICONEXCLAMATION+MB_APPLMODAL);
            edtCDPROD.Clear;
            edtCDPROD.SetFocus;
            Exit;
       End
       Else
       Begin
            if not (dmDados.GetProdutoNoEstoque(dsCadastro.DataSet.FieldByname('ID_LOJA').AsInteger,
                   edtCDPROD.Text)) Then
            begin
                 Application.MessageBox('N�o h� produto no estoque!!!',
                   'ATEN��O', MB_OK+MB_ICONEXCLAMATION+MB_APPLMODAL);
                 edtCDPROD.Clear;
                 edtCDPROD.SetFocus;
                 Exit;
            End;
            //
            MOSTRA;
            edtNRLOTE.SetFocus;
       End;
  inherited;
end;

procedure TFrmCadTransferencia.MOSTRA;
begin
     edtNMDESC.Text := dmDados.GetNomeProduto(StrZero(edtCDPROD.Text,13));
end;

procedure TFrmCadTransferencia.edtCDPRODKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
 If not( key in['0'..'9',#8, #13] ) then
        key:=#0;
     //
     If (key = #13) and uFuncoes.Empty(edtCDPROD.Text)  Then
     Begin
          Key := #0;
          spLocalizarClick(Sender);
     End;
     //
     If (key = #13) and not uFuncoes.Empty(edtCDPROD.Text)  Then
     Begin
          Key := #0;
          edtNRLOTE.SetFocus;
     End;
end;

procedure TFrmCadTransferencia.edtCDPRODEnter(Sender: TObject);
begin
  inherited;
    if uFuncoes.Empty(uFuncoes.RemoveChar(dbeCNPJDestino.Text)) Then
     begin
          dbeCNPJDestino.SetFocus;
          Exit;
     End;
end;

procedure TFrmCadTransferencia.edtQuantidadeEnter(Sender: TObject);
begin
  inherited;
     if not uFuncoes.Empty(edtCDPROD.Text) and uFuncoes.Empty(edtNRLOTE.Text) Then
      begin
           edtNRLOTE.SetFocus;
           exit;
      End;
end;

procedure TFrmCadTransferencia.edtQuantidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
     if (key = #13) and (edtQuantidade.Value > 0) Then
      begin
           key := #0;
           edtCDPROD.SetFocus;
      End;
end;

procedure TFrmCadTransferencia.edtQuantidadeExit(Sender: TObject);
Var
    iLoja : Integer;
    aProduto, aLote : String;
    fQuantAtual : Double;
begin
  if not uFuncoes.Empty(edtCDPROD.Text) and not uFuncoes.Empty(edtNRLOTE.Text) Then
   begin
      iLoja := dsCadastro.DataSet.fieldByName('ID_LOJA').AsInteger;
      //
      aProduto := edtCDPROD.Text;
      aLote    := uFuncoes.Alltrim(edtNRLOTE.Text);
      //
      fQuantAtual := dmDados.GetEstoqueLoteProduto(iLoja, aProduto, aLote);
      {If (dmDados.GetVerificarQuantEstoque(
          iLoja, aProduto, aLote, edtQuantidade.Value)) Then }
       If (edtQuantidade.Value > fQuantAtual) Then
        begin
             Application.MessageBox('Quantidade digitada superior a do estoque atual.',
                   'ATEN��O', MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
             edtQuantidade.Clear;
             If (edtQuantidade.Enabled) Then
                  edtQuantidade.SetFocus;
              Exit;
        End;
      //
      if not Empty(edtCDPROD.Text) and not Empty(edtNRLOTE.Text)
          and (edtQuantidade.Value > 0) Then
           begin
                if (dmDados.AddItemProduto(edtCDPROD.Text, edtNMDESC.Text, edtNRLOTE.Text, '',edtQuantidade.Value)) then
                begin
                     Limpar_Itens;
                     edtCDPROD.SetFocus;
                End;
           End;
   End;
      //
      {if not Empty(edtCDPROD.Text) and not Empty(edtNRLOTE.Text) and (edtQuantidade.Value > 0) Then
       begin
           Limpar_Itens;
           edtCDPROD.SetFocus;
       End;   }
  inherited;

end;

procedure TFrmCadTransferencia.FormShow(Sender: TObject);
begin
  inherited;
      TabSheet2.TabVisible := False;
end;

procedure TFrmCadTransferencia.edtNRLOTEExit(Sender: TObject);
begin
    if not uFuncoes.Empty (edtCDPROD.Text) and
       not uFuncoes.Empty(edtNRLOTE.Text) Then
     begin
          dmDados.RefreshCDS(dmDados.cdsConfig);
          If (dmDados.cdsConfigCFG_FLZEROS.AsString = 'S') Then
           edtNRLOTE.Text :=  uFuncoes.StrZero(edtNRLOTE.Text,10);
          //
          If not (dmDados.GetProdutoLoteEstoque(dsCadastro.DataSet.FieldbyName('ID_LOJA').AsInteger,
                            edtCDPROD.Text, edtNRLOTE.Text)) Then
           begin
                  Application.MessageBox('Lote n�o existe no estoque.',
                     'ATEN��O', MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
                  edtNRLOTE.Clear;
                  edtNRLOTE.SetFocus;
                  Exit;
           End;
     End;
     //
 inherited;
end;

procedure TFrmCadTransferencia.BtExcluirExit(Sender: TObject);
begin
  inherited;
   if (dsCadastro.DataSet.State in [dsInsert, dsEdit]) Then
    begin
         if not (dmDados.cdsDados.IsEmpty) and (dmDados.cdsDados.RecordCount > 0) Then
             dmDados.cdsDados.Delete;
    End;
end;

procedure TFrmCadTransferencia.BtExcluirClick(Sender: TObject);
begin
  inherited;
   if (dsCadastro.DataSet.State in [dsInsert, dsEdit]) Then
    begin
         if not (dmDados.cdsDados.IsEmpty) and (dmDados.cdsDados.RecordCount > 0) Then
             dmDados.cdsDados.Delete;
    End;
end;

procedure TFrmCadTransferencia.dsProdutosDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
    BtExcluir.Enabled := not (dsProdutos.DataSet.IsEmpty) and (dsProdutos.DataSet.RecordCount > 0);
end;

procedure TFrmCadTransferencia.edtNRLOTEKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
     if (key = #13) and not uFuncoes.Empty(edtNRLOTE.Text) Then
      begin
           key := #0;
           edtQuantidade.SetFocus;
      End;
end;

end.
