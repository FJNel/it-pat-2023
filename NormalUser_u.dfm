object frmNormalUser: TfrmNormalUser
  Left = 0
  Top = 0
  Caption = 'frmNormalUser'
  ClientHeight = 712
  ClientWidth = 1227
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTitle: TPanel
    Left = 0
    Top = 0
    Width = 1233
    Height = 57
    Caption = 'Carbon Footprint Calculator'
    Color = clLime
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -40
    Font.Name = 'Arial Black'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object pgcNormalUser: TPageControl
    Left = -2
    Top = 57
    Width = 1235
    Height = 649
    ActivePage = tbsWelcome
    TabOrder = 1
    object tbsWelcome: TTabSheet
      Caption = 'Welcome'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      object lblWelcomeTitle: TLabel
        Left = -6
        Top = -16
        Width = 1233
        Height = 85
        Alignment = taCenter
        AutoSize = False
        Caption = 'Welcome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -60
        Font.Name = 'Arial Black'
        Font.Style = []
        ParentFont = False
      end
      object lblCFPanelTitle: TLabel
        Left = 16
        Top = 88
        Width = 209
        Height = 30
        Alignment = taCenter
        AutoSize = False
        Caption = 'Carbon Footprint'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Arial Black'
        Font.Style = []
        ParentFont = False
      end
      object lblStatusTitle: TLabel
        Left = 231
        Top = 88
        Width = 434
        Height = 30
        Alignment = taCenter
        AutoSize = False
        Caption = 'Your Status'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Arial Black'
        Font.Style = []
        ParentFont = False
      end
      object lblAverageTtitle: TLabel
        Left = 671
        Top = 88
        Width = 218
        Height = 35
        Alignment = taCenter
        AutoSize = False
        Caption = 'Average Carbon '#55357#56419
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Arial Black'
        Font.Style = []
        ParentFont = False
      end
      object lblWelcomeInfo: TLabel
        Left = 16
        Top = 61
        Width = 1192
        Height = 57
        Alignment = taCenter
        AutoSize = False
        Caption = 'View your Carbon Footprint and how it has changed over time.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object pnlEntry: TPanel
        Left = 16
        Top = 168
        Width = 593
        Height = 433
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
        object lblEntryTitle: TLabel
          Left = 0
          Top = 0
          Width = 593
          Height = 38
          Alignment = taCenter
          AutoSize = False
          Caption = 'Carbon Footprint Entries'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
        end
        object redEntry: TRichEdit
          Left = 16
          Top = 39
          Width = 561
          Height = 378
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Lines.Strings = (
            'test')
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
      object pnlGraph: TPanel
        Left = 615
        Top = 168
        Width = 593
        Height = 433
        Color = clSilver
        ParentBackground = False
        TabOrder = 1
        object lblGraphTitle: TLabel
          Left = 0
          Top = 0
          Width = 593
          Height = 38
          Alignment = taCenter
          AutoSize = False
          Caption = 'Carbon Footprint Visualisation'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
        end
        object chrGraph: TChart
          Left = 16
          Top = 39
          Width = 561
          Height = 378
          Cursor = crArrow
          Legend.Alignment = laLeft
          Legend.CustomPosition = True
          Legend.Font.Height = -13
          Legend.Left = 15
          Legend.ResizeChart = False
          Legend.Top = 4
          Legend.VertSpacing = -2
          ScrollMouseButton = mbMiddle
          Title.Font.Color = clBlack
          Title.Font.Height = -16
          Title.Font.Style = [fsBold, fsUnderline]
          Title.Text.Strings = (
            'TChart')
          BottomAxis.MaximumOffset = 10
          BottomAxis.Title.Caption = 'Entry number'
          BottomAxis.Title.Font.Height = -13
          BottomAxis.Title.Font.Style = [fsBold]
          DepthAxis.Title.Font.Height = -13
          DepthTopAxis.Title.Font.Height = -13
          DepthTopAxis.Title.Font.Style = [fsBold]
          LeftAxis.Automatic = False
          LeftAxis.AutomaticMinimum = False
          LeftAxis.MaximumOffset = 10
          LeftAxis.Title.Caption = 'CO2e Emitted (kg)'
          LeftAxis.Title.Font.Height = -13
          LeftAxis.Title.Font.Style = [fsBold]
          RightAxis.Title.Font.Height = -13
          TopAxis.Title.Font.Height = -13
          TopAxis.Title.Font.Style = [fsBold]
          View3D = False
          Zoom.AnimatedSteps = 7
          Zoom.MinimumPixels = 10
          Zoom.MouseButton = mbRight
          Color = clWhite
          TabOrder = 0
          PrintMargins = (
            15
            26
            15
            26)
          object Series1: TLineSeries
            Depth = 0
            Marks.Arrow.Visible = True
            Marks.Callout.Brush.Color = clBlack
            Marks.Callout.Arrow.Visible = True
            Marks.Visible = False
            Stacked = cssStack
            LineHeight = 1
            LinePen.Width = 3
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
            Data = {0000000000}
          end
          object Series2: TLineSeries
            Marks.Arrow.Visible = True
            Marks.Callout.Brush.Color = clBlack
            Marks.Callout.Arrow.Visible = True
            Marks.Visible = False
            Brush.Color = clWhite
            LinePen.Width = 2
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
            Data = {0000000000}
          end
        end
      end
      object pnlCarbonFootprint: TPanel
        Left = 16
        Top = 112
        Width = 209
        Height = 50
        Cursor = crArrow
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
      end
      object pnlStatus: TPanel
        Left = 231
        Top = 112
        Width = 378
        Height = 50
        Cursor = crArrow
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 3
      end
      object pnlAverageCF: TPanel
        Left = 671
        Top = 112
        Width = 218
        Height = 50
        Cursor = crArrow
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 4
      end
      object pnlStatusColor: TPanel
        Left = 615
        Top = 112
        Width = 50
        Height = 50
        Cursor = crArrow
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 5
        OnClick = btnUpdateClick
      end
      object btnTips: TPanel
        Left = 895
        Top = 112
        Width = 138
        Height = 50
        Cursor = crHandPoint
        Caption = 'Tips'
        Color = clLime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial Black'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 6
        OnClick = btnTipsClick
      end
      object btnExpand: TPanel
        Left = 1039
        Top = 112
        Width = 169
        Height = 50
        Cursor = crHandPoint
        Caption = 'Expand '#55357#56522
        Color = clLime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial Black'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 7
        OnClick = btnExpandClick
      end
      object pnlTips: TPanel
        Left = 16
        Top = 88
        Width = 1192
        Height = 513
        Color = clSilver
        Enabled = False
        ParentBackground = False
        TabOrder = 8
        Visible = False
        object lblTips: TLabel
          Left = 0
          Top = 0
          Width = 1193
          Height = 41
          Alignment = taCenter
          AutoSize = False
          Caption = 'Tips to reduce your Carbon Footprint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
        end
        object redTips: TRichEdit
          Left = 15
          Top = 41
          Width = 1161
          Height = 456
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Lines.Strings = (
            'test')
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object btnGoBack: TPanel
          Left = 1072
          Top = 470
          Width = 107
          Height = 32
          Cursor = crHandPoint
          Caption = 'Go Back'
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          OnClick = btnGoBackClick
        end
        object btnPrint: TPanel
          Left = 959
          Top = 470
          Width = 107
          Height = 32
          Cursor = crHandPoint
          Caption = 'Print'
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 2
          OnClick = btnPrintClick
        end
      end
      object btnWelcHelp: TPanel
        Left = 1039
        Top = 64
        Width = 170
        Height = 42
        Cursor = crHandPoint
        Caption = 'Help'
        Color = clLime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial Black'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 9
        OnClick = btnWelcHelpClick
      end
    end
    object tbsElectricity: TTabSheet
      Caption = 'Electricity'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      object lblElectricityTitle: TLabel
        Left = -6
        Top = -16
        Width = 1233
        Height = 85
        Alignment = taCenter
        AutoSize = False
        Caption = 'Electricity'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -60
        Font.Name = 'Arial Black'
        Font.Style = []
        ParentFont = False
      end
      object lblElectricityInfo: TLabel
        Left = 40
        Top = 66
        Width = 1139
        Height = 57
        Alignment = taCenter
        AutoSize = False
        Caption = 
          'Please enter the relevant information below, and then click the ' +
          'calculate button. You can also save your emissions clicking the ' +
          'submit button when you are satisfied with the calculation.  '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object pnlElecOne: TPanel
        Left = 16
        Top = 144
        Width = 593
        Height = 321
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
        object lblElecUnits: TLabel
          Left = 15
          Top = 44
          Width = 153
          Height = 30
          Caption = 'Units (kWh)*:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
        end
        object lblElecGenerationMethod: TLabel
          Left = 15
          Top = 127
          Width = 238
          Height = 30
          Caption = 'Generation Method*:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
        end
        object lblElecDOSOne: TLabel
          Left = 15
          Top = 214
          Width = 241
          Height = 30
          Caption = 'Date of Submission*:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
        end
        object lblElecDateInfo: TLabel
          Left = 298
          Top = 248
          Width = 58
          Height = 18
          Caption = 'DateInfo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGrayText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object lblOneTitle: TLabel
          Left = 0
          Top = 0
          Width = 593
          Height = 38
          Alignment = taCenter
          AutoSize = False
          Caption = 'Main Grid Electricity'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
        end
        object lblElecInfo: TLabel
          Left = 298
          Top = 159
          Width = 55
          Height = 18
          Caption = 'ElecInfo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGrayText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object btnElecCalcUnits: TPanel
          Left = 424
          Top = 44
          Width = 153
          Height = 34
          Cursor = crHandPoint
          Caption = 'or Calculate'
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          OnClick = btnElecCalcUnitsClick
        end
        object spnUnits: TSpinEdit
          Left = 298
          Top = 44
          Width = 120
          Height = 34
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          MaxValue = 100000
          MinValue = 0
          ParentFont = False
          TabOrder = 0
          Value = 0
          OnChange = spnUnitsChange
        end
        object cmbElectricity: TComboBox
          Left = 298
          Top = 127
          Width = 239
          Height = 32
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = 'cmbElectricity'
          OnChange = cmbElectricityChange
        end
        object btnGenerationMethodHelp: TPanel
          Left = 543
          Top = 127
          Width = 32
          Height = 32
          Cursor = crHandPoint
          Caption = '?'
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 3
          OnClick = btnGenerationMethodHelpClick
        end
        object btnElecDOSOneHelp: TPanel
          Left = 543
          Top = 216
          Width = 32
          Height = 32
          Cursor = crHandPoint
          Caption = '?'
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 5
          OnClick = btnElecDOSOneHelpClick
        end
        object dtpElecDate: TDateTimePicker
          Left = 298
          Top = 216
          Width = 239
          Height = 32
          Date = 45119.584067025460000000
          Time = 45119.584067025460000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnChange = dtpElecDateChange
        end
        object btnMainGridCalc: TPanel
          Left = 184
          Top = 275
          Width = 225
          Height = 40
          Cursor = crHandPoint
          Caption = 'Calculate'
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 6
          OnClick = btnMainGridCalcClick
        end
        object btnOneReset: TPanel
          Left = 472
          Top = 284
          Width = 107
          Height = 32
          Cursor = crHandPoint
          Caption = 'Reset'
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 7
          OnClick = btnOneResetClick
        end
      end
      object pnlElecTwo: TPanel
        Left = 615
        Top = 144
        Width = 593
        Height = 321
        Color = clSilver
        ParentBackground = False
        TabOrder = 1
        object lblElecName: TLabel
          Left = 15
          Top = 44
          Width = 208
          Height = 30
          Caption = 'Generator Name*:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
        end
        object lblElecBrand: TLabel
          Left = 15
          Top = 91
          Width = 208
          Height = 30
          Caption = 'Generator Brand*:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
        end
        object lblTwoTitle: TLabel
          Left = 0
          Top = 0
          Width = 593
          Height = 38
          Alignment = taCenter
          AutoSize = False
          Caption = 'Add Generator to Database'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
        end
        object lblElecType: TLabel
          Left = 15
          Top = 139
          Width = 197
          Height = 30
          Caption = 'Generator Type*:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
        end
        object lblElecCap: TLabel
          Left = 15
          Top = 187
          Width = 242
          Height = 30
          Caption = 'Generator Capacity*:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
        end
        object lblElecEmissions: TLabel
          Left = 15
          Top = 231
          Width = 309
          Height = 30
          Caption = 'Generator Emissions (kg)*:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
        end
        object cmbElecGenType: TComboBox
          Left = 296
          Top = 140
          Width = 281
          Height = 32
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = 'Select Generator Type'
          Items.Strings = (
            'Diesel'
            'Petrol'
            'LP Gas'
            'Natural Gas')
        end
        object edtElecName: TEdit
          Left = 297
          Top = 44
          Width = 280
          Height = 32
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TextHint = 'BPD5000S'
        end
        object edtElecBrand: TEdit
          Left = 297
          Top = 92
          Width = 280
          Height = 32
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TextHint = 'PAW'
        end
        object edtElecEmissions: TEdit
          Left = 330
          Top = 229
          Width = 247
          Height = 32
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          TextHint = 'per liter consumed'
        end
        object edtElecCap: TEdit
          Left = 297
          Top = 185
          Width = 280
          Height = 32
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          TextHint = 'in kW or kVA'
        end
        object btnElecGenAdd: TPanel
          Left = 184
          Top = 275
          Width = 225
          Height = 40
          Cursor = crHandPoint
          Caption = 'Add'
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 5
          OnClick = btnElecGenAddClick
        end
        object btnGeneratorBack: TPanel
          Left = 472
          Top = 284
          Width = 107
          Height = 32
          Cursor = crHandPoint
          Caption = 'Go Back'
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 6
          OnClick = btnGeneratorBackClick
        end
        object btnTwoReset: TPanel
          Left = 432
          Top = 284
          Width = 34
          Height = 32
          Cursor = crHandPoint
          Hint = 'Reset'
          Caption = #8634
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnClick = btnTwoResetClick
        end
      end
      object pnlElecThree: TPanel
        Left = 615
        Top = 144
        Width = 593
        Height = 321
        Color = clSilver
        ParentBackground = False
        TabOrder = 2
        object lblElecLitres: TLabel
          Left = 24
          Top = 175
          Width = 211
          Height = 30
          Caption = 'Liters consumed*:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
        end
        object lblElecGenerator: TLabel
          Left = 15
          Top = 44
          Width = 134
          Height = 30
          Caption = 'Generator*:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
        end
        object lblDOSThree: TLabel
          Left = 24
          Top = 214
          Width = 241
          Height = 30
          Caption = 'Date of Submission*:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
        end
        object lblElecDateInfoThree: TLabel
          Left = 298
          Top = 248
          Width = 58
          Height = 18
          Caption = 'DateInfo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGrayText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object lblElecGenInfo: TLabel
          Left = 15
          Top = 70
          Width = 265
          Height = 30
          Caption = 'Chosen Generator Info:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
        end
        object lblThree: TLabel
          Left = 0
          Top = 0
          Width = 593
          Height = 38
          Alignment = taCenter
          AutoSize = False
          Caption = 'Other Electricity Source'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
        end
        object btnElecCalcLiters: TPanel
          Left = 424
          Top = 176
          Width = 153
          Height = 34
          Cursor = crHandPoint
          Caption = 'or Calculate'
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 3
          OnClick = btnElecCalcLitersClick
        end
        object spnLitres: TSpinEdit
          Left = 298
          Top = 176
          Width = 120
          Height = 34
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          MaxValue = 100000
          MinValue = 0
          ParentFont = False
          TabOrder = 2
          Value = 0
          OnChange = spnLitresChange
        end
        object cmbGenerator: TComboBox
          Left = 298
          Top = 44
          Width = 279
          Height = 32
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = 'Select Generator'
          OnChange = cmbGeneratorChange
        end
        object btnGeneratorAdd: TPanel
          Left = 204
          Top = 44
          Width = 87
          Height = 32
          Cursor = crHandPoint
          Caption = 'Add or'
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          OnClick = btnGeneratorAddClick
        end
        object btnDOSThreeHelp: TPanel
          Left = 543
          Top = 216
          Width = 32
          Height = 32
          Cursor = crHandPoint
          Caption = '?'
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 5
          OnClick = btnElecDOSOneHelpClick
        end
        object dtpElecDateThree: TDateTimePicker
          Left = 298
          Top = 216
          Width = 239
          Height = 32
          Date = 45119.584067025460000000
          Time = 45119.584067025460000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnChange = dtpElecDateThreeChange
        end
        object redElecGen: TRichEdit
          Left = 298
          Top = 75
          Width = 279
          Height = 97
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
        end
        object btnGeneratorCalc: TPanel
          Left = 184
          Top = 275
          Width = 225
          Height = 40
          Cursor = crHandPoint
          Caption = 'Calculate'
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 7
          OnClick = btnGeneratorCalcClick
        end
        object btnThreeReset: TPanel
          Left = 472
          Top = 284
          Width = 107
          Height = 32
          Cursor = crHandPoint
          Caption = 'Reset'
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 8
          OnClick = btnThreeResetClick
        end
      end
      object pnlCalcMain: TPanel
        Left = 185
        Top = 471
        Width = 257
        Height = 54
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 3
      end
      object btnSubmitMain: TPanel
        Left = 200
        Top = 531
        Width = 225
        Height = 42
        Cursor = crHandPoint
        Caption = 'Submit'
        Color = clLime
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -27
        Font.Name = 'Arial Black'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 4
        OnClick = btnSubmitMainClick
      end
      object pnlCalcGen: TPanel
        Left = 783
        Top = 471
        Width = 257
        Height = 54
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 5
      end
      object btnSubmitGen: TPanel
        Left = 799
        Top = 531
        Width = 225
        Height = 42
        Cursor = crHandPoint
        Caption = 'Submit'
        Color = clLime
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -27
        Font.Name = 'Arial Black'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 6
        OnClick = btnSubmitGenClick
      end
      object btnElecHelp: TPanel
        Left = 1079
        Top = 531
        Width = 129
        Height = 42
        Cursor = crHandPoint
        Caption = 'Help'
        Color = clLime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial Black'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 7
        OnClick = btnElecHelpClick
      end
    end
  end
end
