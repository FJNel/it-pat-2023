unit Admin_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Spin, TeEngine, Series, TeeProcs, Chart, ExtCtrls,
  dmCarbonFootprint_u, Grids, DBGrids, Printers, DateUtils, clsGenerator_u, jpeg;

type
  TfrmAdmin = class(TForm)
    pnlTitle: TPanel;
    pgcAdmin: TPageControl;
    tbsGenerationMethod: TTabSheet;
    lblGenTitle: TLabel;
    pnlGenOne: TPanel;
    lblGenOneTitle: TLabel;
    dbgElec: TDBGrid;
    pnlGenTwo: TPanel;
    lblTwoEmm: TLabel;
    lblTwoUsername: TLabel;
    lblTwoDate: TLabel;
    lblTwoAnd: TLabel;
    btnEmmDisplay: TPanel;
    cmbEmmType: TComboBox;
    btnTwoDisplay: TPanel;
    btnTwoReset: TPanel;
    dtpGenDateOne: TDateTimePicker;
    btnDateDisplay: TPanel;
    cmbUsername: TComboBox;
    btnUsernameDisplay: TPanel;
    dtpGenDateTwo: TDateTimePicker;
    pnlGenThree: TPanel;
    lnlThreeCF: TLabel;
    lblThreeTitl: TLabel;
    lblCountry: TLabel;
    lblThreeUsername: TLabel;
    btnCaclDisplay: TPanel;
    cmbThreeCalc: TComboBox;
    btnThreeReset: TPanel;
    cmbCountry: TComboBox;
    btnCountryDisplay: TPanel;
    cmbOperator: TComboBox;
    spnCalc: TSpinEdit;
    cmbUsernameThree: TComboBox;
    btnUserSummDisplay: TPanel;
    tbsGeneration: TTabSheet;
    lblEditTitle: TLabel;
    pnlFour: TPanel;
    lblGenName: TLabel;
    lblGenBrand: TLabel;
    lblFourTitle: TLabel;
    lblGeneratorType: TLabel;
    lblGenCap: TLabel;
    lblGenEmi: TLabel;
    lblGenType: TLabel;
    cmbGenType: TComboBox;
    edtGenName: TEdit;
    edtGenBrand: TEdit;
    edtGenEmi: TEdit;
    edtGenCap: TEdit;
    btnGenEdit: TPanel;
    btnGenReset: TPanel;
    cmbGenerator: TComboBox;
    btnGenDelete: TPanel;
    pnlFive: TPanel;
    lblEmi: TLabel;
    lblFiveTitle: TLabel;
    lblEmiType: TLabel;
    lblEmiType2: TLabel;
    lblEmi2: TLabel;
    edtEmiEmitted: TEdit;
    btnEmiEdit: TPanel;
    btnEmiReset: TPanel;
    cmbEmiType: TComboBox;
    edtEmiEmm: TEdit;
    edtEmiEmitted2: TEdit;
    btnEmiAdd: TPanel;
    btnViewHelp: TPanel;
    btnEditHelp: TPanel;
    pnlSix: TPanel;
    lblSixTitle: TLabel;
    btnRedUpdate: TPanel;
    pnlSeven: TPanel;
    redInfo: TRichEdit;
    imgFootprint: TImage;
    imgFootprint2: TImage;
    btnRedPrint: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure btnEmmDisplayClick(Sender: TObject);
    procedure LoadEmmType; //User defined
    procedure LoadUsername; //User defined
    procedure LoadRichEdit; //User defined
    procedure ElecFill; //User defined
    procedure LoadCountry; //User defined
    procedure LoadGenerator; //User defined
    procedure ResetGen; //User defined
    procedure ResetEmi; //User defined
    procedure btnDateDisplayClick(Sender: TObject);
    procedure btnUsernameDisplayClick(Sender: TObject);
    procedure btnTwoResetClick(Sender: TObject);
    procedure btnTwoDisplayClick(Sender: TObject);
    procedure btnCaclDisplayClick(Sender: TObject);
    procedure btnCountryDisplayClick(Sender: TObject);
    procedure btnUserSummDisplayClick(Sender: TObject);
    procedure btnThreeResetClick(Sender: TObject);
    procedure btnGenEditClick(Sender: TObject);
    procedure cmbGeneratorChange(Sender: TObject);
    procedure btnGenDeleteClick(Sender: TObject);
    procedure btnGenResetClick(Sender: TObject);
    procedure cmbEmiTypeChange(Sender: TObject);
    procedure btnEmiEditClick(Sender: TObject);
    procedure btnEmiAddClick(Sender: TObject);
    procedure btnEmiResetClick(Sender: TObject);
    procedure btnEditHelpClick(Sender: TObject);
    procedure btnViewHelpClick(Sender: TObject);
    procedure btnRedUpdateClick(Sender: TObject);
    procedure btnRedPrintClick(Sender: TObject);
  private
    { Private declarations }
    objGenerator : TGenerator;
  public
    { Public declarations }
  end;

var
  frmAdmin: TfrmAdmin;

implementation

uses CarbonFootprint1_u;

{$R *.dfm}

//----------------------------------\\
// Calculation Display Button Click \\
//----------------------------------\\
procedure TfrmAdmin.btnCaclDisplayClick(Sender: TObject);
var
  sCalcType, sOp : String;
  iBut, iVal : integer;
begin
  //Validation
  if cmbThreeCalc.ItemIndex = -1 then //If no info selected
  begin
    iBut := MessageDlg('Please select a calculation type. The calculation type field is required. To avoid this error, make sure you select a calculation type from the dropdown list.',mtError,[mbAbort],0);
    Exit;
  end;//if cmbSignupCountries.ItemIndex = -1
  if cmbOperator.ItemIndex = -1 then  //If no operator selected
  begin
    iBut := MessageDlg('Please select an operator. The operator field is required. To avoid this error, make sure you select a operator from the dropdown list.',mtError,[mbAbort],0);
    Exit;
  end;//if cmbSignupCountries.ItemIndex = -1

  //Input
  sCalcType := cmbThreeCalc.Items[cmbThreeCalc.ItemIndex];
  sOp := cmbOperator.Items[cmbOperator.ItemIndex];
  iVal := spnCalc.Value;

  //SQL Statement
  with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT Username, ROUND('+sCalcType+'(Emitted),3) AS ['+sCalcType+' Calculation in kg] FROM tblElectricity WHERE (Emitted <> 0) GROUP BY Username HAVING ROUND('+sCalcType+'(Emitted),3) '+sOp+' '+IntToStr(iVal)+' ORDER BY Username ASC';
    qryElectricity.Open;
  end;

end;

//---------------------------\\
// Date Display Button Click \\
//---------------------------\\
procedure TfrmAdmin.btnDateDisplayClick(Sender: TObject);
var
  cOption : Char;
  dDateOne, dDateTwo : TDate;
  iBut : Integer;
begin
  //Input
  dDateOne := dtpGenDateOne.Date;
  dDateTwo := dtpGenDateTwo.Date;

  //Compare dates
  if CompareDate(dDateOne,dDateTwo) < 0 then //If DateOne is Before DateTwo
  begin
  //SQL Statement
  with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT * FROM tblElectricity WHERE DateSubmitted >= #'+DateToStr(dDateOne)+'# AND DateSubmitted <= #'+DateToStr(dDateTwo)+'# ORDER BY Username ASC, DateSubmitted ASC';
    qryElectricity.Open;
  end;//with
  end;//if

  if CompareDate(dDateOne,dDateTwo) > 0 then //If DateOne is After DateTwo
  begin
  //SQL Statement
  with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT * FROM tblElectricity WHERE DateSubmitted >= #'+DateToStr(dDateTwo)+'# AND DateSubmitted <= #'+DateToStr(dDateOne)+'# ORDER BY Username ASC, DateSubmitted ASC';
    qryElectricity.Open;
  end;//with
  end;//if

  if CompareDate(dDateOne,dDateTwo) = 0 then //If DateOne is DateTwo
  begin
  //SQL Statement
  with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT * FROM tblElectricity WHERE DateSubmitted = #'+DateToStr(dDateOne)+'# ORDER BY Username ASC, DateSubmitted ASC';
    qryElectricity.Open;
  end;//with
  end;//if

end;

//---------------------------\\
// Add Emission Button Click \\
//---------------------------\\
procedure TfrmAdmin.btnEmiAddClick(Sender: TObject);
var
  sEmm, sValidError : String;
  iBut, k : Integer;
  rEmm : Real;
  bFound, bValid, bSpace : Boolean;
begin
  //Input
  sEmm := edtEmiEmm.Text;

  bValid := True;
  sValidError := '';
  //Validation
{$REGION 'Emission validation'}
  if sEmm = '' then //If emission is blank
  begin
    sValidError := sValidError + 'Please enter an Emission Type Name. The Emission Type Name field is required to add it to the database. To avoid this error, make sure you enter a valid Emission Type Name.'+#10+#10;
    bValid := False;
  end//if sEmm := ''
  else
  if length(sEmm) < 3 then //If emission is too short
  begin
    sValidError := sValidError + 'The Emission Type Name is too short. The entered Emission Type Name is shorter than the characters required. To avoid this error, please enter an Emission Type Name with at least 3 characters.'+#10+#10;
    bValid := False;
  end;//if length(sEmm) < 6

  bSpace := False;
  for k := 1 to length(sEmm) do //If emission contains spaces
  begin
    if sEmm[k] = ' ' then
    begin
      bSpace := True;
    end;//if sEmm[k] = ' '
  end;//for k := 1 to length(sEmm)
  if bSpace = True then
  begin
    sValidError := sValidError + 'Please remove any spaces from the Emission Type Name. The entered Emission Type Name contains one or more spaces, which are not allowed. To avoid this error, please remove any spaces from the Emission Type Name (also check the last digit).'+#10+#10;
    bValid := False;
  end;

  if length(sEmm) > 48 then //If emission too long
  begin
    sValidError := sValidError + 'The Emission Type Name is too long. The entered Emission Type Name is longer than the character limit. To avoid this error, please enter a Emission Type Name with a maximum of 20 characters or fewer.'+#10+#10;
    bValid := False;
  end;//if length(sEmm) > 30
{$ENDREGION}
{$REGION 'First validation error message'}
  if bValid = False then //Error if any information is incorrect
  begin
    sValidError := sValidError + 'Please make the necessary changes and try again. There may be more errors.';
    iBut := MessageDlg(sValidError,mtError,[mbAbort],0);
    Exit;
  end;//if bValid = False
  sValidError := '';
  bValid := True;
{$ENDREGION}

  try
    rEmm := StrToFloat(edtEmiEmitted2.Text);
  except
    iBut := MessageDlg('You entered an invalid CO2e Emitted. To avoid this error, Make sure to only enter the CO2e Emitted as a number. Do not use other text such as the symbols, spaces, etc.',mtError,[mbAbort],0);
    Exit;
  end;//except

  //Processing
  try
  with dmCarbonFootprint do
  begin
    //Post to database
    tblEmission.Insert;
    tblEmission['EmissionType'] := 'E '+sEmm;
    tblEmission['CO2Emission'] := rEmm;
    tblEmission.Post;
  end
  except
    iBut := MessageDlg('Something went wrong while adding to the database. Please contact a Developer to fix this error.',mtError,[mbAbort],0);
    Exit;
  end;

  //Output
  iBut := MessageDlg(sEmm+' has been added sucessfully!',mtInformation,[mbOk],0);
  ResetEmi;

end;

//----------------------------\\
// Edit Emission Button Click \\
//----------------------------\\
procedure TfrmAdmin.btnEmiEditClick(Sender: TObject);
var
  sEmm : String;
  iBut : Integer;
  rEmm : Real;
  bFound : Boolean;
begin
  //Input
  sEmm := cmbEmiType.Items[cmbEmiType.ItemIndex];

  //Validation
  if cmbEmiType.ItemIndex = -1 then //If no emission selected
  begin
    iBut := MessageDlg('Please select an emission type. The Emission Type field is required to edit the database. To avoid this error, make sure you select an emission type.',mtError,[mbAbort],0);
    Exit;
  end;

  try
    rEmm := StrToFloat(edtEmiEmitted.Text);
  except
    iBut := MessageDlg('You entered an invalid CO2e Emitted. To avoid this error, Make sure to only enter the CO2e Emitted as a number. Do not use other text such as the symbols, spaces, etc.',mtError,[mbAbort],0);
    Exit;
  end;//except

  //Processing
  bFound := False;
  try
    //Locate emission type in database
    dmCarbonFootprint.tblEmission.First;
    while NOT(dmCarbonFootprint.tblEmission.EOF) AND (bFound = False) do
    begin
      if dmCarbonFootprint.tblEmission['EmissionType'] = sEmm then
      begin
        bFound := True;
        //Edit in database
        dmCarbonFootprint.tblEmission.Edit;
        //dmCarbonFootprint.tblEmission['EmissionType'] := sEmissionType;
        dmCarbonFootprint.tblEmission['CO2Emission'] := rEmm;
        dmCarbonFootprint.tblEmission.Post;
      end else//if dmCarbonFootprint.tblUsers['Username'] = sUsername
      begin
        dmCarbonFootprint.tblEmission.Next;
      end;//else of if dmCarbonFootprint.tblUsers['Username'] = sUsername
    end;//while NOT(dmCarbonFootprint.tblUsers.EOF) AND (bFound = False)

    if bFound = False then
    begin
      iBut := MessageDlg('The emission type could not be found in the database. Please contact a Developer to fix this error.',mtError,[mbAbort],0);
      Exit;
    end;

  except
    iBut := MessageDlg('Something went wrong when editing the database. Please contact a Developer to fix this error.',mtError,[mbAbort],0);
    Exit;
  end;

  iBut := MessageDlg(sEmm+' has been edited sucessfully!',mtInformation,[mbOk],0);
  ResetEmi;


end;

//----------------------------------\\
// Emission Add/Edit Reset Click \\
//----------------------------------\\
procedure TfrmAdmin.btnEmiResetClick(Sender: TObject);
begin
  ResetEmi;

end;

//-------------------------------\\
// Emission Display Button Click \\
//-------------------------------\\
procedure TfrmAdmin.btnEmmDisplayClick(Sender: TObject);
var
  sEmm : String;
  iBut : integer;
begin
  //Validation
  if cmbEmmType.ItemIndex = -1 then //If no emission selected
  begin
    iBut := MessageDlg('Please select an emission type to filter by. The emission type field is required to display this information. To avoid this error, make sure you select an emission type from the dropdown list.',mtError,[mbAbort],0);
    Exit;
  end;//if cmbSignupCountries.ItemIndex = -1

  //Input
  sEmm := cmbEmmType.Items[cmbEmmType.ItemIndex];

  //SQL Statement
  with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT * FROM tblElectricity WHERE EmissionType = "'+sEmm+'" ORDER BY Username ASC, DateSubmitted ASC';
    qryElectricity.Open;
  end;


end;

//----------------------------------\\
// Country Display Button Click \\
//----------------------------------\\
procedure TfrmAdmin.btnCountryDisplayClick(Sender: TObject);
var
  sCountry : String;
  iBut : integer;
begin
  //Validation
  if cmbCountry.ItemIndex = -1 then //If no country selected
  begin
    iBut := MessageDlg('Please select a country. The country field is required to display this information. To avoid this error, make sure you select a country from the dropdown list.',mtError,[mbAbort],0);
    Exit;
  end;//if cmbSignupCountries.ItemIndex = -1

  //Input
  sCOuntry := cmbCountry.Items[cmbCountry.ItemIndex];

  //SQL Statement
  with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT B.* FROM tblElectricity AS B INNER JOIN tblUsers AS A ON B.Username = A.Username WHERE A.Country = "'+sCountry+'" ORDER BY B.Username ASC, B.DateSubmitted ASC';
    qryElectricity.Open;
  end;

end;

//-------------------------\\
// Calculation Reset Click \\
//-------------------------\\
procedure TfrmAdmin.btnThreeResetClick(Sender: TObject);
begin
  //Reset components
  LoadUsername;
  LoadCountry;

  cmbThreeCalc.ItemIndex := -1;
  cmbThreeCalc.Text := 'Calc';
  cmbOperator.ItemIndex := -1;
  cmbOperator.Text := 'Operator';
  cmbCountry.ItemIndex := -1;
  cmbCountry.Text := 'Select Country';
  cmbUsernameThree.ItemIndex := -1;
  cmbUsernameThree.Text := 'Select Username';

  ElecFill;

end;

//------------------------------\\
// Calculation All Button Click \\
//------------------------------\\
procedure TfrmAdmin.btnTwoDisplayClick(Sender: TObject);
var
  iBut : Integer;
  sEmm, sUsername : String;
  dDateOne, dDateTwo : TDate;
begin
  //Validation
  if cmbEmmType.ItemIndex = -1 then //No emission type selected
  begin
    iBut := MessageDlg('Please select an emission type to filter by. The emission type field is required to display this information. To avoid this error, make sure you select an emission type from the dropdown list.',mtError,[mbAbort],0);
    Exit;
  end;//if cmbSignupCountries.ItemIndex = -1

  if cmbUsername.ItemIndex = -1 then //No username celected
  begin
    iBut := MessageDlg('Please select a username type to filter by. The username field is required to display this information. To avoid this error, make sure you select a username from the dropdown list.',mtError,[mbAbort],0);
    Exit;
  end;//if cmbSignupCountries.ItemIndex = -1

  //Input
  sEmm := cmbEmmType.Items[cmbEmmType.ItemIndex];
  dDateOne := dtpGenDateOne.Date;
  dDateTwo := dtpGenDateTwo.Date;
  sUserName := cmbUsername.Items[cmbUsername.ItemIndex];

  //Processing and SQL statement
  //Compare dates
  if CompareDate(dDateOne,dDateTwo) < 0 then //If DateOne is Before DateTwo
  begin
  //SQL Statement
  with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT * FROM tblElectricity WHERE DateSubmitted >= #'+DateToStr(dDateOne)+'# AND DateSubmitted <= #'+DateToStr(dDateTwo)+'# AND Username = "'+sUsername+'" AND EmissionType = "'+sEmm+'" ORDER BY Username ASC, DateSubmitted ASC';
    qryElectricity.Open;
  end;//with
  end;//if

  if CompareDate(dDateOne,dDateTwo) > 0 then //If DateOne is After DateTwo
  begin
  //SQL Statement
  with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT * FROM tblElectricity WHERE DateSubmitted >= #'+DateToStr(dDateTwo)+'# AND DateSubmitted <= #'+DateToStr(dDateOne)+'# AND Username = "'+sUsername+'" AND EmissionType = "'+sEmm+'" ORDER BY Username ASC, DateSubmitted ASC';
    qryElectricity.Open;
  end;//with
  end;//if

  if CompareDate(dDateOne,dDateTwo) = 0 then //If DateOne is DateTwo
  begin
  //SQL Statement
  with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT * FROM tblElectricity WHERE DateSubmitted = #'+DateToStr(dDateOne)+'# AND Username = "'+sUsername+'" AND EmissionType = "'+sEmm+'" ORDER BY Username ASC, DateSubmitted ASC';
    qryElectricity.Open;
  end;//with
  end;//if
end;

//---------------------\\
// Panel 1 Reset Click \\
//---------------------\\
procedure TfrmAdmin.btnTwoResetClick(Sender: TObject);
begin
  //Reset components
  LoadEmmType;
  LoadUsername;
  dtpGenDateOne.Date := Date;
  dtpGenDateTwo.Date := Date;
end;

//----------------------------------\\
// Username Display Button Click \\
//----------------------------------\\
procedure TfrmAdmin.btnUsernameDisplayClick(Sender: TObject);
var
  sUserName : String;
  iBut : integer;
begin
  if cmbUsername.ItemIndex = -1 then //No username selected
  begin
    iBut := MessageDlg('Please select a username. The username field is required to display this information. To avoid this error, make sure you select a username from the dropdown list.',mtError,[mbAbort],0);
    Exit;
  end;//if cmbSignupCountries.ItemIndex = -1

  sUserName := cmbUsername.Items[cmbUsername.ItemIndex];

  //SQL Statement
  with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT * FROM tblElectricity WHERE Username = "'+sUsername+'" ORDER BY Username ASC, DateSubmitted ASC';
    qryElectricity.Open;
  end;
end;

//-----------------------------\\
// Summarise User Button Click \\
//-----------------------------\\
procedure TfrmAdmin.btnUserSummDisplayClick(Sender: TObject);
var
  sUserName : String;
  iBut : integer;
begin
  if cmbUsernameThree.ItemIndex = -1 then //If no username selected
  begin
    iBut := MessageDlg('Please select a username. The username field is required to display this information. To avoid this error, make sure you select a username from the dropdown list.',mtError,[mbAbort],0);
    Exit;
  end;//if cmbSignupCountries.ItemIndex = -1

  //Input
  sUserName := cmbUsernameThree.Items[cmbUsernameThree.ItemIndex];

  //SQL Statement
  with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT Username, ROUND(SUM(Emitted),3) AS '+'[SUM of Emissions in kg], ROUND(AVG(Emitted),3) AS [AVERAGE Emission in kg], ROUND(MIN(Emitted),3) AS [MINIMUM Emission in kg], ROUND(MAX(Emitted),3) AS [MAXIMUM Emission in kg] FROM tblElectricity WHERE (Username = "'+sUsername+'") AND (Emitted <> 0) GROUP BY Username';
    //qryElectricity.SQL.Text := 'SELECT Username, ROUND('+sCalcType+'(Emitted),3) AS ['+sCalcType+' Calculation in kg] FROM tblElectricity WHERE (Emitted <> 0) GROUP BY Username HAVING ROUND('+sCalcType+'(Emitted),3) '+sOp+' '+IntToStr(iVal)+' ORDER BY Username ASC';
    qryElectricity.Open;
  end;

end;

//-----------------\\
// View Help Click \\
//-----------------\\
procedure TfrmAdmin.btnViewHelpClick(Sender: TObject);
begin
  CarbonFootprint1_u.frmSignupLogin.LoadHelp('View');
end;

//-------------------------------------------\\
// Emission Type Combo Box Change: Load Edit \\
//-------------------------------------------\\
procedure TfrmAdmin.cmbEmiTypeChange(Sender: TObject);
var
  sEmissionType : String;
  iBut : Integer;
  bFound : Boolean;
begin
  if cmbEmiType.ItemIndex = -1 then
    Exit;

  //Input
  sEmissionType := cmbEmiType.Items[cmbEmiType.ItemIndex];

  try
    //Locate in database
    dmCarbonFootprint.tblEmission.First;
    bFound := False;
    while NOT(dmCarbonFootprint.tblEmission.EOF) AND (bFound = False) do
    begin
      if dmCarbonFootprint.tblEmission['EmissionType'] = sEmissionType then
      begin
        bFound := True;
        //Change edit
        edtEmiEmitted.Text := FloatToStrF(dmCarbonFootprint.tblEmission['CO2Emission'],ffFixed,10,3);
      end else//if dmCarbonFootprint.tblUsers['Username'] = sUsername
      begin
        dmCarbonFootprint.tblEmission.Next;
      end;//else of if dmCarbonFootprint.tblUsers['Username'] = sUsername
    end;//while NOT(dmCarbonFootprint.tblUsers.EOF) AND (bFound = False)

  except
    iBut := MessageDlg('Something went wrong during while trying to locate the Emission Type in the Database. Please contact a Developer to fix this error.',mtError,[mbAbort],0);
    Exit;
  end;


end;

//----------------------------------------\\
// Generator Combo Box Change: Load Edits \\
//----------------------------------------\\
procedure TfrmAdmin.cmbGeneratorChange(Sender: TObject);
var
  sEmissionType, sName, sBrand, sType : String;
  bFound, bFound2 : Boolean;
  iBut : Integer;
  rEmissions, rCapacity : Real;
begin
  if cmbGenerator.ItemIndex = -1 then
    Exit;

  //objGenerator.Free;
  sEmissionType := cmbGenerator.Items[cmbGenerator.ItemIndex];

  try
    //Locate Emission in tblEmissions
    dmCarbonFootprint.tblEmission.First;
    bFound := False;
    while NOT(dmCarbonFootprint.tblEmission.EOF) AND (bFound = False) do
    begin
      if dmCarbonFootprint.tblEmission['EmissionType'] = sEmissionType then
      begin
        bFound := True;
        //Input
        rEmissions := dmCarbonFootprint.tblEmission['CO2Emission'];
      end else//if dmCarbonFootprint.tblUsers['Username'] = sUsername
      begin
        dmCarbonFootprint.tblEmission.Next;
      end;//else of if dmCarbonFootprint.tblUsers['Username'] = sUsername
    end;//while NOT(dmCarbonFootprint.tblUsers.EOF) AND (bFound = False)

    //Locate generator in tblGenerator
    dmCarbonFootprint.tblGenerator.First;
    bFound2 := False;
    while NOT(dmCarbonFootprint.tblGenerator.EOF) AND (bFound2 = False) do
    begin
      if dmCarbonFootprint.tblGenerator['EmissionType'] = sEmissionType then
      begin
        bFound2 := True;
        //Input
        rCapacity := dmCarbonFootprint.tblGenerator['Capacity'];

        sName := dmCarbonFootprint.tblGenerator['GenName'];
        sBrand := dmCarbonFootprint.tblGenerator['GenBrand'];
        sType := dmCarbonFootprint.tblGenerator['Type'];
      end else//if dmCarbonFootprint.tblUsers['Username'] = sUsername
      begin
        dmCarbonFootprint.tblGenerator.Next;
      end;//else of if dmCarbonFootprint.tblUsers['Username'] = sUsername
    end;//while NOT(dmCarbonFootprint.tblUsers.EOF) AND (bFound = False)

    //If it couldn't be located
    if (bFound = FALSE) or (bFound2 = False) then
    begin
      iBut := MessageDlg('Something went wrong during while trying to locate the Generator in the Database. Please contact a Developer to fix this error.',mtError,[mbAbort],0);
      Exit;
    end;

    //Create object
    objGenerator := TGenerator.Create(sName, sBrand, sType, rCapacity, rEmissions);

    //Load into edits
    edtGenName.Text := sName;
    edtGenBrand.Text := sBrand;
    cmbGenType.ItemIndex := cmbGenType.Items.IndexOf(sType);
    edtGenCap.Text := FloatToStrF(rCapacity,ffFixed,10,3);
    edtGenEmi.Text := FloatToStrF(rEmissions,ffFixed,10,3);
  except
    iBut := MessageDlg('Something went wrong during while trying to locate the Generator in the Database. Please contact a Developer to fix this error.',mtError,[mbAbort],0);
    Exit;
  end;


end;

//----------------------------------\\
// User Defined Procedure: ElecFill \\
//----------------------------------\\
//Use this procedure to reset the DB Grid
procedure TfrmAdmin.ElecFill;
begin
  with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT * FROM tblElectricity ORDER BY Username ASC, DateSubmitted ASC';
    qryElectricity.Open;
  end;
end;

//----------------------------------------------\\
// Foorm Activated: Change component properties \\
//----------------------------------------------\\
procedure TfrmAdmin.FormActivate(Sender: TObject);
var
  k, l, iEmmType : Integer;
  arrEmmType : Array[1..500] of String;
  sTemp, sEmission : String;
begin
//Change Main form (and component) properties
{$REGION 'Admin Main Form'}
  with frmAdmin do
  begin
    //Admin Form Properties
    Width := 1243;
    Height := 738;
    Caption := 'Carbon Footprint Calculator';
  end;//with frmSignupLogin

  with pnlTitle do
  begin
    //Title Panel Properties
    Color := rgb(143, 232, 62);
    Font.Color := clBlack;
    Font.Size := 30;
    Font.Style := [fsBold];
    Font.Name := 'Arial Black';
    //Change the Title Panel's Text here
    Caption := 'Carbon Footprint Calculator';
  end;//with pnlTitle

  with pnlGenOne do
  begin
    Color := rgb(205,205,205);
  end;

  with pnlGenTwo do
  begin
    Color := rgb(205,205,205);
  end;

  with pnlGenThree do
  begin
    Color := rgb(205,205,205);
  end;

  with pnlFour do
  begin
    Color := rgb(205,205,205);
  end;

  with pnlFive do
  begin
    Color := rgb(205,205,205);
  end;

  with pnlSix do
  begin
    Color := rgb(205,205,205);
  end;

  with pnlSeven do
  begin
    Color := rgb(205,205,205);
  end;

  pgcAdmin.ActivePage := tbsGenerationMethod;
{$ENDREGION}

{$REGION 'Generation Panel Two'}
  LoadEmmType;
  LoadUsername;
  dtpGenDateOne.Date := Date;
  dtpGenDateTwo.Date := Date;

  with btnViewHelp do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with

  with btnEmmDisplay do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with

  with btnDateDisplay do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with

  with btnUsernameDisplay do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with

  with btnTwoDisplay do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with

  with btnTwoReset do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with

{$ENDREGION}

{$REGION 'Generation Panel Three'}
  LoadCountry;

  with btnCaclDisplay do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with

  with btnCountryDisplay do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with

  with btnUserSummDisplay do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with

  with btnThreeReset do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with
{$ENDREGION}

{$REGION 'Other Panel Four'}
  LoadGenerator;

  with btnEditHelp do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with

  with btnGenDelete do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with

  with btnGenEdit do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with

  with btnGenReset do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with
{$ENDREGION}

{$REGION 'Other Panel Five'}
  LoadGenerator;

  with btnEmiEdit do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with

  with btnEmiAdd do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with

  with btnEmiReset do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with
{$ENDREGION}

  //SQL Load
  with btnRedUpdate do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with

  with btnRedPrint do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with

  ElecFill;
  LoadRichEdit;
end;

//--------------------------------------\\
// User Defined Procedure: LoadCountry \\
//--------------------------------------\\
//Use this procedure to load counrties into the combo box
procedure TfrmAdmin.LoadCountry;
begin
  //Select the countries of users
  with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT DISTINCT Country FROM tblUsers ORDER BY Country ASC';
    qryElectricity.Open;
      cmbCountry.Items.Clear;
      qryElectricity.First;
        //Load into combo box
      while NOT qryElectricity.Eof do
      begin
        cmbCountry.Items.Add(qryElectricity.FieldByName('Country').AsString);
        //cmbUsernameThree.Items.Add(qryElectricity.FieldByName('Username').AsString);
        qryElectricity.Next;
      end;
  end;
  //Reset combo box
  cmbCountry.ItemIndex := -1;
  cmbCountry.Text := 'Select Country';
end;

//------------------------------------------\\
// User Defined Procedure: LoadEmissionType \\
//------------------------------------------\\
//Use this procedure to load emission types into combo boxes
procedure TfrmAdmin.LoadEmmType;
var
  k, l, iEmmType : Integer;
  arrEmmType : Array[1..500] of String;
  sTemp, sEmission : String;
begin
  //Select used emissions
  with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT DISTINCT EmissionType FROM tblElectricity ORDER BY EmissionType ASC';
    qryElectricity.Open;
      cmbEmmType.Items.Clear;
      cmbEmiType.Items.Clear;
      qryElectricity.First;
      //Load into combo box
      while NOT qryElectricity.Eof do
      begin
        cmbEmmType.Items.Add(qryElectricity.FieldByName('EmissionType').AsString);
        qryElectricity.Next;
      end;
  end;
  cmbEmmType.ItemIndex := -1;
  cmbEmmType.Text := 'Select Emission Type';

  //Select all emissions
  with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT DISTINCT EmissionType FROM tblEmission ORDER BY EmissionType ASC';
    qryElectricity.Open;
      cmbEmiType.Items.Clear;
      cmbEmiType.Items.Clear;
      qryElectricity.First;
      //Load into combo boxes
      while NOT qryElectricity.Eof do
      begin
        if qryElectricity.FieldByName('EmissionType').AsString[1] = 'E' then
          cmbEmiType.Items.Add(qryElectricity.FieldByName('EmissionType').AsString);

        qryElectricity.Next;
      end;
  end;
  cmbEmiType.ItemIndex := -1;
  cmbEmiType.Text := 'Select Emission Type';

end;

//----------------------------------------\\
// User Defined Procedure: Load Generator \\
//----------------------------------------\\
//Use this procedure to reset the DB Grid
procedure TfrmAdmin.LoadGenerator;
begin
  //Select all generators from tblGenerator
   with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT DISTINCT EmissionType FROM tblGenerator WHERE EmissionType LIKE "G%" ORDER BY EmissionType ASC';
    qryElectricity.Open;
      cmbGenerator.Items.Clear;
      qryElectricity.First;
      //Load into combo boxes
      while NOT qryElectricity.Eof do
      begin
        cmbGenerator.Items.Add(qryElectricity.FieldByName('EmissionType').AsString);
        //cmbUsernameThree.Items.Add(qryElectricity.FieldByName('EmissionType').AsString);
        qryElectricity.Next;
      end;
  end;
  cmbGenerator.ItemIndex := -1;
  cmbGenerator.Text := 'Select Generator';
  ElecFill;
end;

//-----------------------------------\\
// User Defined Procedure: Load RichEdit \\
//-----------------------------------\\
//Use this procedure to load data into the rich edit
procedure TfrmAdmin.LoadRichEdit;
var
  iPos, iAbove : Integer;
  rTotal : real;
begin
  //Clear rich edit
  redInfo.Clear;

  //Rich edit: Tab stops
  redInfo.Lines.Clear;
  redInfo.Paragraph.TabCount := 4;
  redInfo.Paragraph.Tab[0] := 50;
  redInfo.Paragraph.Tab[1] := 250;
  //redInfo.Paragraph.Tab[2] := 300;

  //Format & Add headings
  redInfo.SelAttributes.Style := [fsBold, fsUnderline];
  redInfo.SelAttributes.Color := rgb(25,51,0);
  redInfo.SelAttributes.Size := 12;
  redInfo.Lines.Add('Pos'+#9+'Username'+#9+'Total Carbon Footprint'+#9);

  redInfo.SelAttributes.Style := [fsItalic];
  redInfo.SelAttributes.Color := clGray;
  redInfo.Lines.Add('Sorted: Lowest to Highest'+#10);

  //Initialise
  iPos := 0;
  iAbove := 0;
  rTotal := 0;

  //Select from database
  with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT Username, ROUND(SUM(Emitted),3) AS [SUM] FROM tblElectricity WHERE Emitted <> 0 GROUP BY Username ORDER BY ROUND(SUM(Emitted),3) ASC, Username ASC ';
    qryElectricity.Open;
    qryElectricity.First;
      while NOT qryElectricity.Eof do
      begin
        //Load into rich edit
        inc(iPos);
        redInfo.Lines.Add(IntToStr(iPos)+#9+qryElectricity.FieldByName('Username').AsString+#9+qryElectricity.FieldByName('SUM').AsString+ ' kg');

        if qryElectricity.FieldByName('SUM').AsFloat <> 0 then
        begin
          //Used to calculate average
          inc(iAbove);
          rTotal := rTotal + qryElectricity.FieldByName('SUM').AsFloat;
        end;

        //cmbUsernameThree.Items.Add(qryElectricity.FieldByName('EmissionType').AsString);
        qryElectricity.Next;
      end;
  end;

  //Display average
  redInfo.Lines.Add(''+#10);
  redInfo.SelAttributes.Style := [fsBold];
  redInfo.SelAttributes.Color := rgb(25,51,0);
  redInfo.SelAttributes.Size := 12;
  redInfo.Lines.Add('Average Carbon Footprint');

  redInfo.SelAttributes.Style := [fsItalic];
  redInfo.SelAttributes.Color := clGray;
  redInfo.Lines.Add('of users with a Carbon Footprint above 0 kg');

  redInfo.Lines.Add(FloatToStrF(rTotal/iAbove, ffFixed, 10, 3)+' kg of CO2e'+#10);

  //Display other users with 0 CF
  redInfo.Lines.Add('');
  redInfo.SelAttributes.Style := [fsBold];
  redInfo.SelAttributes.Color := rgb(25,51,0);
  redInfo.SelAttributes.Size := 12;
  redInfo.Lines.Add('Users with a Carbon Footprint of Zero');
  with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT Username, ROUND(SUM(Emitted),3) AS [SUM] FROM tblElectricity GROUP BY Username HAVING SUM(Emitted) = 0 ';
    qryElectricity.Open;
    qryElectricity.First;
      while NOT qryElectricity.Eof do
      begin
        redInfo.Lines.Add('   →'#9+qryElectricity.FieldByName('Username').AsString);
        //cmbUsernameThree.Items.Add(qryElectricity.FieldByName('EmissionType').AsString);
        qryElectricity.Next;
      end;
  end;

  //Display generated information
  redInfo.Lines.Add(#10);
  redInfo.SelAttributes.Style := [fsItalic];
  redInfo.SelAttributes.Color := clGray;
  redInfo.Lines.Add('Generated on: '+FormatDateTime('dd mmm yyyy',Now())+' at '+FormatDateTime('t',Now())+' by '+frmSignupLogin.sLoggedIn);


  ElecFill;

end;

//---------------------------------------\\
// User Defined Procedure: Load Username \\
//---------------------------------------\\
//Use this procedure to load the usernames into combo boxes
procedure TfrmAdmin.LoadUsername;
begin
  //Select used usernames
  with dmCarbonFootprint_u.dmCarbonFootprint do
  begin
    qryElectricity.Close;
    qryElectricity.SQL.Text := 'SELECT DISTINCT Username FROM tblElectricity ORDER BY Username ASC';
    qryElectricity.Open;
      cmbUsername.Items.Clear;
      qryElectricity.First;
      while NOT qryElectricity.Eof do
      begin
        //Load into combo boxes
        cmbUsername.Items.Add(qryElectricity.FieldByName('Username').AsString);
        cmbUsernameThree.Items.Add(qryElectricity.FieldByName('Username').AsString);
        qryElectricity.Next;
      end;
  end;
  cmbUsername.ItemIndex := -1;
  cmbUsername.Text := 'Select Username';
  cmbUsernameThree.ItemIndex := -1;
  cmbUsernameThree.Text := 'Select Username';
  ElecFill;
end;

//-----------------------\\
// Edit panel Help Click \\
//-----------------------\\
procedure TfrmAdmin.btnEditHelpClick(Sender: TObject);
begin
  CarbonFootprint1_u.frmSignupLogin.LoadHelp('Edit');
end;

//----------------------\\
// Emission Reset Click \\
//----------------------\\
procedure TfrmAdmin.ResetEmi;
begin
  LoadEmmType;
  edtEmiEmitted.Text := '';
  edtEmiEmm.Text := '';
  edtEmiEmitted2.Text := '';
end;

//-----------------------------------\\
// Used defined Prcoedure: Reset Gen \\
//-----------------------------------\\
//Reset generator form
procedure TfrmAdmin.ResetGen;
begin
  LoadGenerator;
  edtGenName.Text := '';
  edtGenBrand.Text := '';
  cmbGenType.ItemIndex := -1;
  cmbGenType.Text := 'Select Generator Type';
  edtGenCap.Text := '';
  edtGenEmi.Text := '';
end;

//-----------------------\\
// Generator Reset Click \\
//-----------------------\\
procedure TfrmAdmin.btnGenResetClick(Sender: TObject);
begin
  ResetGen;

end;

//-----------------------\\
// Print RichEdit Button \\
//-----------------------\\
procedure TfrmAdmin.btnRedPrintClick(Sender: TObject);
var
  iBut : Integer;
begin
  if MessageDlg('Note: Your Default printer will be used to print the Rich edit as it is at this moment.'+' Are you sure you want to continue?',mtWarning,[mbYes, mbNo],0) = mrNo then
  begin
    iBut := MessageDlg('The rich edit was not printed.',mtError,[mbOk],0);
    Exit;
  end;

  redInfo.Print('Carbon Footprint score '+TimeToStr(Now()));
  iBut := MessageDlg('Print command sent to default printer',mtInformation,[mbOk],0);
end;

//------------------------\\
// Update RichEdit Button \\
//------------------------\\
procedure TfrmAdmin.btnRedUpdateClick(Sender: TObject);
begin
  LoadRichEdit;
end;

//-------------------------------\\
// Delete Generator Button Click \\
//-------------------------------\\
procedure TfrmAdmin.btnGenDeleteClick(Sender: TObject);
var
  iBut : integer;
  bFound : Boolean;
  sOriginalGen : String;
begin
  if cmbGenType.ItemIndex = -1 then //If no generator selected
  begin
    iBut := MessageDlg('Please select a generator. The Generator field is required to edit the database. To avoid this error, make sure you select a generator.',mtError,[mbAbort],0);
    Exit;
  end;

  //Input
  sOriginalGen := cmbGenerator.Items[cmbGenerator.ItemIndex];

  try
  //Disclaimer
  if MessageDlg('Note: The generator will only be deleted from tblGenerators. It cannot be deleted from tblEmission or tblElectricity due to referential integrity. Are you sure you want to continue?',mtWarning,[mbYes, mbNo],0) = mrYes then
  begin
    //Locate in database
    bFound := False;
    dmCarbonFootprint.tblGenerator.First;
    while NOT(dmCarbonFootprint.tblGenerator.EOF) AND (bFound = False) do
    begin
      if dmCarbonFootprint.tblGenerator['EmissionType'] = sOriginalGen then
      begin
        //Delete from database
        bFound := True;
        dmCarbonFootprint.tblGenerator.Delete;
        iBut := MessageDlg(sOriginalGen+' was deleted from tblGenerators.',mtInformation,[mbOk],0);
        LoadGenerator;
        //Clear components
        edtGenName.Text := '';
        edtGenBrand.Text := '';
        cmbGenType.ItemIndex := -1;
        cmbGenType.Text := 'Select Generator Type';
        edtGenCap.Text := '';
        edtGenEmi.Text := '';
      end else//if dmCarbonFootprint.tblUsers['Username'] = sUsername
      begin
        dmCarbonFootprint.tblGenerator.Next;
      end;//else of if dmCarbonFootprint.tblUsers['Username'] = sUsername
  end;//while NOT(dmCarbonFootprint.tblUsers.EOF) AND (bFound = False)
  end
  else
    iBut := MessageDlg('The generator was not deleted.',mtInformation,[mbOk],0);

  except
    iBut := MessageDlg('Something went wrong while deleting from the database. Please contact a Developer to fix this error.',mtError,[mbAbort],0);
    Exit;
  end;





end;

//-------------------------------\\
// Edit Generator Button Click \\
//-------------------------------\\
procedure TfrmAdmin.btnGenEditClick(Sender: TObject);
var
  sName, sBrand, sType, sValidError, sOriginalGen : String;
  rCapacity, rEmissions : Real;
  bValid, bSpace, bFound, bFound2 : Boolean;
  k, iBut : Integer;
begin
  //Input
  sName := edtGenName.Text;
  sBrand := edtGenBrand.Text;
  sType := cmbGenType.Items[cmbGenType.ItemIndex];
  sOriginalGen := cmbGenerator.Items[cmbGenerator.ItemIndex];

  //Validation: Generator Edit
  bValid := True;
  sValidError := '';

  if cmbGenType.ItemIndex = -1 then
  begin
    sValidError := sValidError + 'Please select a generator. The Generator field is required to edit the database. To avoid this error, make sure you select a generator.'+#10+#10;
    bValid := False;
  end;
{$REGION 'Name validation'}
  if sName = '' then
  begin
    sValidError := sValidError + 'Please enter a Generator Name. The Generator Name field is required to add it to the database. To avoid this error, make sure you enter a Generator Name.'+#10+#10;
    bValid := False;
  end //if sName := ''
  else
  if length(sName) < 3 then
  begin
    sValidError := sValidError + 'The Generator Name is too short. The entered Generator Name is shorter than the characters required. To avoid this error, please enter a username with at least 3 characters.'+#10+#10;
    bValid := False;
  end;//if length(sName) < 6

  if length(sName) > 20 then
  begin
    sValidError := sValidError + 'The Generator Name is too long. The entered Generator Name is longer than the character limit. To avoid this error, please enter a Generator Name with a maximum of 20 characters or fewer.'+#10+#10;
    bValid := False;
  end;//if length(sName) > 30
{$ENDREGION}
{$REGION 'Brand validation'}
  if sBrand = '' then
  begin
    sValidError := sValidError + 'Please enter a Generator Brand. The Generator Brand field is required to add it to the database. To avoid this error, make sure you enter a valid Generator Brand.'+#10+#10;
    bValid := False;
  end//if sBrand := ''
  else
  if length(sBrand) < 3 then
  begin
    sValidError := sValidError + 'The Generator Brand is too short. The entered Generator Brand is shorter than the characters required. To avoid this error, please enter a Generator Brand with at least 3 characters.'+#10+#10;
    bValid := False;
  end;//if length(sBrand) < 6

  bSpace := False;
  for k := 1 to length(sBrand) do
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

  if length(sBrand) > 20 then
  begin
    sValidError := sValidError + 'The Generator Brand is too long. The entered Generator Brand is longer than the character limit. To avoid this error, please enter a Generator Brand with a maximum of 20 characters or fewer.'+#10+#10;
    bValid := False;
  end;//if length(sBrand) > 30
{$ENDREGION}
{$REGION 'Type validation'}
  if cmbGenType.ItemIndex = -1 then
  begin
    sValidError := sValidError + 'Please select the Generator Type. The Generator Type field is required to add this generator to the database. To avoid this error, make sure you select a Generator Type from the dropdown list.'+#10+#10;
    bValid := False;
  end;//if cmbSignupCountries.ItemIndex = -1
{$ENDREGION}
{$REGION 'First validation error message'}
  if bValid = False then
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
    rCapacity := StrToFloat(edtGenCap.Text);
  except
    iBut := MessageDlg('You entered an invalid Generator Capacity. To avoid this error, Make sure to only enter the Generator Capacity as a number. Do not use other text such as the symbols, spaces, etc.',mtError,[mbAbort],0);
    Exit;
  end;//except
{$ENDREGION}
{$REGION 'Generator Emissions validation and input'}
  //For Try Except to work in Delphi itself: Tools > Options > Debugger Options ? Enbarcadero Debuggers > Language Exceptions > Notify on language exceptions (OFF)
  //Try Except works when using the Executable file.
  try
    rEmissions := StrToFloat(edtGenEmi.Text);
  except
    iBut := MessageDlg('You entered an invalid Generator Emissions value. To avoid this error, Make sure to only enter the Generator Emissions value as a number. Do not use other text such as the symbols, spaces, etc.',mtError,[mbAbort],0);
    Exit;
  end;//except
{$ENDREGION}

//Disclaimer
  if MessageDlg('Note: The generator''s ''EmissionType'' will remain the same,'+' but its properties will be changed. This can cause confusion among users. Due to referential integrity, it is impossible to change the generator''s ''EmissionType''. Are you sure you want to continue?',mtWarning,[mbYes, mbNo],0) = mrNo then
  begin
    iBut := MessageDlg('The generator was not edited.',mtError,[mbOk],0);
    Exit;
  end;

  //Create boject
  objGenerator := TGenerator.Create(sName, sBrand, sType, rCapacity, rEmissions);

  //sEmissionType := objGenerator.CreateEmissionType;
  //Locate in databases
  bFound := False;
  try
    dmCarbonFootprint.tblEmission.First;
    while NOT(dmCarbonFootprint.tblEmission.EOF) AND (bFound = False) do
    begin
      if dmCarbonFootprint.tblEmission['EmissionType'] = sOriginalGen then
      begin
        bFound := True;
      end else//if dmCarbonFootprint.tblUsers['Username'] = sUsername
      begin
        dmCarbonFootprint.tblEmission.Next;
      end;//else of if dmCarbonFootprint.tblUsers['Username'] = sUsername
    end;//while NOT(dmCarbonFootprint.tblUsers.EOF) AND (bFound = False)

    bFound2 := False;
    dmCarbonFootprint.tblGenerator.First;
  while NOT(dmCarbonFootprint.tblGenerator.EOF) AND (bFound2 = False) do
    begin
      if dmCarbonFootprint.tblGenerator['EmissionType'] = sOriginalGen then
      begin
        bFound2 := True;
      end else//if dmCarbonFootprint.tblUsers['Username'] = sUsername
      begin
        dmCarbonFootprint.tblGenerator.Next;
      end;//else of if dmCarbonFootprint.tblUsers['Username'] = sUsername
  end;//while NOT(dmCarbonFootprint.tblUsers.EOF) AND (bFound = False

  //Edit databases if found in both
  if (bFound = True) AND (bFound2 = True) then
  begin
    dmCarbonFootprint.tblGenerator.Edit;
    //dmCarbonFootprint.tblGenerator['EmissionType'] := sEmissionType;
    dmCarbonFootprint.tblGenerator['GenName'] := sName;
    dmCarbonFootprint.tblGenerator['GenBrand'] := sBrand;
    dmCarbonFootprint.tblGenerator['Type'] := sType;
    dmCarbonFootprint.tblGenerator['Capacity'] := rCapacity;
    dmCarbonFootprint.tblGenerator.Post;

    dmCarbonFootprint.tblEmission.Edit;
    //dmCarbonFootprint.tblEmission['EmissionType'] := sEmissionType;
    dmCarbonFootprint.tblEmission['CO2Emission'] := rEmissions;
    dmCarbonFootprint.tblEmission.Post;
  end
  else
    iBut := MessageDlg('The generator could not be found in the database. Please contact a Developer to fix this error.',mtError,[mbAbort],0);

  except
    iBut := MessageDlg('Something went wrong when editing the database. Please contact a Developer to fix this error.',mtError,[mbAbort],0);
    Exit;
  end;

  iBut := MessageDlg(sOriginalGen+' has been edited sucessfully!',mtInformation,[mbOk],0);
  ResetGen;

end;

end.
