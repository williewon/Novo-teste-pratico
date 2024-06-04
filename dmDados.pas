unit dmDados;

interface

uses
   System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
   FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
   FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
   FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
   FireDAC.DApt, FireDAC.Comp.DataSet;

type
   TdmDados = class(TDataModule)
      Con: TFDConnection;
      Drive: TFDPhysMySQLDriverLink;
      Cursor: TFDGUIxWaitCursor;
      QClientes: TFDQuery;
      QPedidos: TFDQuery;
      QProdutos: TFDQuery;
      QItensPed: TFDQuery;
      Transaction: TFDTransaction;
      procedure DataModuleCreate(Sender: TObject);
   private
      { Private declarations }
   public
      { Public declarations }
   end;
var
  dm: TdmDados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmDados.DataModuleCreate(Sender: TObject);
begin
   Con.Params.Clear;
   Con.DriverName := 'MySQL';
   Con.Params.Add('Server=localhost');
   Con.Params.Add('Database=wk');
   Con.Params.Add('User_Name=root');
   Con.Params.Add('Password=root');
   Con.Params.Add('Port=3306');
   Con.Params.Add('SSLMode=DISABLED');
   Con.LoginPrompt := False;
   Con.Connected := True;
   QClientes.Connection := Con;
   QProdutos.Connection := Con;
   QPedidos.Connection := Con;
   QItensPed.Connection := Con;
   Transaction.Connection := Con;// Associar a transação à conexão
end;

end.
