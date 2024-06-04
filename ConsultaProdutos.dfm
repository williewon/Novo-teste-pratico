object Produtos: TProdutos
  Left = 0
  Top = 0
  Caption = 'Produtos'
  ClientHeight = 391
  ClientWidth = 534
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object ConsultaProdutosForm: TDBGrid
    Left = 0
    Top = 0
    Width = 534
    Height = 391
    Align = alClient
    DataSource = DSProdutos
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDblClick = ConsultaProdutosFormDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'codigo'
        ReadOnly = True
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o'
        Width = 320
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'precovenda'
        ReadOnly = True
        Title.Caption = 'Pre'#231'o venda'
        Width = 120
        Visible = True
      end>
  end
  object DSProdutos: TDataSource
    DataSet = dmDados.QProdutos
    Left = 22
    Top = 46
  end
end
