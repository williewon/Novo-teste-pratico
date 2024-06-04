unit ConsultaClientes;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, dmDados;

type
   TClientes = class(TForm)
      ConsultaClientesForm: TDBGrid;
      DSClientes: TDataSource;
      procedure FormCreate(Sender: TObject);
      procedure ConsultaClientesFormDblClick(Sender: TObject);
   private
      { Private declarations }
   public
      { Public declarations }
      ACodCli, ADescCli: String;
  end;

var
  Clientes: TClientes;

implementation

{$R *.dfm}

procedure TClientes.ConsultaClientesFormDblClick(Sender: TObject);
begin
   if not dm.QClientes.IsEmpty then begin
      ACodCli := dm.QClientes.FieldByName('CODIGO').AsString;
      ADescCli := dm.QClientes.FieldByName('NOME').AsString;
      ModalResult := mrOk;
   end else
    ShowMessage('Nenhum cliente selecionado.');
end;

procedure TClientes.FormCreate(Sender: TObject);
begin
   // Usar o DataSource e Query configurados no DataModule
   if Assigned(dm) then begin
      dm.QClientes.SQL.Text := 'Select * from Clientes';
      dsClientes.DataSet := dm.QClientes;
      dm.QClientes.Open;
   end;
end;

end.
