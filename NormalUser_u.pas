unit NormalUser_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, dmCarbonFootprint_u, Math, Spin,
  DateUtils, clsGenerator_u, TeEngine, Series, TeeProcs, Chart, clsFactLoader_u;

type
  TfrmNormalUser = class(TForm)
    pnlTitle: TPanel;
    pgcNormalUser: TPageControl;
    tbsWelcome: TTabSheet;
    tbsElectricity: TTabSheet;
    lblWelcomeTitle: TLabel;
    lblElectricityTitle: TLabel;
    pnlElecOne: TPanel;
    lblElectricityInfo: TLabel;
    lblElecUnits: TLabel;
    btnElecCalcUnits: TPanel;
    spnUnits: TSpinEdit;
    lblElecGenerationMethod: TLabel;
    cmbElectricity: TComboBox;
    btnGenerationMethodHelp: TPanel;
    lblElecDOSOne: TLabel;
    btnElecDOSOneHelp: TPanel;
    lblElecDateInfo: TLabel;
    dtpElecDate: TDateTimePicker;
    lblOneTitle: TLabel;
    pnlElecTwo: TPanel;
    lblElecName: TLabel;
    lblElecBrand: TLabel;
    lblTwoTitle: TLabel;
    lblElecType: TLabel;
    cmbElecGenType: TComboBox;
    lblElecCap: TLabel;
    lblElecEmissions: TLabel;
    edtElecName: TEdit;
    edtElecBrand: TEdit;
    edtElecEmissions: TEdit;
    edtElecCap: TEdit;
    btnElecGenAdd: TPanel;
    pnlElecThree: TPanel;
    lblElecLitres: TLabel;
    lblElecGenerator: TLabel;
    lblDOSThree: TLabel;
    lblElecDateInfoThree: TLabel;
    btnElecCalcLiters: TPanel;
    spnLitres: TSpinEdit;
    cmbGenerator: TComboBox;
    btnGeneratorAdd: TPanel;
    btnDOSThreeHelp: TPanel;
    dtpElecDateThree: TDateTimePicker;
    lblElecGenInfo: TLabel;
    redElecGen: TRichEdit;
    btnGeneratorBack: TPanel;
    lblElecInfo: TLabel;
    btnGeneratorCalc: TPanel;
    btnMainGridCalc: TPanel;
    pnlCalcMain: TPanel;
    btnSubmitMain: TPanel;
    pnlCalcGen: TPanel;
    btnSubmitGen: TPanel;
    btnElecHelp: TPanel;
    btnThreeReset: TPanel;
    btnOneReset: TPanel;
    btnTwoReset: TPanel;
    pnlEntry: TPanel;
    lblEntryTitle: TLabel;
    redEntry: TRichEdit;
    pnlGraph: TPanel;
    lblGraphTitle: TLabel;
    chrGraph: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    pnlCarbonFootprint: TPanel;
    lblCFPanelTitle: TLabel;
    pnlStatus: TPanel;
    lblStatusTitle: TLabel;
    pnlAverageCF: TPanel;
    lblAverageTtitle: TLabel;
    pnlStatusColor: TPanel;
    btnTips: TPanel;
    btnExpand: TPanel;
    pnlTips: TPanel;
    lblTips: TLabel;
    redTips: TRichEdit;
    btnGoBack: TPanel;
    btnWelcHelp: TPanel;
    lblWelcomeInfo: TLabel;
    lblThree: TLabel;
    btnPrint: TPanel;
    procedure FormActivate(Sender: TObject);
    Function CalculateUnits(rPrice: Real): Integer; //User defined
    Procedure DisplayEntries; //User defined
    procedure btnGenerationMethodHelpClick(Sender: TObject);
    procedure btnElecDOSOneHelpClick(Sender: TObject);
    procedure dtpElecDateChange(Sender: TObject);
    procedure btnElecCalcUnitsClick(Sender: TObject);
    procedure btnElecGenAddClick(Sender: TObject);
    procedure cmbGeneratorChange(Sender: TObject);
    procedure btnElecCalcLitersClick(Sender: TObject);
    procedure btnGeneratorAddClick(Sender: TObject);
    procedure btnGeneratorBackClick(Sender: TObject);
    procedure dtpElecDateThreeChange(Sender: TObject);
    procedure cmbElectricityChange(Sender: TObject);
    procedure btnMainGridCalcClick(Sender: TObject);
    procedure btnSubmitMainClick(Sender: TObject);
    procedure spnUnitsChange(Sender: TObject);
    procedure spnLitresChange(Sender: TObject);
    procedure btnGeneratorCalcClick(Sender: TObject);
    procedure btnSubmitGenClick(Sender: TObject);
    procedure btnOneResetClick(Sender: TObject);
    procedure btnThreeResetClick(Sender: TObject);
    procedure btnTwoResetClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnExpandClick(Sender: TObject);
    procedure btnTipsClick(Sender: TObject);
    procedure btnGoBackClick(Sender: TObject);
    procedure btnElecHelpClick(Sender: TObject);
    procedure btnWelcHelpClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
  private
    objGenerator : TGenerator;
    objFactLoader: TFactLoader;
  public
    { Public declarations }
  end;

var
  frmNormalUser: TfrmNormalUser;

implementation

uses CarbonFootprint1_u;
{$R *.dfm}

//-------------------------------\\
// Calculate Litres Button Click \\
//-------------------------------\\
procedure TfrmNormalUser.btnElecCalcLitersClick(Sender: TObject);
var
  iBut, iMin : Integer;
begin
  //Validation
  if cmbGenerator.ItemIndex = -1 then
  begin
    iBut := MessageDlg('You must first select a Generator before you can calculate the Liters consumed. To avoid this error, Make sure to select the Generator from the Generator ComboBox first.',mtError,[mbAbort],0);
    Exit;
  end;

  //For Try Except to work in Delphi itself: Tools > Options > Debugger Options ? Enbarcadero Debuggers > Language Exceptions > Notify on language exceptions (OFF)
  //Try Except works when using the Executable file.
  try
    iMin := StrToInt(InputBox('Calculate the amount of Liters consumed','Enter the Amount of time your Generator ran for (in Minutes), in your own chosen time period. '+#10+'e.g. If your generator ran for 10 minutes, only type 10','0'));
  except
    iBut := MessageDlg('You entered an invalid Time. To avoid this error, Make sure to only enter the Amount of time your Generator ran for (in Minutes) as a number. Do not use other text such as full stops, spaces, etc.',mtError,[mbAbort],0);
    iMin := 0;
  end;//except

  //Calculate litres
  spnLitres.Value := objGenerator.CalculateLiters(iMin);
  if spnLitres.Value = 100000 then
    iBut := MessageDlg('You''ve reached the maximum amount of liters. You cannot have more than 100000 liters.',mtInformation,[mbOk],0);

end;

//------------------------------\\
// Calculate Units Button Click \\
//------------------------------\\
procedure TfrmNormalUser.btnElecCalcUnitsClick(Sender: TObject);
var
  rPrice : Real;
  iBut : Integer;
begin
  //For Try Except to work in Delphi itself: Tools > Options > Debugger Options ? Enbarcadero Debuggers > Language Exceptions > Notify on language exceptions (OFF)
  //Try Except works when using the Executable file.
  //Validation
  try
    rPrice := StrToFloat(InputBox('Calculate the amount of Units you use','Enter the Amount you paid for electricity, in your own chosen time period. '+#10+'e.g. If you paid R 700.99, type only 700.99','00.00'));
  except
    iBut := MessageDlg('You entered an invalid Amount. To avoid this error, Make sure to only enter the Amount you paid as a number. Do not use other text such as the currency''s symbol, spaces, etc.',mtError,[mbAbort],0);
    rPrice := 0;
  end;//except

  //Calculate units
  spnUnits.Value := CalculateUnits(rPrice);
  if spnUnits.Value = 100000 then
    iBut := MessageDlg('You''ve reached the maximum amount of units. You cannot have more than 100000 units.',mtInformation,[mbOk],0);
end;

//-----------------------------\\
// DateOfSubmission Help Click \\
//-----------------------------\\
procedure TfrmNormalUser.btnElecDOSOneHelpClick(Sender: TObject);
begin
  CarbonFootprint1_u.frmSignupLogin.LoadHelp('DateOfSubmission');
end;

//----------------------------\\
// Add Generator Button Click \\
//----------------------------\\
procedure TfrmNormalUser.btnElecGenAddClick(Sender: TObject);
var
  sName, sBrand, sType, sValidError, sEmissionType, sEmission : String;
  rCapacity, rEmissions : Real;
  bValid, bSpace, bFound : Boolean;
  k, iBut : Integer;
begin
  //Input
  sName := edtElecName.Text;
  sBrand := edtElecBrand.Text;
  sType := cmbElecGenType.Items[cmbElecGenType.ItemIndex];

  //Validation: Generator Add
  bValid := True;
  sValidError := '';
{$REGION 'Name validation'}
  if sName = '' then //If name is empty
  begin
    sValidError := sValidError + 'Please enter a Generator Name. The Generator Name field is required to add it to the database. To avoid this error, make sure you enter a Generator Name.'+#10+#10;
    bValid := False;
  end//if sName := ''
  else
  if length(sName) < 3 then //If name is too short
  begin
    sValidError := sValidError + 'The Generator Name is too short. The entered Generator Name is shorter than the characters required. To avoid this error, please enter a username with at least 3 characters.'+#10+#10;
    bValid := False;
  end;//if length(sName) < 6

  if length(sName) > 20 then //If name is too long
  begin
    sValidError := sValidError + 'The Generator Name is too long. The entered Generator Name is longer than the character limit. To avoid this error, please enter a Generator Name with a maximum of 20 characters or fewer.'+#10+#10;
    bValid := False;
  end;//if length(sName) > 30
{$ENDREGION}
{$REGION 'Brand validation'}
  if sBrand = '' then //If brand is empty
  begin
    sValidError := sValidError + 'Please enter a Generator Brand. The Generator Brand field is required to add it to the database. To avoid this error, make sure you enter a valid Generator Brand.'+#10+#10;
    bValid := False;
  end;//if sBrand := ''

  bSpace := False;
  for k := 1 to length(sBrand) do //If brand contains space
  begin
    if sBrand[k] = ' ' then
    begin
      bSpace := True;
    end;//if sBrand[k] = ' '
  end;//for k := 1 to length(sBrand)
  if bSpace = True then
  begin
    sValidError := sValidError + 'Please remove any spaces from the Generator Brand. The entered Generator Brand contains one or more spaces, which are not allowed. To avoid this error, please remove any spaces from the Generator Brand (also check the last digit).'+#10+#10;
    bValid := False;
  end;

  if length(sBrand) < 3 then //If brand too short
  begin
    sValidError := sValidError + 'The Generator Brand is too short. The entered Generator Brand is shorter than the characters required. To avoid this error, please enter a Generator Brand with at least 3 characters.'+#10+#10;
    bValid := False;
  end;//if length(sBrand) < 6

  if length(sBrand) > 20 then //If brand too long
  begin
    sValidError := sValidError + 'The Generator Brand is too long. The entered username is longer than the character limit. To avoid this error, please enter a Generator Brand with a maximum of 20 characters or fewer.'+#10+#10;
    bValid := False;
  end;//if length(sBrand) > 30
{$ENDREGION}
{$REGION 'Type validation'}
  if cmbElecGenType.ItemIndex = -1 then //If no type selected
  begin
    sValidError := sValidError + 'Please select the Generator Type you reside in. The Generator Type field is required to add this generator to the database. To avoid this error, make sure you select a Generator Type from the dropdown list.'+#10+#10;
    bValid := False;
  end;//if cmbSignupCountries.ItemIndex = -1
{$ENDREGION}
{$REGION 'First validation error message'}
  if bValid = False then //Show error message if there's anything wrong with the fields
  begin
    sValidError := sValidError + 'Please make the necessary changes and try again. There may be more errors.';
    iBut := MessageDlg(sValidError,mtError,[mbAbort],0);
    Exit;
  end;//if bValid = False
  sValidError := '';
  bValid := True;
{$ENDREGION}

{$REGION 'Generator Capacity validation and input'}
  //For Try Except to work in Delphi itself: Tools > Options > Debugger Options ? Enbarcadero Debuggers > Language Exceptions > Notify on language exceptions (OFF)
  //Try Except works when using the Executable file.
  try
    rCapacity := StrToFloat(edtElecCap.Text);
  except //If invalid Capacity
    iBut := MessageDlg('You entered an invalid Generator Capacity. To avoid this error, Make sure to only enter the Generator Capacity as a number. Do not use other text such as the symbols, spaces, etc.',mtError,[mbAbort],0);
    Exit;
  end;//except
{$ENDREGION}
{$REGION 'Generator Emissions validation and input'}
  //For Try Except to work in Delphi itself: Tools > Options > Debugger Options ? Enbarcadero Debuggers > Language Exceptions > Notify on language exceptions (OFF)
  //Try Except works when using the Executable file.
  try
    rEmissions := StrToFloat(edtElecEmissions.Text);
  except //If invalid Emissions
    iBut := MessageDlg('You entered an invalid Generator Emissions value. To avoid this error, Make sure to only enter the Generator Emissions value as a number. Do not use other text such as the symbols, spaces, etc.',mtError,[mbAbort],0);
    Exit;
  end;//except
{$ENDREGION}


{$REGION 'Database validation'}
  //Instantiate the Object & Retrieved the generator's Emission Type
  objGenerator := TGenerator.Create(sName, sBrand, sType, rCapacity, rEmissions);

  sEmissionType := objGenerator.CreateEmissionType;

  //Loop though database
  bFound := False;
  try
    dmCarbonFootprint.tblEmission.First;
    while NOT(dmCarbonFootprint.tblEmission.EOF) AND (bFound = False) do
    begin
      if dmCarbonFootprint.tblEmission['EmissionType'] = sEmissionType then //If emmission type is already there
      begin
        //Display an error
        bFound := True;
        sValidError := sValidError + 'The Emission Type is already used in the database. The entered Generator (and Emission Type) cannot be used. To avoid this error, please enter a different Generator (or make slight alterations to the current one) to add it to the database.'+#10+#10;
        bValid := False;
      end else//if dmCarbonFootprint.tblUsers['Username'] = sUsername
      begin
        dmCarbonFootprint.tblEmission.Next;
      end;//else of if dmCarbonFootprint.tblUsers['Username'] = sUsername
    end;//while NOT(dmCarbonFootprint.tblUsers.EOF) AND (bFound = False)

    //Loop though database
    bFound := False;
    dmCarbonFootprint.tblGenerator.First;
    while NOT(dmCarbonFootprint.tblGenerator.EOF) AND (bFound = False) do
    begin
      if (dmCarbonFootprint.tblGenerator['GenName'] = sName) AND (dmCarbonFootprint.tblGenerator['GenBrand'] = sBrand) then //If name & brand is used together already
      begin
        bFound := True;
        sValidError := sValidError + 'The Generator and Brand is already used in the database together.'+' The entered Generator Name and Brand cannot be used. To avoid this error, please enter a different Generator Name and/or Brand (or make slight alterations to the current ones) to add it to the database.'+#10+#10;
        bValid := False;
      end else//if dmCarbonFootprint.tblUsers['Username'] = sUsername
      begin
        dmCarbonFootprint.tblGenerator.Next;
      end;//else of if dmCarbonFootprint.tblUsers['Username'] = sUsername
  end;//while NOT(dmCarbonFootprint.tblUsers.EOF) AND (bFound = False)
  except
    iBut := MessageDlg('Something went wrong during Database validation. Please contact a Developer to fix this error.',mtError,[mbAbort],0);
    Exit;
  end;
{$ENDREGION}
{$REGION 'Second validation error message'}
  if bValid = False then //Show error message if there's anything wrong with the fields
  begin
    sValidError := sValidError + 'Please make the necessary changes and try again. There may be more errors.';
    iBut := MessageDlg(sValidError,mtError,[mbAbort],0);
    Exit;
  end;//if bValid = False
  sValidError := '';
{$ENDREGION}

  //Processing
  try
    //Post into tblEmission
    dmCarbonFootprint.tblEmission.Insert;
    dmCarbonFootprint.tblEmission['EmissionType'] := sEmissionType;
    dmCarbonFootprint.tblEmission['CO2Emission'] := rEmissions;
    dmCarbonFootprint.tblEmission.Post;

    //Post into tblGenerator
    dmCarbonFootprint.tblGenerator.Insert;
    dmCarbonFootprint.tblGenerator['GenName'] := sName;
    dmCarbonFootprint.tblGenerator['GenBrand'] := sBrand;
    dmCarbonFootprint.tblGenerator['Type'] := sType;
    dmCarbonFootprint.tblGenerator['Capacity'] := rCapacity;
    dmCarbonFootprint.tblGenerator['EmissionType'] := sEmissionType;
    dmCarbonFootprint.tblGenerator.Post;

    //Reload generators into cmbGenerator
    dmCarbonFootprint.tblGenerator.First;
    cmbGenerator.Items.Clear;
    while NOT dmCarbonFootprint.tblGenerator.EOF do
    begin
      if Copy(dmCarbonFootprint.tblGenerator['EmissionType'],1,1) = 'G' then
      begin
        sEmission := dmCarbonFootprint.tblGenerator['EmissionType'];
        sEmission := Copy(sEmission,3,Length(sEmission)-2);
        cmbGenerator.Items.Add(sEmission);
      end;//if dmCarbonFootprint.tblGenerator['EmissionType'][1] = 'E'
      dmCarbonFootprint.tblGenerator.Next;
    end;//while NOT dmCarbonFootprint.tblGenerator.EOF

    //Select the generator added by default
    sEmission := sEmissionType;
    sEmission := Copy(sEmission,3,Length(sEmission)-2);
    cmbGenerator.ItemIndex := cmbGenerator.Items.IndexOf(sEmission);

    //Go back to the previous panel
    with pnlElecTwo do
    begin
      Enabled := False;
      Visible := False;
    end;
    with pnlElecThree do
    begin
      Enabled := True;
      Visible := True;
    end;
    edtElecName.Clear;
    edtElecBrand.Clear;cmbElecGenType.ItemIndex := -1;
    edtElecCap.Clear;
    edtElecEmissions.Clear;

    redElecGen.Lines.Clear;
    redElecGen.Paragraph.TabCount := 1;
    redElecGen.Paragraph.Tab[0] := 65;
    redElecGen.Lines.Add(objGenerator.ToString);

    btnSubmitGen.Visible := True;
    btnSubmitGen.Font.Color := clSilver;
    btnSubmitGen.Enabled := False;
    pnlCalcGen.Visible := True;

  except
    iBut := MessageDlg('Something went wrong while adding the Generator to the database. Please contact a Developer to fix this error.',mtError,[mbAbort],0);
    Exit;
  end;


end;

//------------------------\\
// Electricity Help Click \\
//------------------------\\
procedure TfrmNormalUser.btnElecHelpClick(Sender: TObject);
begin
  CarbonFootprint1_u.frmSignupLogin.LoadHelp('Electricity');
end;

//-----------------------------\\
// Expand Graph Button Click \\
//-----------------------------\\
procedure TfrmNormalUser.btnExpandClick(Sender: TObject);
begin
  if btnExpand.Caption = 'Expand 📊' then //If the graph can be expanded
  begin
    with pnlGraph do //Make the panel bigger
    begin
      Width := 1192;
      Height := 433;
      Left := 16;
      Top := 168;
    end;

    with chrGraph do //Make the graph bigger
    begin
      Width := 1161;
      Height := 378;
      Left := 16;
      Top := 39;
    end;

    with lblGraphTitle do //Make the title bigger
    begin
      Width := 1193;
    end;

    with btnExpand do //Change the caption
    begin
      Caption := 'Shrink 📊';
    end;
  end else//if
  begin //If the graph can be shrunk
    with pnlGraph do //Make the panel smaller
    begin
      Width := 593;
      Height := 433;
      Left := 615;
      Top := 168;
    end;

    with chrGraph do //Make the graph smaller
    begin
      Width := 561;
      Height := 378;
      Left := 16;
      Top := 39;
    end;

    with lblGraphTitle do //Make the lable smaller
    begin
      Width := 593;
    end;

    with btnExpand do //Change the caption
    begin
      Caption := 'Expand 📊';
    end;
  end;//else


end;

//------------------------------\\
// Generation Method Help Click \\
//------------------------------\\
procedure TfrmNormalUser.btnGenerationMethodHelpClick(Sender: TObject);
begin
  CarbonFootprint1_u.frmSignupLogin.LoadHelp('GenerationMethod');
end;

//----------------------------------\\
// Go to Add Generator Button Click \\
//----------------------------------\\
procedure TfrmNormalUser.btnGeneratorAddClick(Sender: TObject);
begin
  with pnlElecTwo do //Show generator add panel
  begin
    Enabled := True;
    Visible := True;
  end;
  with pnlElecThree do //Hide original panel
  begin
    Enabled := False;
    Visible := False;
  end;

  //Reset panel
  edtElecName.SetFocus;
  cmbGenerator.ItemIndex := -1;
  redElecGen.Lines.Clear;
  spnLitres.Value := 0;
  dtpElecDateThree.Date := Date;
  edtElecName.SetFocus;

  pnlCalcGen.Visible := False;
  btnSubmitGen.Visible := False;
end;

//-----------------------------------------\\
// Go Back from Add Generator Button Click \\
//-----------------------------------------\\
procedure TfrmNormalUser.btnGeneratorBackClick(Sender: TObject);
begin
  with pnlElecTwo do //Hide add panel
  begin
    Enabled := False;
    Visible := False;
  end;
  with pnlElecThree do //Show original panel
  begin
    Enabled := True;
    Visible := True;
  end;

  //Reset panel
  edtElecName.Clear;
  edtElecBrand.Clear;
  cmbElecGenType.ItemIndex := -1;
  cmbElecGenType.Text := 'Select Generator Type';
  edtElecCap.Clear;
  edtElecEmissions.Clear;

  pnlCalcGen.Visible := True;
  pnlCalcGen.Caption := '';
  btnSubmitGen.Visible := True;
  btnSubmitGen.Font.Color := clSilver;
  btnSubmitGen.Enabled := False;

end;

//---------------------------------------------------\\
// Calculate Generator Carbon Footprint Button Click \\
//---------------------------------------------------\\
procedure TfrmNormalUser.btnGeneratorCalcClick(Sender: TObject);
var
  sEmm : String;
  iLitres, iBut : Integer;
  rEmm, rResult : Real;
begin
  //Input
  sEmm := cmbGenerator.Items[cmbGenerator.ItemIndex];
  iLitres := spnLitres.Value;
  rEmm := 0;

  //Validation
  if cmbGenerator.ItemIndex = -1 then //If no generator selected
  begin
    iBut := MessageDlg('You must select a generator from the combo box. Please select the generator, and try again.',mtError,[mbAbort],0);
    Exit;
  end;//if bValid = False
  if iLitres < 1 then //If 0 liters consumed
  begin
    iBut := MessageDlg('You must have used at least 1 litre to calculate your carbon footprint. Please enter the amount of litres used, and try again.',mtError,[mbAbort],0);
    Exit;
  end;//if bValid = False 

  //Calculate emissions using object
  objGenerator.SetConsumed(iLitres);
  rResult := objGenerator.CalculateEmissions;

  //Display in panel
  pnlCalcGen.Caption := FloatToStrF(rResult,ffFixed,10,2)+'kg CO2e';
  btnSubmitGen.Enabled := True;

  //Can now submit to database
  btnSubmitGen.Font.Color := clWhite;
  btnSubmitGen.Enabled := True;
end;

//--------------------------------\\
// Go Back from Tips Button Click \\
//--------------------------------\\
procedure TfrmNormalUser.btnGoBackClick(Sender: TObject);
begin
  //Show panels
  pnlEntry.Visible := True;
  pnlEntry.Enabled := True;

  pnlGraph.Visible := True;
  pnlGraph.Enabled := True;

  //Hide panels
  pnlTips.Visible := False;
  pnlTips.Enabled := False;
end;

//----------------------------------------------\\
// Calculate Main Carbon Footprint Button Click \\
//----------------------------------------------\\
procedure TfrmNormalUser.btnMainGridCalcClick(Sender: TObject);
var
  sEmm : String;
  iUnits, iBut : Integer;
  rEmm, rResult : Real;
begin
  //Input
  sEmm := cmbElectricity.Items[cmbElectricity.ItemIndex];
  iUnits := spnUnits.Value;
  rEmm := 0;

  //Validation
  if iUnits < 1 then //If 0 litres used
  begin
    iBut := MessageDlg('You must have used at least 1 unit to calculate your carbon footprint. Please enter the amount of units used, and try again.',mtError,[mbAbort],0);
    Exit;
  end;//if bValid = False
  if cmbElectricity.ItemIndex = -1 then //If no emission type selected
  begin
    iBut := MessageDlg('You must select a generation method from the combo box. Please select the generation method, and try again.',mtError,[mbAbort],0);
    Exit;
  end;//if bValid = False

  //Locate the amount emitted per unit
  dmCarbonFootprint.tblEmission.First;
  while NOT dmCarbonFootprint.tblEmission.EOF do
  begin
    if dmCarbonFootprint.tblEmission['EmissionType'] = 'E '+sEmm then
    begin
      rEmm := dmCarbonFootprint.tblEmission['CO2Emission'];
    end;//if dmCarbonFootprint.tblEmission['EmissionType'][1] = 'E'
    dmCarbonFootprint.tblEmission.Next;
  end;//while NOT dmCarbonFootprint.tblEmission.EOF

  rResult := iUnits * rEmm;

  //Display in panel
  pnlCalcMain.Caption := FloatToStrF(rResult,ffFixed,10,2)+'kg CO2e';
  btnSubmitMain.Enabled := True;

  //Can now submit
  btnSubmitMain.Font.Color := clWhite;
  btnSubmitMain.Enabled := True;
end;

//-------------------------\\
// Reset Main Button Click \\
//-------------------------\\
procedure TfrmNormalUser.btnOneResetClick(Sender: TObject);
var
  sEmission : String;
begin
  //Reset values
  spnUnits.Value := 0;
  spnUnits.SetFocus;

  //If user is from SA, make Eskom the default Emission Type
  cmbElectricity.ItemIndex := 0;
  if (dmCarbonFootprint.tblUsers['Country'] = 'South Africa') AND (dmCarbonFootprint.tblUsers['Username'] = frmSignupLogin.sLoggedIn) then
  begin
    cmbElectricity.ItemIndex := cmbElectricity.Items.IndexOf('Eskom');
    sEmission := cmbElectricity.Items[cmbElectricity.ItemIndex];
    dmCarbonFootprint.tblEmission.First;
    //Show the Emission type's emission in the label
    while NOT dmCarbonFootprint.tblEmission.EOF do
    begin
      if dmCarbonFootprint.tblEmission['EmissionType'] = 'E '+sEmission then
      begin
        lblElecInfo.Visible := True;
        lblElecInfo.Caption := 'Carbon Emission: '+FloatToStrF(dmCarbonFootprint.tblEmission['CO2Emission'],ffFixed,6,3)+'kg CO2e per Unit';
      end;//if dmCarbonFootprint.tblEmission['EmissionType'][1] = 'E'
      dmCarbonFootprint.tblEmission.Next;
    end;//while NOT dmCarbonFootprint.tblEmission.EOF
  end;

  //Reset date & label
  dtpElecDate.Date := Date;
  with lblElecDateInfo do
  begin
    Caption := '(i) Recommendation: Keep this as is';
    Font.Color := rgb(64,64,64);
    Visible := True;
  end;//with lblElecDateInfo

  //Reset panels and buttons
  pnlCalcMain.Caption := '';
  btnSubmitMain.Enabled := False;
  btnSubmitMain.Font.Color := clSilver;

end;

procedure TfrmNormalUser.btnPrintClick(Sender: TObject);
var
  iBut : Integer;
begin
  if MessageDlg('Note: Your Default printer will be used to print the Tips as it is at this moment.'+' Are you sure you want to continue?',mtWarning,[mbYes, mbNo],0) = mrNo then
  begin
    iBut := MessageDlg('The rich edit was not printed.',mtError,[mbOk],0);
    Exit;
  end;

  redTips.Print('Carbon Footprint tips '+TimeToStr(Now()));
  iBut := MessageDlg('Print command sent to default printer',mtInformation,[mbOk],0);
end;

//------------------------------------------------\\
// Submit Generator Carbon Footprint Button Click \\
//------------------------------------------------\\
procedure TfrmNormalUser.btnSubmitGenClick(Sender: TObject);
var
  iHigh, iNew, iLitres, iBut : Integer;
  sEmm : String;
  dSubmit : TDate;
  rResult : Real;
begin
  try
  //Input
  iHigh := -1;
  sEmm := 'G '+cmbGenerator.Items[cmbGenerator.ItemIndex];
  dSubmit := dtpElecDateThree.Date;
  iLitres := spnLitres.Value;  

  dmCarbonFootprint.tblElectricity.Sort := 'Username ASC, Entry ASC';

  //Locate the user's highest entry in the database
  dmCarbonFootprint.tblElectricity.First;
  while NOT  dmCarbonFootprint.tblElectricity.EOF do
  begin
    if (dmCarbonFootprint.tblElectricity['Username'] = frmSignupLogin.sLoggedIn) AND (dmCarbonFootprint.tblElectricity['Entry'] > iHigh) then
    begin
      iHigh := dmCarbonFootprint.tblElectricity['Entry'];
    end;//if
    dmCarbonFootprint.tblElectricity.Next;
  end;//while NOT  dmCarbonFootprint.tblElectricity.EOF

  iNew := iHigh+1; //Add 1 to get the new entry no
  rResult := objGenerator.CalculateEmissions;

  //Insert into tblElectricity
  dmCarbonFootprint.tblElectricity.Insert;
  dmCarbonFootprint.tblElectricity['Username'] := frmSignupLogin.sLoggedIn;
  dmCarbonFootprint.tblElectricity['Entry'] := iNew;
  dmCarbonFootprint.tblElectricity['Unit'] := iLitres;
  dmCarbonFootprint.tblElectricity['Emitted'] := rResult;
  dmCarbonFootprint.tblElectricity['EmissionType'] := sEmm;
  dmCarbonFootprint.tblElectricity['EmissionAtSubmission'] := objGenerator.GetEmission;
  dmCarbonFootprint.tblElectricity['DateSubmitted'] := DateOf(dSubmit);
  dmCarbonFootprint.tblElectricity.Post;
  dmCarbonFootprint.tblElectricity.Sort := 'Username ASC, Entry ASC';
  
  except
    iBut := MessageDlg('Something went wrong during Submission. Please contact a Developer to fix this error.',mtError,[mbAbort],0);
    Exit;
  end;//except

  //Display confirmation
  iBut := MessageDlg('Carbon emission of '+FloatToStrF(rResult,ffFixed,10,3)+'kg ('+Copy(sEmm,3)+') CO2e saved into Database!',mtInformation,[mbOk],0);
  btnSubmitGen.Font.Color := clSilver;
  btnSubmitGen.Enabled := False;
  //Reset some components
  spnLitres.Value := 0;
  dtpElecDate.Date := Date;
  pnlCalcGen.Caption := '';

  //Update graph and rich edit
  DisplayEntries;
end;

//-------------------------------------------\\
// Submit Main Carbon Footprint Button Click \\
//-------------------------------------------\\
procedure TfrmNormalUser.btnSubmitMainClick(Sender: TObject);
var
  iHigh, iNew, iUnits, iBut : Integer;
  sEmm : String;
  dSubmit : TDate;
  rEmm, rResult : Real;
begin
  try
  //Input
  iHigh := -1;
  rEmm := 0;
  sEmm := 'E '+cmbElectricity.Items[cmbElectricity.ItemIndex];
  dSubmit := dtpElecDate.Date;
  iUnits := spnUnits.Value;  

  dmCarbonFootprint.tblElectricity.Sort := 'Username ASC, Entry ASC';
  //Locate the user's highest entry in the database
  dmCarbonFootprint.tblElectricity.First;
  while NOT  dmCarbonFootprint.tblElectricity.EOF do
  begin
    if (dmCarbonFootprint.tblElectricity['Username'] = frmSignupLogin.sLoggedIn) AND (dmCarbonFootprint.tblElectricity['Entry'] > iHigh) then
    begin
      iHigh := dmCarbonFootprint.tblElectricity['Entry'];
    end;//if
    dmCarbonFootprint.tblElectricity.Next;    
  end;//while NOT  dmCarbonFootprint.tblElectricity.EOF

  //Retrive how much is emitted for the emission type
  dmCarbonFootprint.tblEmission.First;
  while NOT dmCarbonFootprint.tblEmission.EOF do
  begin
    if dmCarbonFootprint.tblEmission['EmissionType'] = sEmm then
    begin
      rEmm := dmCarbonFootprint.tblEmission['CO2Emission'];
    end;//if dmCarbonFootprint.tblEmission['EmissionType'][1] = 'E'
    dmCarbonFootprint.tblEmission.Next;
  end;//while NOT dmCarbonFootprint.tblEmission.EOF

  iNew := iHigh+1;
  rResult := iUnits * rEmm;

  //Insert into tblElectricity
  dmCarbonFootprint.tblElectricity.Insert;
  dmCarbonFootprint.tblElectricity['Username'] := frmSignupLogin.sLoggedIn;
  dmCarbonFootprint.tblElectricity['Entry'] := iNew;
  dmCarbonFootprint.tblElectricity['Unit'] := iUnits;
  dmCarbonFootprint.tblElectricity['Emitted'] := rResult;
  dmCarbonFootprint.tblElectricity['EmissionType'] := sEmm;
  dmCarbonFootprint.tblElectricity['EmissionAtSubmission'] := rEmm;
  dmCarbonFootprint.tblElectricity['DateSubmitted'] := DateOf(dSubmit);
  dmCarbonFootprint.tblElectricity.Post;
  dmCarbonFootprint.tblElectricity.Sort := 'Username ASC, Entry ASC';
  
  except
    iBut := MessageDlg('Something went wrong during Submission. Please contact a Developer to fix this error.',mtError,[mbAbort],0);
    Exit;
  end;//except

  //Show succesful message
  iBut := MessageDlg('Carbon emission of '+FloatToStrF(rResult,ffFixed,10,3)+'kg CO2e (from '+Copy(sEmm,3)+') saved into Database!',mtInformation,[mbOk],0);
  btnSubmitMain.Font.Color := clSilver;
  btnSubmitMain.Enabled := False;

  //Reset compontents
  spnUnits.Value := 0;
  dtpElecDate.Date := Date;
  with lblElecDateInfo do
  begin
    Caption := '(i) Recommendation: Keep this as is';
    Font.Color := rgb(64,64,64);
    Visible := True;
  end;//with lblElecDateInfo
  pnlCalcMain.Caption := '';

  DisplayEntries;
end;

//-------------------------------\\
// Reset Generation Button Click \\
//-------------------------------\\
procedure TfrmNormalUser.btnThreeResetClick(Sender: TObject);
begin
  //Reset components
  cmbGenerator.ItemIndex := -1;
  cmbGenerator.Text := 'Select Generator';
  cmbGenerator.SetFocus;
  redElecGen.Lines.Clear;

  spnLitres.Value := 0;

  //Reset label
  dtpElecDateThree.Date := Date;
  with lblElecDateInfoThree do
  begin
    Caption := '(i) Recommendation: Keep this as is';
    Font.Color := rgb(64,64,64);
  end;//with lblElecDateInfoThree

  pnlCalcGen.Caption := '';
  btnSubmitGen.Enabled := False;
  btnSubmitGen.Font.Color := clSilver;
end;

//-------------------------\\
// Go to tips Button Click \\
//-------------------------\\
procedure TfrmNormalUser.btnTipsClick(Sender: TObject);
begin
  //SHow tips panel
  pnlTips.Visible := True;
  pnlTips.Enabled := True;

  //Hide other panels
  pnlEntry.Visible := False;
  pnlEntry.Enabled := False;

  pnlGraph.Visible := False;
  pnlGraph.Enabled := False;
end;

//----------------------------------\\
// Reset Add Generator Button Click \\
//----------------------------------\\
procedure TfrmNormalUser.btnTwoResetClick(Sender: TObject);
begin
  //Reset components
  edtElecName.Clear;
  edtElecBrand.Clear;cmbElecGenType.ItemIndex := -1;
  cmbElecGenType.Text := 'Select Generator Type';
  edtElecCap.Clear;
  edtElecEmissions.Clear;
  edtElecName.SetFocus;
end;

//---------------------\\
// Update Button Click \\
//---------------------\\
procedure TfrmNormalUser.btnUpdateClick(Sender: TObject);
begin
  DisplayEntries;
end;

//--------------------\\
// Welcome Help Click \\
//--------------------\\
procedure TfrmNormalUser.btnWelcHelpClick(Sender: TObject);
begin
  CarbonFootprint1_u.frmSignupLogin.LoadHelp('Welcome');
end;

//------------------------------------------\\
// User Declared Procedure: Display Entries \\
//------------------------------------------\\
//Use this procedure to update all output components
Procedure TfrmNormalUser.DisplayEntries;
var
  iEntries, iTotalEntries, iFactCount, k : Integer;
  rTotal, rSumEntries, r25Below, r25Above, r50Below, r50Above, r75Below, r75Above, rAvg: Real;
  sEmm, sStatus : String;
begin
  //Initialise
  iEntries := -1;
  iTotalEntries := 0;
  rTotal := 0;
  rSumEntries := 0;
  sEmm := '';

  //Rich edit: Tab stops
  redEntry.Lines.Clear;
  redEntry.Paragraph.TabCount := 4;
  redEntry.Paragraph.Tab[0] := 20;
  redEntry.Paragraph.Tab[1] := 90;
  redEntry.Paragraph.Tab[2] := 180;
  redEntry.Paragraph.Tab[3] := 350;

  //Format & Add headings
  redEntry.SelAttributes.Style := [fsBold, fsUnderline];
  redEntry.SelAttributes.Color := rgb(25,51,0);
  redEntry.SelAttributes.Size := 12;
  redEntry.Lines.Add('No'+#9+'Date'+#9+'CO2e Emitted'+#9+'Emission Type'+#9+'Total'+#9+'      '+#10);

  //Chart: Reset lines
  chrGraph.Series[0].Clear;
  chrGraph.Series[1].Clear;

  //Set title and series colours and names of chart
  chrGraph.Title.Caption := 'Carbon Footprint';
  with chrGraph do
  begin
    Series[0].Title := 'Total';
    Series[0].Color := clRed;
    Series[1].Title := 'Individual';
    Series[1].Color := clGreen;
  end;//with

  //Go through the database
  dmCarbonFootprint.tblElectricity.Sort := 'Username ASC, DateSubmitted ASC';
  dmCarbonFootprint.tblElectricity.First;
  while NOT dmCarbonFootprint.tblElectricity.EOF do
  begin
    rSumEntries := rSumEntries + dmCarbonFootprint.tblElectricity['Emitted']; //Add to the total emitted of all entries
    if (dmCarbonFootprint.tblElectricity['Entry'] = 1) then
    begin
      inc(iTotalEntries); //Increases how many users there are with CF > 0
    end;
    if (dmCarbonFootprint.tblElectricity['Username'] = frmSignupLogin.sLoggedIn) then //If username is the same as the logged in person
    begin
      inc(iEntries);//Increase person's entries
      with dmCarbonFootprint do
      begin
        rTotal := rTotal + tblElectricity['Emitted']; //Increase person's total CF
        chrGraph.Series[0].AddXY(iEntries,rTotal); //Add point to graph (Total)
        chrGraph.Series[1].AddXY(iEntries,tblElectricity['Emitted']); //Add point to graph (Individual)

        //If it's the user's first entry (i.e. sign-up)
        if tblElectricity['Entry'] = 0 then
        begin
          //Change format and add text
          redEntry.SelAttributes.Style := [fsItalic];
          redEntry.SelAttributes.Color := clGray;
          redEntry.Lines.Add(IntToStr(iEntries)+'.'+ #9 + FormatDateTime('dd mmm',tblElectricity['DateSubmitted'])+' ’'+Copy(FormatDateTime('yyyy',tblElectricity['DateSubmitted']),3,2) +#9+ 'Sign up date' +#9+'None'+#9+FloatToStrF(rTotal,ffFixed,10,2)+' kg');
        end//if
        else
        //If not the first entry
        begin
          sEmm := Copy(tblElectricity['EmissionType'],3);
        end;//else
        //Display in rich edit
        if tblElectricity['Entry'] <> 0 then
          redEntry.Lines.Add(IntToStr(iEntries)+'.' +#9+ FormatDateTime('dd mmm',tblElectricity['DateSubmitted'])+' ’'+Copy(FormatDateTime('yyyy',tblElectricity['DateSubmitted']),3,2) +#9+ FloatToStrF(tblElectricity['Emitted'],FFFixed,10,2) + ' kg' +#9
            + sEmm +#9+ FloatToStrF(rTotal,ffFixed,10,2)+' kg');
      end;//with dmCarbonFootprint
    end;//if
    dmCarbonFootprint.tblElectricity.Next;
  end;//while NOT  dmCarbonFootprint.tblElectricity.EOF


  if iTotalEntries <> 0 then
    rAvg := rSumEntries / iTotalEntries; //Average Carbon Footprint;

  //Update outputs
  pnlCarbonFootprint.Caption := FloatToStrF(rTotal,FFFixed,10,2)+' kg';
  pnlAverageCF.Caption := FloatToStrF(rAvg,FFFixed,10,2)+' kg';

  //Tips Rich Edit
  redTips.Lines.Clear;

  //Add & format heading
  redTips.SelAttributes.Style := [fsBold, fsUnderline];
  redTips.SelAttributes.Color := rgb(25,51,0);
  redTips.SelAttributes.Size := 15;
  redTips.Lines.Add('Your Carbon Footprint:');

  redTips.Lines.Add('Your Total Carbon Footprint is '+FloatToStrF(rTotal,ffFixed,10,3)+ ' kg of CO2e');
  //redTips.Lines.Add('It is '+LowerCase(sStatus)+' Carbon Footprint of our userbase.');
  redTips.Lines.Add('The Average Carbon Footprint of our userbase is '+FloatToStrF(rAvg,ffFixed,10,3)+' kg of CO2e');

  //Calculate where the user's CF is compared to others
  r25Below := (1 - 0.25) * rAvg;
  r25Above := (1 + 0.25) * rAvg;
  r50Below := (1 - 0.5) * rAvg;
  r50Above := (1 + 0.5) * rAvg;
  r75Below := (1 - 0.75) * rAvg;
  r75Above := (1 + 0.75) * rAvg;

  //Display in panel output, and rich edit
  if rTotal <= r75Below then
  begin
    sStatus := '75+% below the average';
    pnlStatusColor.Color := rgb(0,102,0);
    objFactLoader := TFactLoader.Create('Very Low');
    redTips.SelAttributes.Color := rgb(0,102,0);
    redTips.Lines.Add('This means that your Carbon Footprint is Exceptionally Low compared to other users! Congratulations');
  end
  else
  if (rTotal > r75Below) and (rTotal <= r50Below) then
  begin
    sStatus := '50-75% below the average';
    pnlStatusColor.Color := rgb(0,153,0);
    objFactLoader := TFactLoader.Create('Low');
    redTips.SelAttributes.Color := rgb(9,129,9);
    redTips.Lines.Add('This means that your Carbon Footprint is Quite Low compared to other users! Congratulations');
  end
  else
  if (rTotal > r50Below) and (rTotal <= r25Below) then
  begin
    sStatus := '25-50% below the average';
    pnlStatusColor.Color := rgb(0,204,0);
    objFactLoader := TFactLoader.Create('Slightly Below');
    redTips.SelAttributes.Color := rgb(21,148,21);
    redTips.Lines.Add('This means that your Carbon Footprint is Slightly Below other users.');
  end
  else
  if (rTotal > r25Below) and (rTotal <= r25Above) then
  begin
    sStatus := 'Within 25% of the average';
    pnlStatusColor.Color := rgb(204,204,0);
    objFactLoader := TFactLoader.Create('Average');
    redTips.SelAttributes.Color := rgb(193,142,0);
    redTips.Lines.Add('This means that your Carbon Footprint is Similar to other users.');
  end
  else
  if (rTotal > r25Above) and (rTotal <= r50Above) then
  begin
    sStatus := '25-50% above the average';
    pnlStatusColor.Color := rgb(204,0,0);
    objFactLoader := TFactLoader.Create('Slightly Above');
    redTips.SelAttributes.Color := rgb(204,0,0);
    redTips.Lines.Add('This means that your Carbon Footprint is Slightly Above other users. Try to reduce it using the tips below!');
  end
  else
  if (rTotal > r50Above) and (rTotal <= r75Above) then
  begin
    sStatus := '50-75% above the average';
    pnlStatusColor.Color := rgb(153,0,0);
    objFactLoader := TFactLoader.Create('High');
    redTips.SelAttributes.Color := rgb(153,0,0);
    redTips.Lines.Add('This means that your Carbon Footprint is High compared to other users. Try to reduce it using the tips below!');
  end
  else
  if rTotal > r75Above then
  begin
    sStatus := '75+% above the average';
    pnlStatusColor.Color := rgb(102,0,0);
    objFactLoader := TFactLoader.Create('Very High');
    redTips.SelAttributes.Color := rgb(102,0,0);
    redTips.Lines.Add('This means that your Carbon Footprint is Exceptionally High compared to other users! Try to reduce it using the tips below.');
  end;

  pnlStatus.Caption := sStatus;

  //Add & Display heading
  redTips.SelAttributes.Style := [fsBold, fsUnderline];
  redTips.SelAttributes.Color := rgb(25,51,0);
  redTips.SelAttributes.Size := 15;
  redTips.Lines.Add(#10+'Tips to Reduce your Carbon Footprint:');

  //Load tips and headings into rich edit
  iFactCount := objFactLoader.GetFactCount;

  for k := 1 to iFactCount do
  begin
    redTips.SelAttributes.Style := [fsBold];
    redTips.Lines.Add(objFactLoader.GetNextHeading);
    redTips.Lines.Add(objFactLoader.GetNextFact+#10);
  end;//for

  {redV4.Clear;
  redV4.SelAttributes.Style := [fsBold];
  redV4.Lines.Add('Kalender vir ' + cmbMaande.Text + #13);
  sAfvoer := '';
  for iTel := 1 to 7 do
  begin
    sAfvoer := sAfvoer + arrDae[iTel] + #9;
  end;
  redV4.SelAttributes.Style := [fsBold];
  redV4.Lines.Add(sAfvoer);}

  {dmCarbonFootprint.tblGenerator.First;
    bFound2 := False;
    while NOT(dmCarbonFootprint.tblGenerator.EOF) AND (bFound2 = False) do
    begin
      if dmCarbonFootprint.tblGenerator['EmissionType'] = 'G '+sEmissionType then
      begin
        bFound2 := True;
        rCapacity := dmCarbonFootprint.tblGenerator['Capacity'];
        sName := dmCarbonFootprint.tblGenerator['GenName'];
        sBrand := dmCarbonFootprint.tblGenerator['GenBrand'];
        sType := dmCarbonFootprint.tblGenerator['Type'];
      end else//if dmCarbonFootprint.tblUsers['Username'] = sUsername
      begin
        dmCarbonFootprint.tblGenerator.Next;
      end;//else of if dmCarbonFootprint.tblUsers['Username'] = sUsername
    end;//while NOT(dmCarbonFootprint.tblUsers.EOF) AND (bFound = False)}



end;

//-----------------------------------------\\
// User Declared Function: Calculate Units \\
//-----------------------------------------\\
//Use this function to calculate the amount of units used, according to the Eskom pricing system
function TfrmNormalUser.CalculateUnits(rPrice: Real): Integer;
const
  Block1Price = 1.7901; // Price for the first 50 units
  Block2Price = 2.3017; // Price for units 51-350
  Block3Price = 3.1227; // Price for units 351-600
  Block4Price = 3.7480; // Price for more than 600 units
var
  rUnits: Real;
begin
  if rPrice <= Block1Price * 50 then //If in Block 1
  begin
    rUnits := rPrice / Block1Price;
  end//if rPrice <= Block1Price * 50
  else
  if rPrice <= Block1Price * 50 + Block2Price * 300 then //If in Block 2
  begin
    rUnits := 50 + (rPrice - Block1Price * 50) / Block2Price;
  end//if rPrice <= Block1Price * 50 + Block2Price * 300
  else
  if rPrice <= Block1Price * 50 + Block2Price * 300 + Block3Price * 250 then //If in Block 3
  begin
    rUnits := 350 + (rPrice - Block1Price * 50 - Block2Price * 300) / Block3Price;
  end// if rPrice <= Block1Price * 50 + Block2Price * 300 + Block3Price * 250
  else
  begin //If in Block 4
    rUnits := 600 + (rPrice - Block1Price * 50 - Block2Price * 300 - Block3Price * 250) / Block4Price;
  end;//else

  //Return units
  Result := Ceil(rUnits);
end;

//------------------------------\\
// Electricity Combo Box Change \\
//------------------------------\\
procedure TfrmNormalUser.cmbElectricityChange(Sender: TObject);
var
  sEmm : String;
begin
//Validation
  if cmbElectricity.ItemIndex = -1 then
  begin
    lblElecInfo.Visible := False;
    Exit;
  end;

  //Input
  sEmm := cmbElectricity.Items[cmbElectricity.ItemIndex];
  lblElecInfo.Visible := True;

  //Locate emission type in database
  dmCarbonFootprint.tblEmission.Sort := 'CO2Emission ASC';
  dmCarbonFootprint.tblEmission.First;
  while NOT dmCarbonFootprint.tblEmission.EOF do
  begin
    if dmCarbonFootprint.tblEmission['EmissionType'] = 'E '+sEmm then
    begin
      //Display amount of CO2e emitted in database
      lblElecInfo.Caption := 'Carbon Emission: '+FloatToStrF(dmCarbonFootprint.tblEmission['CO2Emission'],ffFixed,6,3)+'kg CO2e per Unit';
    end;//if dmCarbonFootprint.tblEmission['EmissionType'][1] = 'E'
    dmCarbonFootprint.tblEmission.Next;
  end;//while NOT dmCarbonFootprint.tblEmission.EOF

  btnSubmitMain.Font.Color := clSilver;
  btnSubmitMain.Enabled := False;
end;

//----------------------------\\
// Generator Combo Box Change \\
//----------------------------\\
procedure TfrmNormalUser.cmbGeneratorChange(Sender: TObject);
var
  sEmissionType, sName, sBrand, sType : String;
  bFound, bFound2 : Boolean;
  iBut : Integer;
  rEmissions, rCapacity : Real;
begin
  //Validation
  if cmbGenerator.ItemIndex = -1 then
    Exit;

  //objGenerator.Free;
  //Input
  sEmissionType := cmbGenerator.Items[cmbGenerator.ItemIndex];

  try
    //Locate generator in Database
    dmCarbonFootprint.tblEmission.First;
    bFound := False;
    while NOT(dmCarbonFootprint.tblEmission.EOF) AND (bFound = False) do
    begin
      if dmCarbonFootprint.tblEmission['EmissionType'] = 'G '+sEmissionType then
      begin
        //Get emissions
        bFound := True;
        rEmissions := dmCarbonFootprint.tblEmission['CO2Emission'];
      end else//if dmCarbonFootprint.tblUsers['Username'] = sUsername
      begin
        dmCarbonFootprint.tblEmission.Next;
      end;//else of if dmCarbonFootprint.tblUsers['Username'] = sUsername
    end;//while NOT(dmCarbonFootprint.tblUsers.EOF) AND (bFound = False)

    dmCarbonFootprint.tblGenerator.First;
    bFound2 := False;
    while NOT(dmCarbonFootprint.tblGenerator.EOF) AND (bFound2 = False) do
    begin
      if dmCarbonFootprint.tblGenerator['EmissionType'] = 'G '+sEmissionType then
      begin
        //Get other info
        bFound2 := True;
        rCapacity := dmCarbonFootprint.tblGenerator['Capacity'];
        sName := dmCarbonFootprint.tblGenerator['GenName'];
        sBrand := dmCarbonFootprint.tblGenerator['GenBrand'];
        sType := dmCarbonFootprint.tblGenerator['Type'];
      end else//if dmCarbonFootprint.tblUsers['Username'] = sUsername
      begin
        dmCarbonFootprint.tblGenerator.Next;
      end;//else of if dmCarbonFootprint.tblUsers['Username'] = sUsername
    end;//while NOT(dmCarbonFootprint.tblUsers.EOF) AND (bFound = False)

    if (bFound = FALSE) or (bFound2 = False) then
    begin
      iBut := MessageDlg('Something went wrong during while trying to locate the Generator in the Database. Please contact a Developer to fix this error.',mtError,[mbAbort],0);
      Exit;
    end;

    //Create object
    objGenerator := TGenerator.Create(sName, sBrand, sType, rCapacity, rEmissions);

    //Clear and add to rich edit
    redElecGen.Lines.Clear;
    redElecGen.Paragraph.TabCount := 1;
    redElecGen.Paragraph.Tab[0] := 65;
    redElecGen.Lines.Add(objGenerator.ToString);
  except
    iBut := MessageDlg('Something went wrong during while trying to locate the Generator in the Database. Please contact a Developer to fix this error.',mtError,[mbAbort],0);
    Exit;
  end;
  btnSubmitGen.Font.Color := clSilver;
  btnSubmitGen.Enabled := False;
  
end;

//------------------------\\
// Electricity DTP Change \\
//------------------------\\
procedure TfrmNormalUser.dtpElecDateChange(Sender: TObject);
var
  dDOB : TDate;
begin
  //Input
  dDOB := dtpElecDate.Date;

  //Update label
  if FormatDateTime('dd mm yyyy',dDOB) = FormatDateTime('dd mm yyyy',Date) then
  begin
    with lblElecDateInfo do
      begin
        Caption := '(i) Recommendation: Keep this as is';
        Font.Color := rgb(64,64,64);
        Visible := True;
      end;//with lblElecDateInfo
      Exit;
  end;//if

  if CompareDate(Date,dDOB) < 0 then
  begin
    with lblElecDateInfo do
      begin
        Caption := '(i) We don''t recommend a Future Date';
        Font.Color := rgb(255,153,0);
        Visible := True;
      end;//with lblElecDateInfo
      Exit;
  end;//if

  with lblElecDateInfo do
  begin
    Caption := '(i) Be careful when using Past Dates';
    Font.Color := rgb(255,153,0);
    Visible := True;
  end;//with lblElecDateInfo

  btnSubmitMain.Font.Color := clSilver;
  btnSubmitMain.Enabled := False;
end;

//------------------------\\
// Generator DTP Change \\
//------------------------\\
procedure TfrmNormalUser.dtpElecDateThreeChange(Sender: TObject);
var
  dDOB : TDate;
begin
  //Input
  dDOB := dtpElecDateThree.Date;

  //Update label
  if FormatDateTime('dd mm yyyy',dDOB) = FormatDateTime('dd mm yyyy',Date) then
  begin
    with lblElecDateInfoThree do
      begin
        Caption := '(i) Recommendation: Keep this as is';
        Font.Color := rgb(64,64,64);
        Visible := True;
      end;//with lblElecDateInfoThree
      Exit;
  end;//if

  if CompareDate(Date,dDOB) < 0 then
  begin
    with lblElecDateInfoThree do
      begin
        Caption := '(i) We don''t recommend a Future Date';
        Font.Color := rgb(255,153,0);
        Visible := True;
      end;//with lblElecDateInfoThree
      Exit;
  end;//if

  with lblElecDateInfoThree do
  begin
    Caption := '(i) Be careful when using Past Dates';
    Font.Color := rgb(255,153,0);
    Visible := True;
  end;//with lblElecDateInfoThree

  btnSubmitGen.Font.Color := clSilver;
  btnSubmitGen.Enabled := False;
  
end;

//---------------------------------------------\\
// Form Activated: Change Component Properties \\
//---------------------------------------------\\
procedure TfrmNormalUser.FormActivate(Sender: TObject);
var
  sEmission : String;
begin
{$REGION 'Normal User Form'}
  with frmNormalUser do
  begin
    //
    Width := 1246;
    Height := 744;
    Caption := 'Carbon Footprint Calculator';
  end; // with frmNormalUser

  with pnlTitle do
  begin
    // Title Panel Properties
    Color := rgb(143, 232, 62);
    Font.Color := clBlack;
    Font.Size := 30;
    Font.Style := [fsBold];
    Font.Name := 'Arial Black';
    // Change the Title Panel's Text here
    Caption := 'Carbon Footprint Calculator';
  end; // with pnlTitle

  with pgcNormalUser do
  begin
    Top := 57;
    Left := -2;
  end; // with pgcNormalUser

  pgcNormalUser.ActivePage := tbsWelcome;

{$ENDREGION}

{$REGION 'Welcome Tab sheet'}
  with pnlEntry do
  begin
    Color := rgb(205,205,205);
  end;

  with pnlGraph do
  begin
    Color := rgb(205,205,205);
  end;

  with pnlCarbonFootprint do
  begin
    Color := rgb(64,64,64);
    Font.Color := clWhite;
    Caption := '0 kg';
  end;

  with pnlAverageCF do
  begin
    Color := rgb(64,64,64);
    Font.Color := clWhite;
    Caption := '';
  end;

  with pnlStatus do
  begin
    Color := rgb(64,64,64);
    Font.Color := clWhite;
    Caption := '';
  end;

  with btnTips do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with btnGoBack do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with btnExpand do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with btnWelcHelp do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with lblWelcomeTitle do
  begin
    Caption := 'Welcome '+dmCarbonFootprint.tblUsers['FirstName'];
  end;//with btnSignup

  with btnPrint do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup
{$ENDREGION}

{$REGION 'Electricity Tab sheet'}
  with pnlElecOne do
  begin
    Color := rgb(205,205,205);
  end;

  with pnlCalcMain do
  begin
    Color := rgb(64,64,64);
    Font.Color := clWhite;
  end;
  
  with pnlCalcGen do
  begin
    Color := rgb(64,64,64);
    Font.Color := clWhite;
  end;

  with pnlElecTwo do
  begin
    Color := rgb(205,205,205);
    Top := 144;
    Left := 615;
    Enabled := False;
    Visible := False;
  end;

  with pnlElecThree do
  begin
    Color := rgb(205,205,205);
    Top := 144;
    Left := 615;
    Top := 144;
    Left := 615;
    Enabled := True;
    Visible := True;
  end;

  with lblOneTitle do
  begin
    Width := 593;
  end;

  with lblTwoTitle do
  begin
    Width := 593;
  end;

  with btnElecCalcUnits do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with btnElecHelp do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with btnOneReset do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with btnTwoReset do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with btnThreeReset do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with btnGenerationMethodHelp do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with btnElecDOSOneHelp do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with btnSubmitMain do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clSilver;
  end;//with btnSignup

  with btnSubmitGen do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clSilver;
  end;//with btnSignup

  with btnElecGenAdd do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with btnGeneratorAdd do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with btnGeneratorBack do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with btnElecCalcLiters do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with btnDOSThreeHelp do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with lblElecDateInfo do
  begin
    Caption := '(i) Recommendation: Keep this as is';
    Font.Color := rgb(64,64,64);
    Visible := True;
  end;//with lblElecDateInfo

  dtpElecDate.Date := Date;

  with lblElecDateInfoThree do
  begin
    Caption := '(i) Recommendation: Keep this as is';
    Font.Color := rgb(64,64,64);
    Visible := True;
  end;//with lblElecDateInfo

  with lblElecInfo do
  begin
    Visible := False;
    Font.Color := rgb(64,64,64);
  end;//with lblElecDateInfo

  with btnMainGridCalc do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with btnGeneratorCalc do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  dtpElecDateThree.Date := Date;

  cmbElectricity.ItemIndex := 0;
  dmCarbonFootprint.tblEmission.Sort := 'CO2Emission ASC';
  dmCarbonFootprint.tblEmission.First;
  while NOT dmCarbonFootprint.tblEmission.EOF do
  begin
    if Copy(dmCarbonFootprint.tblEmission['EmissionType'],1,1) = 'E' then
    begin
      sEmission := dmCarbonFootprint.tblEmission['EmissionType'];
      sEmission := Copy(sEmission,3,Length(sEmission)-2);
      cmbElectricity.Items.Add(sEmission);
    end;//if dmCarbonFootprint.tblEmission['EmissionType'][1] = 'E'
    dmCarbonFootprint.tblEmission.Next;
  end;//while NOT dmCarbonFootprint.tblEmission.EOF
  if dmCarbonFootprint.tblUsers['Country'] = 'South Africa' then
  begin
    cmbElectricity.ItemIndex := cmbElectricity.Items.IndexOf('Eskom');
    sEmission := cmbElectricity.Items[cmbElectricity.ItemIndex];
    dmCarbonFootprint.tblEmission.First;
    while NOT dmCarbonFootprint.tblEmission.EOF do
    begin
      if dmCarbonFootprint.tblEmission['EmissionType'] = 'E '+sEmission then
      begin
        lblElecInfo.Visible := True;
        lblElecInfo.Caption := 'Carbon Emission: '+FloatToStrF(dmCarbonFootprint.tblEmission['CO2Emission'],ffFixed,6,3)+'kg CO2e per Unit';
      end;//if dmCarbonFootprint.tblEmission['EmissionType'][1] = 'E'
      dmCarbonFootprint.tblEmission.Next;
    end;//while NOT dmCarbonFootprint.tblEmission.EOF
  end;

  dmCarbonFootprint.tblGenerator.First;
  while NOT dmCarbonFootprint.tblGenerator.EOF do
  begin
    if Copy(dmCarbonFootprint.tblGenerator['EmissionType'],1,1) = 'G' then
    begin
      sEmission := dmCarbonFootprint.tblGenerator['EmissionType'];
      sEmission := Copy(sEmission,3,Length(sEmission)-2);
      cmbGenerator.Items.Add(sEmission);
    end;//if dmCarbonFootprint.tblGenerator['EmissionType'][1] = 'E'
    dmCarbonFootprint.tblGenerator.Next;
  end;//while NOT dmCarbonFootprint.tblGenerator.EOF


{$ENDREGION}

  DisplayEntries;
end;

//-------------------------\\
// Liters Spin Edit Change \\
//-------------------------\\
procedure TfrmNormalUser.spnLitresChange(Sender: TObject);
begin
  //Not submittable
  btnSubmitGen.Font.Color := clSilver;
  btnSubmitGen.Enabled := False;
end;

//------------------------\\
// Units Spin Edit Change \\
//------------------------\\
procedure TfrmNormalUser.spnUnitsChange(Sender: TObject);
begin
  //Not submittable
  btnSubmitMain.Font.Color := clSilver;
  btnSubmitMain.Enabled := False;
end;

end.
