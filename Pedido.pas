unit Pedido;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
   FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
   FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
   FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
   FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
   FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
   Vcl.Buttons, Datasnap.DBClient, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
   System.ImageList, Vcl.ImgList, Vcl.ExtCtrls, dmDados, ConsultaClientes, ConsultaProdutos;
type
   TFrmPedido = class(TForm)
      DBGridProduto: TDBGrid;
      DSPedidos: TDataSource;
      PgPrincipal: TPageControl;
      TabProduto: TTabSheet;
      eQtde: TEdit;
      eVlrUnitario: TEdit;
      eCodCliente: TEdit;
      eDescCliente: TEdit;
      eCodProduto: TEdit;
      eDescProduto: TEdit;
      lblCodProduto: TLabel;
      lblQtdeProduto: TLabel;
      lblVlrUnitario: TLabel;
      btnConfirmarProd: TBitBtn;
      btnLimparProd: TBitBtn;
      btnExcluirProd: TBitBtn;
      CDSPedido: TClientDataSet;
      CDSPedidoCodigoProduto: TIntegerField;
      CDSPedidoDescricaoProduto: TStringField;
      CDSPedidoQuantidade: TIntegerField;
      CDSPedidoValorUnitario: TCurrencyField;
      CDSPedidoValorTotal: TCurrencyField;
      lblCodCliente: TLabel;
      gpClientes: TGroupBox;
      lblDescCliente: TLabel;
      lblDescProd: TLabel;
      lblTotalPedido: TLabel;
      GravarPedido: TBitBtn;
      btnAtualizar: TBitBtn;
      lblPrecoVenda: TLabel;
      ePrecoVenda: TEdit;
      procedure FormCreate(Sender: TObject);
      procedure AtualizarTotalPedido;
      procedure btnConfirmarProdClick(Sender: TObject);
      procedure eCodClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure eCodProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure btnGravarPedidoClick(Sender: TObject);
      procedure btnLimparProdClick(Sender: TObject);
      procedure BuscarClientePorCodigo(const ACodigo: String);
      procedure BuscarProdutoPorCodigo(const ACodigo: String);
      procedure eCodClienteExit(Sender: TObject);
      procedure eCodProdutoExit(Sender: TObject);
      procedure eCodClienteKeyPress(Sender: TObject; var Key: Char);
      procedure eCodProdutoKeyPress(Sender: TObject; var Key: Char);
      procedure ApenasNumeros(Sender: TObject; var Key: Char);
      procedure eQtdeKeyPress(Sender: TObject; var Key: Char);
      procedure btnExcluirProdClick(Sender: TObject);
      procedure ExcluirItem;
      procedure btnAtualizarClick(Sender: TObject);
      procedure DBGridProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure eVlrUnitarioKeyPress(Sender: TObject; var Key: Char);
   private
      FValorPed: Currency;
   end;
var
   FrmPedido: TFrmPedido;

implementation

{$R *.dfm}

procedure TFrmPedido.FormCreate(Sender: TObject);
begin
   lblTotalPedido.Caption := 'Total do Pedido: R$ 0,00';
   FValorPed := 0;
end;

procedure TFrmPedido.btnGravarPedidoClick(Sender: TObject);
var
  ANumeroPedido: Integer;
  ACodigoCliente, AValorTotalStr: String;
  AValorTotal: Currency;  
begin
   if Trim(eCodCliente.Text) = '' then begin
      ShowMessage('Informe o código do cliente.');
      eCodCliente.SetFocus;
      Exit;
   end;
   if CDSPedido.IsEmpty then begin
      ShowMessage('Insira um ou mais produtos para continuar.');
      eCodProduto.SetFocus;
      Exit;
   end;
   ACodigoCliente := eCodCliente.Text;
   dm.Transaction.StartTransaction;
   try
      dm.QClientes.Close;
      dm.QClientes.SQL.Text := 'SELECT COALESCE(MAX(NumeroPedido), 0) AS MaxNumero FROM Pedidos';
      dm.QClientes.Open;
      ANumeroPedido := dm.QClientes.FieldByName('MaxNumero').AsInteger + 1;
      dm.QClientes.Close;
      dm.QClientes.SQL.Text := 'INSERT INTO Pedidos (NumeroPedido, DataEmissao, CodigoCliente, ValorTotal) ' +
                               'VALUES (:NumeroPedido, :DataEmissao, :CodigoCliente, :ValorTotal)';
      dm.QClientes.ParamByName('NumeroPedido').AsInteger := ANumeroPedido;
      dm.QClientes.ParamByName('DataEmissao').AsDate := Date;
      dm.QClientes.ParamByName('CodigoCliente').AsString := ACodigoCliente;
      dm.QClientes.ParamByName('ValorTotal').AsCurrency:= FValorPed;
      dm.QClientes.ExecSQL;
      CDSPedido.First;
      while not CDSPedido.Eof do begin
         dm.QClientes.Close;
         dm.QClientes.SQL.Text := 'INSERT INTO ItensPedProd (NumeroPedido, CodigoProduto, VlrUnitario, Qtde, ValorTotal) ' +
                                  'VALUES (:NumeroPedido, :CodigoProduto, :VlrUnitario, :Qtde, :ValorTotal)';
         dm.QClientes.ParamByName('NumeroPedido').AsInteger := ANumeroPedido;
         dm.QClientes.ParamByName('CodigoProduto').AsInteger := CDSPedido.FieldByName('CodigoProduto').AsInteger;
         dm.QClientes.ParamByName('VlrUnitario').AsCurrency := CDSPedido.FieldByName('ValorUnitario').AsCurrency;
         dm.QClientes.ParamByName('Qtde').AsInteger := CDSPedido.FieldByName('Quantidade').AsInteger;
         dm.QClientes.ParamByName('ValorTotal').AsCurrency := CDSPedido.FieldByName('ValorTotal').AsCurrency;
         dm.QClientes.ExecSQL;
         CDSPedido.Next;
      end;
      dm.Transaction.Commit;
      ShowMessage('Pedido gravado com sucesso!');
      CDSPedido.Close;
      CDSPedido.CreateDataSet;
      btnLimparProdClick(Self);
      eCodCliente.Clear;
      eDescCliente.Clear;
      AtualizarTotalPedido;
      ShowMessage('Realize um novo pedido.');
      eCodCliente.SetFocus;
   except
      on E: Exception do begin
         dm.Transaction.Rollback;
         ShowMessage('Erro ao gravar pedido: ' + E.Message);
      end;
   end;
end;

procedure TFrmPedido.btnLimparProdClick(Sender: TObject);
begin
  eCodProduto.Clear;
  eDescProduto.Clear;
  ePrecoVenda.Clear;
  eVlrUnitario.Clear;
  eQtde.Clear;
end;

procedure TFrmPedido.btnAtualizarClick(Sender: TObject);
var
   AQuantidade: Integer;
   AValorUnitario, AValorTotal: Currency;
begin
   if CDSPedido.IsEmpty then begin
      ShowMessage('Nenhum item inserido.');
      Exit;
   end;
   if DBGridProduto.SelectedRows.Count = 0 then begin
      ShowMessage('Nenhum item selecionado.');
      Exit;
   end;
   try
      AQuantidade := StrToIntDef(CDSPedido.FieldByName('Quantidade').AsString, 0);
      AValorUnitario := StrToCurrDef(CDSPedido.FieldByName('ValorUnitario').AsString, 0);
   except
      on E: Exception do begin
         ShowMessage('Valores inválidos. Por favor, insira valores numéricos válidos.');
         Exit;
      end;
   end;
   AValorTotal := AQuantidade * AValorUnitario;
   // Atualizar o ClientDataSet com os novos valores
   CDSPedido.Edit;
   CDSPedido.FieldByName('Quantidade').AsInteger := AQuantidade;
   CDSPedido.FieldByName('ValorUnitario').AsCurrency := AValorUnitario;
   CDSPedido.FieldByName('ValorTotal').AsCurrency := AValorTotal;
   CDSPedido.Post;
   AtualizarTotalPedido;
   ShowMessage('Item atualizado com sucesso.');
end;


procedure TFrmPedido.btnConfirmarProdClick(Sender: TObject);
var
   ACodigoProduto: Integer;
   AQuantidade: Integer;
   AValorUnitario: Currency;
begin
   if StrToIntDef(eCodProduto.Text, 0) = 0 then begin
      ShowMessage('Informe o(s) produto(s) que deseja inserir.');
      eCodProduto.SetFocus;
      Exit;
   end;
   if StrToIntDef(eQtde.Text, 0) = 0 then begin
      ShowMessage('Informe a quantidade do(s) produto(s)');
      eQtde.SetFocus;
      Exit;
   end;
   if StrToCurrDef(eVlrUnitario.Text, 0) = 0 then begin
      ShowMessage('Informe o vlr unitário do(s) produto(s)');
      eVlrUnitario.SetFocus;
      Exit;
   end;
   ACodigoProduto := StrToIntDef(eCodProduto.Text, 0);
   AQuantidade := StrToIntDef(eQtde.Text, 0);
   AValorUnitario := StrToCurr(eVlrUnitario.Text);
   CDSPedido.Append;
   CDSPedido.FieldByName('CodigoProduto').AsInteger := ACodigoProduto;
   CDSPedido.FieldByName('DescricaoProduto').AsString := eDescProduto.Text;
   CDSPedido.FieldByName('Quantidade').AsInteger := AQuantidade;
   CDSPedido.FieldByName('ValorUnitario').AsCurrency := AValorUnitario;
   CDSPedido.FieldByName('ValorTotal').AsCurrency := AQuantidade * AValorUnitario;
   CDSPedido.Post;
   AtualizarTotalPedido;
   btnLimparProdClick(Self);
   eCodProduto.SetFocus;
end;

procedure TFrmPedido.btnExcluirProdClick(Sender: TObject);
begin
   ExcluirItem;
end;

procedure TFrmPedido.ExcluirItem;
var
  i: Integer;
  ABookmarks: array of TBookmark;
begin
   if CDSPedido.IsEmpty then begin
      ShowMessage('Nenhum item inserido.');
      Exit;
   end;
   if DBGridProduto.SelectedRows.Count = 0 then begin
      ShowMessage('Nenhum item selecionado.');
      Exit;
   end;
   if Application.MessageBox('Deseja realmente excluir o item selecionado?', 'Mensagem', MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2) = mrNo then
      Exit;
   //Armazenar os bookmarks das linhas selecionadas
   SetLength(ABookmarks, DBGridProduto.SelectedRows.Count);
   for i := 0 to DBGridProduto.SelectedRows.Count - 1 do begin
      CDSPedido.GotoBookmark(TBookmark(DBGridProduto.SelectedRows.Items[i]));
      ABookmarks[i] := CDSPedido.Bookmark;
   end;
   CDSPedido.DisableControls;
   try
      for i := 0 to High(ABookmarks) do begin
         //Navegar para a linha selecionada
         CDSPedido.GotoBookmark(ABookmarks[i]);
         //Remover o item do ClientDataSet
         CDSPedido.Delete;
      end;
   finally
      CDSPedido.EnableControls;
   end;
   AtualizarTotalPedido;
   ShowMessage('Item(ns) excluído(s) com sucesso.');
end;

procedure TFrmPedido.eCodClienteExit(Sender: TObject);
begin
   if (eCodCliente.Text <> EmptyStr) and (eDescCliente.Text = EmptyStr) then
      BuscarClientePorCodigo(eCodCliente.Text)
   else
    eDescCliente.Text := EmptyStr;
end;

procedure TFrmPedido.eCodClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_F8 then begin
      with TClientes.Create(nil) do begin
         try
            if ShowModal = mrOk then begin
               eCodCliente.Text := dm.QClientes.FieldByName('CODIGO').AsString;
               eDescCliente.Text := dm.QClientes.FieldByName('NOME').AsString;
               eCodProduto.SetFocus;
            end;
         finally
           Free;
         end;
      end;
   end;
end;

procedure TFrmPedido.eCodClienteKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then begin//Tecla Enter
      Key := #0;//Cancelar o som padrão do Enter
      SelectNext(ActiveControl, True, True);
   end;
   ApenasNumeros(Self, Key);   
end;

procedure TFrmPedido.eCodProdutoExit(Sender: TObject);
begin
   if (eCodProduto.Text <> EmptyStr) and (eDescProduto.Text = EmptyStr) then
      BuscarProdutoPorCodigo(eCodProduto.Text)
   else
      btnLimparProdClick(Self);
end;

procedure TFrmPedido.eCodProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_F8 then begin
      with TProdutos.Create(nil) do begin
         try
            if ShowModal = mrOk then begin
               eCodProduto.Text  := dm.QProdutos.FieldByName('CODIGO').AsString;
               eDescProduto.Text := dm.QProdutos.FieldByName('DESCRICAO').AsString;
               ePrecoVenda.Text  := FormatFloat('0.00', dm.QProdutos.FieldByName('PRECOVENDA').AsCurrency);
               eQtde.SetFocus;
            end;
         finally
           Free;
         end;
      end;
   end;
end;

procedure TFrmPedido.eCodProdutoKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then begin//Tecla Enter
      Key := #0;//Cancelar o som padrão do Enter
      SelectNext(ActiveControl, True, True);
   end;
   ApenasNumeros(Self, Key);   
end;

procedure TFrmPedido.eQtdeKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then begin//Tecla Enter
      Key := #0;//Cancelar o som padrão do Enter
      eVlrUnitario.SetFocus;
   end;
   ApenasNumeros(Self, Key);
end;

procedure TFrmPedido.eVlrUnitarioKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then begin//Tecla Enter
      Key := #0;//Cancelar o som padrão do Enter
      btnConfirmarProd.SetFocus;
   end;
end;

procedure TFrmPedido.BuscarClientePorCodigo(const ACodigo: String);
begin
   dm.QClientes.Close;
   dm.QClientes.SQL.Text := 'SELECT * FROM Clientes WHERE Codigo LIKE :Codigo';
   dm.QClientes.ParamByName('Codigo').AsString := '%' + ACodigo + '%';
   dm.QClientes.Open;
   if not dm.QClientes.IsEmpty then begin
      eCodCliente.Text := dm.QClientes.FieldByName('Codigo').AsString;
      eDescCliente.Text := dm.QClientes.FieldByName('Nome').AsString;
   end else begin
      ShowMessage('Cliente não encontrado.');
      eCodCliente.SetFocus;
   end;
end;
procedure TFrmPedido.BuscarProdutoPorCodigo(const ACodigo: String);
begin
   dm.QProdutos.Close;
   dm.QProdutos.SQL.Text := 'SELECT * FROM Produtos WHERE Codigo like :Codigo';
   dm.QProdutos.ParamByName('Codigo').AsString := '%' + ACodigo + '%';
   dm.QProdutos.Open;
   if not dm.QProdutos.IsEmpty then begin
      eCodProduto.Text := dm.QProdutos.FieldByName('Codigo').AsString;
      eDescProduto.Text := dm.QProdutos.FieldByName('Descricao').AsString;
      ePrecoVenda.Text  := FormatFloat('0.00', dm.QProdutos.FieldByName('PRECOVENDA').AsCurrency);
   end else begin
      ShowMessage('Produto não encontrado.');
      eCodProduto.SetFocus;
   end;
end;

procedure TFrmPedido.DBGridProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_DELETE then
      btnExcluirProdClick(Self);
end;

procedure TFrmPedido.AtualizarTotalPedido;
var
   ATotal: Currency;
begin
   ATotal := 0;
   if DSPedidos.DataSet.Active then begin
      DSPedidos.DataSet.DisableControls;
      try
         DSPedidos.DataSet.First;
         while not DSPedidos.DataSet.Eof do begin
            ATotal := ATotal + DSPedidos.DataSet.FieldByName('ValorTotal').AsCurrency;
            FValorPed := ATotal; 
            DSPedidos.DataSet.Next;
         end;
      finally
         DSPedidos.DataSet.EnableControls;
      end;
   end;
  lblTotalPedido.Caption := 'Total do Pedido: R$ ' + FormatFloat('0.00', ATotal);
end;

procedure TFrmPedido.ApenasNumeros(Sender: TObject; var Key: Char);
begin
   if not (Key in ['0'..'9', #8]) then //Permitir apenas números e backspace
      Key := #0;
end;

end.
