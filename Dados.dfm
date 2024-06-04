object dmDados: TdmDados
  Height = 348
  Width = 470
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=root'
      'Database=wk'
      'Password=root'
      'DriverID=MySQL')
    Connected = True
    Left = 120
    Top = 128
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\Usuario\Documents\Embarcadero\Studio\Projects\libmysql.' +
      'dll'
    Left = 360
    Top = 128
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 232
    Top = 128
  end
  object QClientes: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM CLIENTES')
    Left = 112
    Top = 208
  end
end
