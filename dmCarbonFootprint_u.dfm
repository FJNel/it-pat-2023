object dmCarbonFootprint: TdmCarbonFootprint
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 265
  Width = 430
  object conCarbonFootprint: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=CarbonFootprintDB.m' +
      'db;Mode=ReadWrite;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 72
    Top = 8
  end
  object tblUsers: TADOTable
    Active = True
    Connection = conCarbonFootprint
    CursorType = ctStatic
    TableName = 'tblUsers'
    Left = 8
    Top = 64
  end
  object dscUsers: TDataSource
    DataSet = tblUsers
    Left = 8
    Top = 120
  end
  object tblEmission: TADOTable
    Active = True
    Connection = conCarbonFootprint
    CursorType = ctStatic
    TableName = 'tblEmission'
    Left = 120
    Top = 64
  end
  object dscEmission: TDataSource
    DataSet = tblEmission
    Left = 120
    Top = 120
  end
  object tblElectricity: TADOTable
    Active = True
    Connection = conCarbonFootprint
    CursorType = ctStatic
    TableName = 'tblElectricity'
    Left = 176
    Top = 64
  end
  object dscElectricity: TDataSource
    DataSet = tblElectricity
    Left = 176
    Top = 120
  end
  object tblGenerator: TADOTable
    Active = True
    Connection = conCarbonFootprint
    CursorType = ctStatic
    TableName = 'tblGenerator'
    Left = 232
    Top = 64
  end
  object dscGenerator: TDataSource
    DataSet = tblGenerator
    Left = 232
    Top = 120
  end
  object qryElectricity: TADOQuery
    Connection = conCarbonFootprint
    DataSource = dscElectricity
    Parameters = <>
    Left = 176
    Top = 168
  end
  object dscElecSQL: TDataSource
    DataSet = qryElectricity
    Left = 176
    Top = 216
  end
end
