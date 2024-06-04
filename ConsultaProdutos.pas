unit ConsultaProdutos;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, dmDados;

type
   TProdutos = class(TForm)
      ConsultaProdutosForm: TDBGrid;
      DSProdutos: TDataSource;
      procedure FormCreate(Sender: TObject);
      procedure ConsultaProdutosFormDblClick(Sender: TObject);
   private
      { Private declarations }
   public
      { Public declarations }
      ACodProd, ADescProd: String;
      APrecoVenda: Currency;
  end;

var
  Produtos: TProdutos;

implementation

{$R *.dfm}

procedure TProdutos.ConsultaProdutosFormDblClick(Sender: TObject);
begin
   if not dm.QProdutos.IsEmpty then begin
      ACodProd    := dm.QProdutos.FieldByName('CODIGO').AsString;
      ADescProd   := dm.QProdutos.FieldByName('DESCRICAO').AsString;
      APrecoVenda := dm.QProdutos.FieldByName('PRECOVENDA').AsCurrency;
      ModalResult := mrOk;
   end else
    ShowMessage('Nenhum cliente selecionado.');
end;

procedure TProdutos.FormCreate(Sender: TObject);
begin
   // Usar o DataSource e Query configurados no DataModule
   if Assigned(dm) then begin
      dm.QProdutos.SQL.Text := 'Select * from Produtos';
      DSProdutos.DataSet := dm.QProdutos;
      dm.QProdutos.Open;
   end;
end;

end.
