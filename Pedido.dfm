object FrmPedido: TFrmPedido
  Left = 0
  Top = 0
  Caption = 'Pedido'
  ClientHeight = 384
  ClientWidth = 655
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object PgPrincipal: TPageControl
    Left = 16
    Top = 80
    Width = 617
    Height = 288
    ActivePage = TabProduto
    HotTrack = True
    MultiLine = True
    Style = tsButtons
    TabOrder = 1
    TabStop = False
    object TabProduto: TTabSheet
      Caption = 'Produtos'
      object lblCodProduto: TLabel
        Left = 8
        Top = 0
        Width = 61
        Height = 13
        Caption = 'Produto (F8)'
        FocusControl = eCodProduto
      end
      object lblQtdeProduto: TLabel
        Left = 8
        Top = 46
        Width = 24
        Height = 13
        Caption = 'Qtde'
      end
      object lblVlrUnitario: TLabel
        Left = 75
        Top = 46
        Width = 51
        Height = 13
        Caption = 'Vlr unit'#225'rio'
      end
      object lblDescProd: TLabel
        Left = 75
        Top = 0
        Width = 46
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object lblTotalPedido: TLabel
        Left = 367
        Top = 246
        Width = 119
        Height = 13
        Caption = 'Total do Pedido: R$ 0,00'
      end
      object lblPrecoVenda: TLabel
        Left = 135
        Top = 46
        Width = 60
        Height = 13
        Caption = 'Pre'#231'o venda'
      end
      object eCodProduto: TEdit
        Tag = 30
        Left = 8
        Top = 14
        Width = 60
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 6
        TabOrder = 0
        OnExit = eCodProdutoExit
        OnKeyDown = eCodProdutoKeyDown
        OnKeyPress = eCodProdutoKeyPress
      end
      object eDescProduto: TEdit
        Tag = 30
        Left = 75
        Top = 13
        Width = 434
        Height = 21
        TabStop = False
        CharCase = ecUpperCase
        MaxLength = 100
        ReadOnly = True
        TabOrder = 1
      end
      object btnConfirmarProd: TBitBtn
        Left = 525
        Top = 13
        Width = 75
        Height = 22
        Caption = '&Confirmar'
        TabOrder = 4
        OnClick = btnConfirmarProdClick
      end
      object btnLimparProd: TBitBtn
        Left = 525
        Top = 37
        Width = 75
        Height = 22
        Caption = '&Limpar'
        TabOrder = 5
        OnClick = btnLimparProdClick
      end
      object btnExcluirProd: TBitBtn
        Tag = 99
        Left = 525
        Top = 61
        Width = 75
        Height = 22
        Caption = '&Excluir'
        TabOrder = 6
        OnClick = btnExcluirProdClick
      end
      object DBGridProduto: TDBGrid
        Left = 8
        Top = 111
        Width = 501
        Height = 133
        Hint = 'Clique duplo para visualizar/alterar lan'#231'amento do item'
        DataSource = DSPedidos
        FixedColor = clBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgCancelOnExit, dgMultiSelect]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBackground
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnKeyDown = DBGridProdutoKeyDown
        Columns = <
          item
            Expanded = False
            FieldName = 'CodigoProduto'
            ReadOnly = True
            Title.Caption = 'C'#243'digo'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DescricaoProduto'
            ReadOnly = True
            Title.Caption = 'Descri'#231#227'o'
            Width = 212
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Quantidade'
            Title.Alignment = taRightJustify
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ValorUnitario'
            Title.Caption = 'Vlr Unit'#225'rio'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ValorTotal'
            ReadOnly = True
            Title.Alignment = taRightJustify
            Title.Caption = 'Vlr Total'
            Width = 80
            Visible = True
          end>
      end
      object eQtde: TEdit
        Tag = 30
        Left = 8
        Top = 58
        Width = 62
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 6
        TabOrder = 2
        OnKeyPress = eQtdeKeyPress
      end
      object eVlrUnitario: TEdit
        Tag = 30
        Left = 75
        Top = 58
        Width = 52
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 6
        TabOrder = 3
        OnKeyPress = eVlrUnitarioKeyPress
      end
      object GravarPedido: TBitBtn
        Left = 525
        Top = 109
        Width = 75
        Height = 22
        Caption = '&Gravar Pedido'
        TabOrder = 8
        OnClick = btnGravarPedidoClick
      end
      object btnAtualizar: TBitBtn
        Left = 525
        Top = 85
        Width = 75
        Height = 22
        Caption = '&Atualizar'
        TabOrder = 7
        OnClick = btnAtualizarClick
      end
      object ePrecoVenda: TEdit
        Tag = 30
        Left = 135
        Top = 58
        Width = 60
        Height = 21
        TabStop = False
        CharCase = ecUpperCase
        MaxLength = 6
        ReadOnly = True
        TabOrder = 10
      end
    end
  end
  object gpClientes: TGroupBox
    Left = 16
    Top = 16
    Width = 617
    Height = 57
    Caption = 'Clientes'
    TabOrder = 0
    object lblCodCliente: TLabel
      Left = 10
      Top = 17
      Width = 56
      Height = 13
      Caption = 'C'#243'digo (F8)'
    end
    object lblDescCliente: TLabel
      Left = 79
      Top = 17
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object eCodCliente: TEdit
      Tag = 30
      Left = 10
      Top = 30
      Width = 62
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 6
      TabOrder = 0
      OnExit = eCodClienteExit
      OnKeyDown = eCodClienteKeyDown
      OnKeyPress = eCodClienteKeyPress
    end
    object eDescCliente: TEdit
      Tag = 30
      Left = 79
      Top = 30
      Width = 434
      Height = 21
      TabStop = False
      CharCase = ecUpperCase
      MaxLength = 100
      ReadOnly = True
      TabOrder = 1
    end
  end
  object DSPedidos: TDataSource
    DataSet = CDSPedido
    Left = 21
    Top = 271
  end
  object CDSPedido: TClientDataSet
    PersistDataPacket.Data = {
      B90000009619E0BD010000001800000005000000000003000000B9000D436F64
      69676F50726F6475746F04000100040000001044657363726963616F50726F64
      75746F01004900040001000557494454480200020064000A5175616E74696461
      646504000100040000000D56616C6F72556E69746172696F0800040004000100
      07535542545950450200490006004D6F6E6579000A56616C6F72546F74616C08
      0004000400010007535542545950450200490006004D6F6E6579000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CodigoProduto'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'DescricaoProduto'
        Attributes = [faRequired]
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Quantidade'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'ValorUnitario'
        Attributes = [faRequired]
        DataType = ftCurrency
      end
      item
        Name = 'ValorTotal'
        Attributes = [faRequired]
        DataType = ftCurrency
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 19
    Top = 327
    object CDSPedidoCodigoProduto: TIntegerField
      FieldName = 'CodigoProduto'
      Required = True
    end
    object CDSPedidoDescricaoProduto: TStringField
      FieldName = 'DescricaoProduto'
      Required = True
      Size = 100
    end
    object CDSPedidoQuantidade: TIntegerField
      FieldName = 'Quantidade'
      Required = True
    end
    object CDSPedidoValorUnitario: TCurrencyField
      FieldName = 'ValorUnitario'
      Required = True
    end
    object CDSPedidoValorTotal: TCurrencyField
      FieldName = 'ValorTotal'
      Required = True
    end
  end
end
