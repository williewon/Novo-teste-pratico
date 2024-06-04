object dmDados: TdmDados
  OnCreate = DataModuleCreate
  Height = 199
  Width = 236
  object Con: TFDConnection
    Params.Strings = (
      'User_Name=root'
      'Database=wk'
      'Password=root'
      'DriverID=MySQL'
      'Server=localhost')
    Left = 17
    Top = 3
  end
  object Drive: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\Usuario\Documents\Embarcadero\Studio\Projects\Win32\Deb' +
      'ug\libmariadb.dll'
    Left = 106
    Top = 3
  end
  object Cursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 61
    Top = 3
  end
  object QClientes: TFDQuery
    Connection = Con
    SQL.Strings = (
      'SELECT * FROM CLIENTES')
    Left = 16
    Top = 72
  end
  object QPedidos: TFDQuery
    Connection = Con
    SQL.Strings = (
      'SELECT * FROM PEDIDOS')
    Left = 19
    Top = 127
  end
  object QProdutos: TFDQuery
    Connection = Con
    SQL.Strings = (
      'SELECT * FROM PRODUTOS')
    Left = 80
    Top = 72
  end
  object QItensPed: TFDQuery
    Connection = Con
    SQL.Strings = (
      'SELECT * FROM ITENSPEDPROD')
    Left = 81
    Top = 127
  end
  object Transaction: TFDTransaction
    Connection = Con
    Left = 170
    Top = 3
  end
end
