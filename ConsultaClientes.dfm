object Clientes: TClientes
  Left = 0
  Top = 0
  Caption = 'Clientes'
  ClientHeight = 392
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object ConsultaClientesForm: TDBGrid
    Left = 0
    Top = 0
    Width = 538
    Height = 392
    Align = alClient
    DataSource = DSClientes
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDblClick = ConsultaClientesFormDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'Codigo'
        ReadOnly = True
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nome'
        ReadOnly = True
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Cidade'
        ReadOnly = True
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UF'
        ReadOnly = True
        Visible = True
      end>
  end
  object DSClientes: TDataSource
    DataSet = dmDados.QClientes
    Left = 19
    Top = 48
  end
end
