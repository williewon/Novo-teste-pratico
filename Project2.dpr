program Project2;

uses
  Vcl.Forms,
  Pedido in 'Pedido.pas' {FrmPedido},
  ConsultaClientes in 'ConsultaClientes.pas' {Clientes},
  dmDados in 'dmDados.pas' {dmDados: TDataModule},
  ConsultaProdutos in 'ConsultaProdutos.pas' {Produtos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPedido, FrmPedido);
  Application.CreateForm(TClientes, Clientes);
  Application.CreateForm(TdmDados, dm);
  Application.CreateForm(TProdutos, Produtos);
  Application.Run;
end.
