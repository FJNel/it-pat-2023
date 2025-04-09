unit CarbonFootprint1_u;
//This Program uses Regions to make it easier to navigate and read. To view or hide a region, click on the [+] or [-] on the left side of the code.

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, pngimage, clsFactLoader_u, dmCarbonFootprint_u,
  jpeg, ComCtrls, DateUtils, NormalUser_u, Admin_u;

type
  TfrmSignupLogin = class(TForm)
    pnlTitle: TPanel;
    pnlLogin: TPanel;
    lblLoginTitle: TLabel;
    lbledtLoginUsername: TLabeledEdit;
    lbledtLoginPassword: TLabeledEdit;
    btnLogin: TPanel;
    pnlFact: TPanel;
    lblLoginFact: TLabel;
    lblLoginFactTitle: TLabel;
    tmrLoginFact: TTimer;
    imgLoginEye: TImage;
    lblGoSignUp: TLabel;
    pnlSignup: TPanel;
    lblSignupTitle: TLabel;
    imgSignupEye: TImage;
    lblGoLogin: TLabel;
    lbledtSignupUsername: TLabeledEdit;
    lbledtSignupPassword: TLabeledEdit;
    btnSignup: TPanel;
    pnlSignupFact: TPanel;
    lblSignupFact: TLabel;
    lblSignupFactTitle: TLabel;
    lblUsernameInfo: TLabel;
    lblPasswordInfo: TLabel;
    pnlSignupOne: TPanel;
    lbledtSignupFirstName: TLabeledEdit;
    lbledtSignupPWConfirm: TLabeledEdit;
    lbledtSignupLastName: TLabeledEdit;
    cmbSignupCountries: TComboBox;
    lblSignupCountries: TLabel;
    pnlSignupTwo: TPanel;
    lblContactNoInfo: TLabel;
    lblEmailInfo: TLabel;
    lblSignupGender: TLabel;
    lbledtSignupNumber: TLabeledEdit;
    lbledtSignupEmail: TLabeledEdit;
    lbledtSignupEmailConfirm: TLabeledEdit;
    cmbSignupGender: TComboBox;
    dtpSignupDOB: TDateTimePicker;
    lblSignupDOB: TLabel;
    lblAgeInfo: TLabel;
    lblLastNameInfo: TLabel;
    lblFirstNameInfo: TLabel;
    btnSignupHelp: TPanel;
    btnSignupReset: TPanel;
    btnLoginHelp: TPanel;
    btnLoginReset: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure tmrLoginFactTimer(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);

    Function Encrypt(sString:String):String; //User defined
    Procedure LoadHelp (sFileName:String); //User defined
    procedure imgLoginEyeClick(Sender: TObject);
    procedure imgSignupEyeClick(Sender: TObject);
    procedure lblGoSignUpClick(Sender: TObject);
    procedure lblGoLoginClick(Sender: TObject);
    procedure lbledtSignupUsernameChange(Sender: TObject);
    procedure lbledtSignupPasswordChange(Sender: TObject);
    procedure lbledtSignupPWConfirmChange(Sender: TObject);
    procedure lbledtSignupNumberChange(Sender: TObject);
    procedure lbledtSignupFirstNameChange(Sender: TObject);
    procedure lbledtSignupLastNameChange(Sender: TObject);
    procedure lbledtSignupEmailChange(Sender: TObject);
    procedure lbledtSignupEmailConfirmChange(Sender: TObject);
    procedure dtpSignupDOBChange(Sender: TObject);
    procedure btnSignupClick(Sender: TObject);
    Procedure SignupClear; //User defined
    procedure btnSignupResetClick(Sender: TObject);
    procedure btnSignupHelpClick(Sender: TObject);
    procedure btnLoginHelpClick(Sender: TObject);
    procedure btnLoginResetClick(Sender: TObject);
    procedure Button1Click(Sender: TObject); //Testing purposes!
  private
    objFactLoader: TFactLoader;
    const
      TimerMultiplier = 90;
      DefaultCountry = 'South Africa';
    var
      bLoginShow : Boolean;
      bSignupShow : Boolean;
  public
    sLoggedIn : String;
  end;

var
  frmSignupLogin: TfrmSignupLogin;

implementation

{$R *.dfm}

//--------------------\\
// Login Button Click \\
//--------------------\\
procedure TfrmSignupLogin.btnLoginClick(Sender: TObject);
var
  sUsername, sPassword, sValidError : String;
  bFound, bValid, bUsernameSpace, bPasswordSpace : Boolean;
  iBut, k : Integer;
begin
  //Input
  sUsername := lbledtLoginUsername.Text;
  sPassword := lbledtLoginPassword.Text;

  //Validation
{$REGION 'Username validation'}
  sValidError := '';
  bValid := True;
  if sUsername = '' then //If username is empty
  begin
    sValidError := sValidError + 'Please enter a username. The username field is required to log in. To avoid this error, make sure you enter a valid username.'+#10+#10;
    bValid := False;
  end//if sUsername = ''
  else
  if length(sUsername) < 6 then //If username is shorter than 6 chars
  begin
    sValidError := sValidError + 'The username is too short. The entered username is shorter than the characters required. To avoid this error, please enter a username with at least 6 characters.'+#10+#10;
    bValid := False;
  end;//if length(sUsername) < 6

  if length(sUsername) > 20 then //If username is longer than 20 chars
  begin
    sValidError := sValidError + 'The username is too long. The entered username is longer than the character limit. To avoid this error, please enter a username with a maximum of 20 characters or fewer.'+#10+#10;
    bValid := False;
  end;//if length(sUsername) > 30

  bUsernameSpace := False;
  for k := 1 to length(sUsername) do
  begin
    if sUsername[k] = ' ' then
    begin
      bUsernameSpace := True;
    end;//if sUsername[k] = ' '
  end;//for k := 1 to length(sUsername)
  if bUsernameSpace = True then //If username contains a space
  begin
    sValidError := sValidError + 'Please remove any spaces from the username. The entered username contains one or more spaces, which are not allowed. To avoid this error, please remove any spaces from the username (also check the last digit).'+#10+#10;
    bValid := False;
  end;//if bUsernameSpace = True

{$ENDREGION}
{$REGION 'Password validation'}
  if sPassword = '' then //If password is empty
  begin
    sValidError := sValidError + 'Please enter a password. The password field is required to log in. To avoid this error, make sure you enter a valid password.'+#10+#10;
    bValid := False;
  end//if sPassword = ''
  else
  if length(sPassword) < 8 then //If password is shorter than 6 chars
  begin
    sValidError := sValidError + 'The password is too short. The entered password is shorter than the characters required. To avoid this error, please enter a password with at least 8 characters.'+#10+#10;
    bValid := False;
  end;//if length(sPassword) < 8

  if length(sPassword) > 30 then //If password is longer than 30 chars
  begin
    sValidError := sValidError + 'The password is too long. The entered password is longer than the character limit. To avoid this error, please enter a username with a maximum of 30 characters or fewer.'+#10+#10;
    bValid := False;
  end;//if length(sPassword) > 30

  bPasswordSpace := False;
  for k := 1 to length(sPassword) do
  begin
    if sPassword[k] = ' ' then
    begin
      bPasswordSpace := True;
    end;//if sPassword[k] = ' '
  end;//for k := 1 to length(sPassword)
  if bPasswordSpace = True then //If password is contains a space
  begin
    sValidError := sValidError + 'Please remove any spaces from the password. The entered password contains one or more spaces, which are not allowed. To avoid this error, please remove any spaces from the password (also check the last digit).'+#10+#10;
    bValid := False;
  end;//if bPasswordSpace = True
{$ENDREGION}

  if bValid = False then //Show error message if there's anything wrong with fields
  begin
    sValidError := sValidError + 'Please make the necessary changes and try again.';
    iBut := MessageDlg(sValidError,mtError,[mbAbort],0);
    Exit;
  end;

  //Processing
  sPassword := Encrypt(sPassword); //Encrypts the password
  bFound := False;
  dmCarbonFootprint.tblUsers.First;

  while NOT(dmCarbonFootprint.tblUsers.EOF) AND (bFound = False) do //Loop through to search for username
  begin
    if dmCarbonFootprint.tblUsers['Username'] = sUsername then //If username matches
    begin
      bFound := True;
      if dmCarbonFootprint.tblUsers['Password'] = sPassword then //If password matches
      begin
        //Show welcome message
        iBut := MessageDlg('You have logged in successfully! Welcome '+dmCarbonFootprint.tblUsers['FirstName']+'.',mtInformation,[mbOk],0);
        sLoggedIn := sUsername;
        //Clear login form
        lbledtLoginUsername.Clear;
        lbledtLoginPassword.Clear;
        tmrLoginFact.Enabled := False;
        imgLoginEye.Picture.LoadFromFile('imgHide.jpg');
        lbledtLoginPassword.PasswordChar := '*';
        bLoginShow := False;

        //Go to next form and Check user type
        frmSignupLogin.Hide;
        if  dmCarbonFootprint.tblUsers['UserType'] = 'A' then
          Admin_u.frmAdmin.Show
        else
          NormalUser_u.frmNormalUser.Show;

          //Stop using the FactLoader object
        objFactLoader.Free;
      end//if dmCarbonFootprint.tblUsers['Password'] = sPassword
      else //If password doesn't match
        iBut := MessageDlg('The entered password is incorrect for the provided username. Please double-check your password and try again. If you have forgotten your password, you can use the account recovery option.',mtError,[mbAbort],0);
    end//if dmCarbonFootprint.tblUsers['Username'] = sUsername
    else //If username doesn't match
      dmCarbonFootprint.tblUsers.Next;
  end;//while NOT(dmCarbonFootprint.tblUsers.EOF) AND (bFound = False)

  if bFound = False then //If username isn't found in the database
  begin
    iBut := MessageDlg('The entered username was not found in our records. Please ensure that you have entered the correct username or consider signing up for a new account if you don''t have one.',mtError,[mbAbort],0);
    Exit;
  end;//if bFound = False
end;

//---------------------\\
// Signup Button Click \\
//---------------------\\
procedure TfrmSignupLogin.btnSignupClick(Sender: TObject);
var
  sUsername, sPassword, sPWConfirm, sFirstName, sLastName, sCountry, sContactNo, sEmail, sEmailConfirm, sGender, sLine : String;
  iHigh, iLow, iNumber, iSpecial, iDot, iAt : Integer;
  sValidError : String;
  k, iBut : Integer;
  dDOB : TDate;
  bValid, bFound, bCheckConfirm, bSpace, bTextFile : Boolean;
  FAdmins : TextFile;
begin
  //Input: Panel ONE
  sUsername := lbledtSignupUsername.Text;
  sPassword := lbledtSignupPassword.Text;
  sPWConfirm := lbledtSignupPWConfirm.Text;
  sFirstName := lbledtSignupFirstName.Text;
  sLastName := lbledtSignupLastName.Text;
  sCountry :=  Copy(cmbSignupCountries.Items[cmbSignupCountries.ItemIndex],1,30);

  //Input: Panel TWO
  sContactNo := lbledtSignupNumber.Text;
  sEmail := lbledtSignupEmail.Text;
  sEmailConfirm := lbledtSignupEmailConfirm.Text;
  sGender := cmbSignupGender.Items[cmbSignupGender.ItemIndex];
  dDOB := dtpSignupDOB.Date;

  //Validation: Panel ONE
  sValidError := '';
  bValid := True;
{$REGION 'Username validation'}
  if sUsername = '' then //If username is empty
  begin
    sValidError := sValidError + 'Please enter a username. The username field is required to sign up. To avoid this error, make sure you enter a valid username.'+#10+#10;
    bValid := False;
  end//if sUsername := ''
  else
  if length(sUsername) < 6 then //If username is shorter than 6 chars
  begin
    sValidError := sValidError + 'The username is too short. The entered username is shorter than the characters required. To avoid this error, please enter a username with at least 6 characters.'+#10+#10;
    bValid := False;
  end;//if length(sUsername) < 6

  bSpace := False;
  for k := 1 to length(sUsername) do
  begin
    if sUsername[k] = ' ' then
    begin
      bSpace := True;
    end;//if sUsername[k] = ' '
  end;//for k := 1 to length(sUsername)
  if bSpace = True then //If username contains a space
  begin
    sValidError := sValidError + 'Please remove any spaces from the username. The entered username contains one or more spaces, which are not allowed. To avoid this error, please remove any spaces from the username (also check the last digit).'+#10+#10;
    bValid := False;
  end;

  if length(sUsername) > 20 then //If username is longer than 20 chars
  begin
    sValidError := sValidError + 'The username is too long. The entered username is longer than the character limit. To avoid this error, please enter a username with a maximum of 20 characters or fewer.'+#10+#10;
    bValid := False;
  end;//if length(sUsername) > 30

  //If username is already in the database
  bFound := False;
  dmCarbonFootprint.tblUsers.First;
  while NOT(dmCarbonFootprint.tblUsers.EOF) AND (bFound = False) do
  begin
    if dmCarbonFootprint.tblUsers['Username'] = sUsername then
    begin
      bFound := True;
      sValidError := sValidError + 'The username is already used in the database. The entered username cannot be used. To avoid this error, please enter a different username (or make slight alterations to the current one) or log in if you already have an account.'+#10+#10;
      bValid := False;
    end else//if dmCarbonFootprint.tblUsers['Username'] = sUsername
    begin
      dmCarbonFootprint.tblUsers.Next;
    end;//else of if dmCarbonFootprint.tblUsers['Username'] = sUsername
  end;//while NOT(dmCarbonFootprint.tblUsers.EOF) AND (bFound = False)
{$ENDREGION}
{$REGION 'Password validation'}
  bCheckConfirm := True;
  if sPassword = '' then //If password is empty
  begin
    sValidError := sValidError + 'Please enter a password. A medium or high strength password is required to sign up. To avoid this error, make sure you enter a valid password.'+#10+#10;
    bValid := False;
    bCheckConfirm := False;
  end//if sPassword := ''
  else
  if length(sPassword) < 8 then //If password is shorter than 8 chars
  begin
    sValidError := sValidError + 'The password is too short. The entered password is shorter than the characters required. To avoid this error, please enter a password with at least 8 characters.'+#10+#10;
    bValid := False;
    bCheckConfirm := False;
  end;//if length(sPassword) < 6

  bSpace := False;
  for k := 1 to length(sPassword) do
  begin
    if sPassword[k] = ' ' then
    begin
      bSpace := True;
    end;//if sPassword[k] = ' '
  end;//for k := 1 to length(sPassword)
  if bSpace = True then //If password contains a space
  begin
    sValidError := sValidError + 'Please remove any spaces from the password. The entered password contains one or more spaces, which are not allowed. To avoid this error, please remove any spaces from the password (also check the last digit).'+#10+#10;
    bValid := False;
    bCheckConfirm := False;
  end;//if bPasswordSpace = False

  if length(sPassword) > 30 then //If password is longer than 30 chars
  begin
    sValidError := sValidError + 'The password is too long. The entered password is longer than the character limit. To avoid this error, please enter a username with a maximum of 30 characters or fewer.'+#10+#10;
    bValid := False;
    bCheckConfirm := False;
  end;//if length(sPassword) > 30

  //Check password strength
  iHigh := 0;
  iLow := 0;
  iSpecial := 0;
  iNumber := 0;

  for k := 1 to length(sPassword) do
  begin
    if sPassword[k] IN ['a'..'z'] then
      inc(iLow)
    else if sPassword[k] IN ['A'..'Z'] then
      inc(iHigh)
    else if sPassword[k] IN ['0'..'9'] then
      inc(iNumber)
    else inc(iSpecial);
  end;//for k := 1 to length(sPassword)

  //High Strength: aaAA###00a 2 Low, 2 High, 2 Number, 3 Special, 10+ characters
  if (iLow>1) AND (iHigh>1) AND (Length(sPassword)>9) AND (iSpecial>2) AND (iNumber>1) then
  begin
    with lblPasswordInfo do
    begin
      bCheckConfirm := True;
    end;//with lblPasswordInfo
  end//if High
  //Medium Strength: aaAA#1aa 2 Low, 2 High, 1 Number, 1 Special, 8+ characters
  else if (iLow>1) AND (iHigh>1) AND (Length(sPassword)>7) AND (iSpecial>0) AND (iNumber>0) then
  begin
    bCheckConfirm := True;
  end//if Medium
  //Low: aaaaaaaa If not medium, then Low
  else
  begin
    bCheckConfirm := False;
    sValidError := sValidError + 'The password is of low strength. The entered password can be easily guessed or cracked. To avoid this error, make sure the password is at least of medium strength. Medium strength passwords contain at least: 2 Lowercase characters,'+' 2 Uppercase characters, 1 Number, 1 Special character, and 8 characters or longer.'+#10+#10;
    bValid := False;
  end;//Is Low
{$ENDREGION}
{$REGION 'Confirm Password validation'}
  if (sPassword <> sPWConfirm) AND (bCheckConfirm = True) then //If password doesn't match the confirm password
  begin
    sValidError := sValidError + 'The password entered in the confirmation field does not match the password in the password field. To avoid this error, please ensure that both password fields contain the same password.'+' Retype the password in the confirmation field to match the original password exactly (The confirmation field will turn green).'+#10+#10;
    bValid := False;
  end;//if sPassword <> sPWConfirm AND
{$ENDREGION}
{$REGION 'First validation error message'}
  if bValid = False then //Show error message if there's anything wrong with the first set of fields
  begin
    sValidError := sValidError + 'Please make the necessary changes and try again. There may be more errors.';
    iBut := MessageDlg(sValidError,mtError,[mbAbort],0);
    Exit;
  end;//if bValid = False
  sValidError := '';
{$ENDREGION}

{$REGION 'First name validation'}
  if sFirstName = '' then //If first name is empty
  begin
    sValidError := sValidError + 'Please enter a first name. The first name field is required to sign up. To avoid this error, make sure you enter a valid first name.'+#10+#10;
    bValid := False;
  end//if sFirstName := ''
  else
  if length(sFirstName) < 2 then //If first name is shorter than 2 chars
  begin
    sValidError := sValidError + 'The first name is too short. The entered first name is shorter than the characters required. To avoid this error, please enter a first name with at least 2 characters.'+#10+#10;
    bValid := False;
  end;//if length(sFirstName) < 2

  bSpace := False;
  for k := 1 to length(sFirstName) do
  begin
    if sFirstName[k] = ' ' then
    begin
      bSpace := True;
    end;//if sFirstName[k] = ' '
  end;//for k := 1 to length(sFirstName)
  if bSpace = True then //If first name contains a space
  begin
    sValidError := sValidError + 'Please remove any spaces from the first name. The entered first name contains one or more spaces, which are not allowed. To avoid this error, please remove any spaces from the first name (also check the last digit).'+#10+#10;
    bValid := False;
  end;

  if length(sFirstName) > 15 then //If first name is longer than 15 chars
  begin
    sValidError := sValidError + 'The first name is too long. The entered first name is longer than the character limit. To avoid this error, please enter a first name with a maximum of 15 characters or fewer.'+#10+#10;
    bValid := False;
  end;//if length(sFirstName) > 15
{$ENDREGION}
{$REGION 'Last name validation'}
  if sLastName = '' then //If last name is empty
  begin
    sValidError := sValidError + 'Please enter a last name. The last name field is required to sign up. To avoid this error, make sure you enter a valid last name.'+#10+#10;
    bValid := False;
  end//if sLastName := ''
  else
  if length(sLastName) < 2 then //If last name is shorter than 2 chars
  begin
    sValidError := sValidError + 'The last name is too short. The entered last name is shorter than the characters required. To avoid this error, please enter a last name with at least 2 characters.'+#10+#10;
    bValid := False;;
  end;//if length(sLastName) < 2

  if length(sLastName) > 15 then ////If last name is longer than 15 chars
  begin
    sValidError := sValidError + 'The last name is too long. The entered last name is longer than the character limit. To avoid this error, please enter a last name with a maximum of 15 characters or fewer.'+#10+#10;
    bValid := False;
  end;//if length(sLastName) > 15

  //Remove any spaces from the end of the last name
  for k := length(sLastName) downto 1 do
  begin
    if sLastName[length(sLastName)] = ' ' then
    begin
      Delete(sLastName,length(sLastName),1);
    end;//if sLastName[length(sLastName)] = ' '
  end;//for k := length(sLastName)
{$ENDREGION}
{$REGION 'Country validation'}
  if cmbSignupCountries.ItemIndex = -1 then //If no country is selected
  begin
    sValidError := sValidError + 'Please select the country you reside in. The country field is required to sign up. To avoid this error, make sure you select a country from the dropdown list.'+#10+#10;
    bValid := False;
  end;//if cmbSignupCountries.ItemIndex = -1
{$ENDREGION}
{$REGION 'Second validation error message'}
  if bValid = False then //Show error message if there's anything wrong with the second set of fields
  begin
    sValidError := sValidError + 'Please make the necessary changes and try again. There may be more errors.';
    iBut := MessageDlg(sValidError,mtError,[mbAbort],0);
    Exit;
  end;//if bValid = False
  sValidError := '';
{$ENDREGION}

  //Validation: Panel TWO
{$REGION 'Contact Number validation'}
  if sContactNo = '' then //If contact no is empty
  begin
    sValidError := sValidError + 'Please enter a contact number. The contact number field is required to sign up. To avoid this error, make sure you enter a valid contact number.'+#10+#10;
    bValid := False;
  end;//if sContactNo := ''

  bSpace := False;
  for k := 1 to length(sContactNo) do
  begin
    if sContactNo[k] = ' ' then
    begin
      bSpace := True;
    end;//if sContactNo[k] = ' '
  end;//for k := 1 to length(sContactNo)
  if bSpace = True then //If contact no contains a space
  begin
    sValidError := sValidError + 'Please remove any spaces from the contact number. The entered contact number contains one or more spaces, which are not allowed. To avoid this error, please remove any spaces from the contact number.'+#10+#10;
    bValid := False;
  end;

  bSpace := False;
  for k := 1 to length(sContactNo) do
  begin
    if NOT(sContactNo[k] IN ['0'..'9']) then
    begin
      bSpace := True;
    end;//if sContactNo[k] = ' '
  end;//for k := 1 to length(sContactNo)
  if bSpace = True then //If contact no contains characters that aren't numbers
  begin
    sValidError := sValidError + 'Please remove any other characters from the contact number. The entered contact number contains characters that aren''t numbers from 0 to 9. To avoid this error, please remove other characters from the contact number.'+#10+#10;
    bValid := False;
  end;

  if length(sContactNo) <> 10 then //If contact no isn't exactly 10 chars
  begin
    sValidError := sValidError + 'The contact number is not the correct length. The entered contact number is not 10 characters in length. To avoid this error, please enter a contact number with 10 characters.'+#10+#10;
    bValid := False;
  end;//if length(sContactNo) <> 10
{$ENDREGION}
{$REGION 'Email validation'}
  bCheckConfirm := True;
  if sEmail = '' then //If email is empty
  begin
    sValidError := sValidError + 'Please enter an email address. The email address field is required to sign up. To avoid this error, make sure you enter a valid email address.'+#10+#10;
    bValid := False;
    bCheckConfirm := False;
  end//if sEmail := ''
  else
  if length(sEmail) < 6 then //If email is shorter than 6 chars
  begin
    sValidError := sValidError + 'The email address is too short. The entered email address is shorter than the characters required. To avoid this error, please enter an email address with at least 6 characters.'+#10+#10;
    bValid := False;
    bCheckConfirm := False;
  end;//if length(sEmail) < 6

  iDot := 0;
  iAt := 0;
  bSpace := False;
  for k := 1 to length(sEmail) do
  begin
    if sEmail[k] = ' ' then
    begin
      bSpace := True;
    end;//if sEmail[k] = ' '
    if sEmail[k] = '.' then
      inc(iDot);
    if sEmail[k] = '@' then
      inc(iAt);
  end;//for k := 1 to length(sEmail)

  if bSpace = True then //If email contains a space
  begin
    sValidError := sValidError + 'Please remove any spaces from the email address. The entered email address contains one or more spaces, which are not allowed. To avoid this error, please remove any spaces from the email address (also check the last digit).'+#10+#10;
    bValid := False;
    bCheckConfirm := False;
  end;

  if length(sEmail) > 25 then //If email is longer than 25 chars
  begin
    sValidError := sValidError + 'The email address is too long. The entered email address is longer than the character limit. To avoid this error, please enter an email address with a maximum of 25 characters or fewer.'+#10+#10;
    bValid := False;
    bCheckConfirm := False;
  end;//if length(sEmail) > 30

  if (iDot>0) AND (iAt=0) then //If email doesn't contain @ but does contain .
  begin
    sValidError := sValidError + 'The email address requires an ''@'' symbol. The entered email address does not contain an ''@'' symbol. To avoid this error, please enter an email address that contains an ''@'' symbol.'+#10+#10;
    bValid := False;
    bCheckConfirm := False;
  end;//if
  if (iDot=0) AND (iAt>0) then //If email doesn't contain . but does contain @
  begin
    sValidError := sValidError + 'The email address requires a ''.'' (full stop). The entered email address does not contain a ''.'' (full stop). To avoid this error, please enter an email address that contains a ''.'' (full stop).'+#10+#10;
    bValid := False;
    bCheckConfirm := False;
  end;//if
  if (iDot=0) AND (iAt=0) then //If email doesn't contain @ and .
  begin
    sValidError := sValidError + 'The email address requires an ''@'' symbol and a ''.'' (full stop). The entered email address does not contain an ''@'' symbol and also does not contain a ''.'' (full stop).'+' To avoid this error, please enter an email address that contains an ''@'' symbol and a ''.'' (full stop).'+#10+#10;
    bValid := False;
    bCheckConfirm := False;
  end;//if
{$ENDREGION}
{$REGION 'Confirm Email validation'}
  if (sEmail <> sEmailConfirm) AND (bCheckConfirm = True) then //If email doesn't match the confirm email
  begin
    sValidError := sValidError + 'The email address entered in the confirmation field does not match the email address in the email address field. To avoid this error, please ensure that both email address fields contain the same email address.'+' Retype the email address in the confirmation field to match the original email address exactly (The confirmation field will turn green).'+#10+#10;
    bValid := False;
  end;//if sPassword <> sPWConfirm AND
{$ENDREGION}
{$REGION 'Third validation error message'}
  if bValid = False then //Show error message if there's anything wrong with the third set of fields
  begin
    sValidError := sValidError + 'Please make the necessary changes and try again. There may be more errors.';
    iBut := MessageDlg(sValidError,mtError,[mbAbort],0);
    Exit;
  end;//if bValid = False
  sValidError := '';
{$ENDREGION}

{$REGION 'Date of Birth validation'}
  if FormatDateTime('dd mm yyyy',dDOB) = FormatDateTime('dd mm yyyy',Date) then //If DOB is same as today
  begin
    sValidError := sValidError + 'Please select a date of birth from the Date-Time picker that is not today''s date. Your date of birth is required to sign up. To avoid this error, make sure you select a valid date of birth.'+#10+#10;
    bValid := False;
  end;//if

  if CompareDate(Date,dDOB) < 0 then //If DOB is future date
  begin
    sValidError := sValidError + 'Please select a past date from the Date-Time picker. The date of birth selected currently is a future date. To avoid this error, make sure you select a date of birth that has already passed.'+#10+#10;
    bValid := False;
  end;//if

  if YearsBetween(dDOB,Date) < 13 then //If user is younger than 13
  begin
    sValidError := sValidError + 'You must be 13 years or older to use this program. The date of birth selected currently is shows that you are '+IntToStr(YearsBetween(dDOB,Date))+' years old. If you are under 13, please ask a parent or gaurdian to complete sign up for you.'+#10+#10;
    bValid := False;
  end;//if
{$ENDREGION}
{$REGION 'Gender validation'}
if cmbSignupGender.ItemIndex = -1 then //If no gender is selected
  begin
    sValidError := sValidError + 'Please select your gender. The gender field is required to sign up. To avoid this error, make sure you select a gender from the dropdown list.'+#10+#10;
    bValid := False;
  end;//if cmbSignupGender.ItemIndex = -1
{$ENDREGION}
{$REGION 'Fourth validation error message'}
  if bValid = False then //Show error message if there's anything wrong with the fourth set of fields
  begin
    sValidError := sValidError + 'Please make the necessary changes and try again.';
    iBut := MessageDlg(sValidError,mtError,[mbAbort],0);
    Exit;
  end;//if bValid = False
  sValidError := '';
{$ENDREGION}
{$REGION 'Administrator.txt validation'}
  //Check if Admin.txt does exist
  bTextFile := True;
  if FileExists('Administrator.txt') = FALSE then //If admin.txt doesn't exsist
  begin
    bTextFile := False;
    iBut := MessageDlg('The Administrator.txt file that is used to load the list of administrators could not be found. Unfortunately, this means you will automatically be a normal user when if signup is completed successfully. Contact a Developer to fix this Error.',mtError,[mbOk],0);
  end//if FileExists('Countries.txt') = FALSE
  else //If it does exist
  begin
    AssignFile(FAdmins,'Administrator.txt');
    reset(FAdmins);
  end;
{$ENDREGION}

  //Processing
  //For Try Except to work in Delphi itself: Tools > Options > Debugger Options ? Enbarcadero Debuggers > Language Exceptions > Notify on language exceptions (OFF)
  //Try Except works when using the Executable file.
  try
    //Insert data into tblUsers
    dmCarbonFootprint.tblUsers.Insert;
    dmCarbonFootprint.tblUsers['Username'] := sUsername;
    dmCarbonFootprint.tblUsers['Password'] := Encrypt(sPassword);
    dmCarbonFootprint.tblUsers['FirstName'] := sFirstName;
    dmCarbonFootprint.tblUsers['LastName'] := sLastName;
    dmCarbonFootprint.tblUsers['BirthDate'] := dDOB;
    dmCarbonFootprint.tblUsers['Email'] := sEmail;
    dmCarbonFootprint.tblUsers['ContactNo'] := sContactNo;
    dmCarbonFootprint.tblUsers['Country'] := sCountry;
    dmCarbonFootprint.tblUsers['Gender'] := sGender[1];
    dmCarbonFootprint.tblUsers['UserType'] := 'N';
    dmCarbonFootprint.tblUsers.Post;

    //Insert data into tblElectricity
    dmCarbonFootprint.tblElectricity.Insert;
    dmCarbonFootprint.tblElectricity['Username'] := sUsername;
    dmCarbonFootprint.tblElectricity['Entry'] := 0;
    dmCarbonFootprint.tblElectricity['Unit'] := 0;
    dmCarbonFootprint.tblElectricity['Emitted'] := 0;
    dmCarbonFootprint.tblElectricity['EmissionType'] := 'F First Entry';
    dmCarbonFootprint.tblElectricity['EmissionAtSubmission'] := 0;
    dmCarbonFootprint.tblElectricity['DateSubmitted'] := DateOf(Today);
    dmCarbonFootprint.tblElectricity.Post;

    //Check if username is in the text file
    bFound := False;
    if bTextFile = True then //If the text file does exist
    begin
    while (NOT EOF(FAdmins)) AND (bFound = False) do
    begin
      readln(FAdmins,sLine);
      if sLine = sFirstName+' '+sLastName then //If First+Last names match name in text file
      begin
        //Show message asking if they want to be an admin
        iBut := MessageDlg('Since your name was found in the Administrator.txt file, you have the option to become an Administrator.'+' Choosing this option will always take you to another form with other functions and advanced features. Select ''Yes'' if you wish to be an Administrator, or ''No'' if you prefer to as a Normal User.',mtConfirmation,[mbYes,mbNo],0);
        if iBut = mrYes then //If yes
        begin
          //Change user type in database
          dmCarbonFootprint.tblUsers.Edit;
          dmCarbonFootprint.tblUsers['UserType'] := 'A';
          dmCarbonFootprint.tblUsers.Post;
          iBut := MessageDlg('Your User type is now ''Administrator''.',mtInformation,[mbOk],0);
        end //If no
        else
          iBut := MessageDlg('Your User type is now ''Normal User''.',mtInformation,[mbOk],0);
      end;//if sLine = sFirstName+' '+sLastName
    end;//while (NOT EOF(FAdmins)) AND (bFound = False)
    Closefile(fAdmins);
    end;//if bTextFile = True

    //Confirmation message
    iBut := MessageDlg(sFirstName+', your account with the Username '''+sUsername+''' has been created successfully! Use this username, and the password you used upon signup to Log in. Welcome to the Carbon Footprint Calculator!',mtInformation,[mbOk],0);

    //Take to login panel
    pnlSignup.Enabled := False;
    pnlSignup.Visible := False;
    SignupClear;

    pnlLogin.Enabled := True;
    pnlLogin.Visible := True;
    lbledtLoginUsername.SetFocus;
  except
    iBut := MessageDlg('Something went wrong during Signup. Please contact a Developer to fix this error.',mtError,[mbAbort],0);
    Exit;
  end;//except

end;

//-------------------\\
// Signup Help Click \\
//-------------------\\
procedure TfrmSignupLogin.btnSignupHelpClick(Sender: TObject);
begin
  LoadHelp('Signup');
end;

//--------------------\\
// Signup Reset Click \\
//--------------------\\
procedure TfrmSignupLogin.btnSignupResetClick(Sender: TObject);
begin
  //Clear panel and set focus
  SignupClear;
  lbledtSignupUsername.SetFocus;
end;

//-------------------------------------\\
// BUTTON 1 Click - TESTING PURPOSES!! \\
//-------------------------------------\\
//This code is used to test the program. The developer can execute the code here by adding a normal button to the form
procedure TfrmSignupLogin.Button1Click(Sender: TObject);
var
  sUsername : String;
begin
    sUsername := 'SibuDeBruin';
    dmCarbonFootprint.tblElectricity.Last;
    dmCarbonFootprint.tblElectricity.Insert;
    dmCarbonFootprint.tblElectricity['Username'] := sUsername;
    dmCarbonFootprint.tblElectricity['Entry'] := 0;
    dmCarbonFootprint.tblElectricity['kWh'] := 0;
    dmCarbonFootprint.tblElectricity['EmissionType'] := 'F First Entry';
    dmCarbonFootprint.tblElectricity['EmissionAtSubmission'] := 0;
    dmCarbonFootprint.tblElectricity['DateSubmitted'] := DateOf(Today);
    dmCarbonFootprint.tblElectricity.Post;
end;

//--------------------------------------\\
// SignupDOB Changed: Validation labels \\
//--------------------------------------\\
procedure TfrmSignupLogin.dtpSignupDOBChange(Sender: TObject);
var
  dDOB : TDate;
begin
  //Input
  dDOB := dtpSignupDOB.Date;

  //Processing & Output
  if FormatDateTime('dd mm yyyy',dDOB) = FormatDateTime('dd mm yyyy',Date) then //If DOB is same as today
  begin
    //Change label
    with lblAgeInfo do
      begin
        Caption := '🗵 Cannot be today''s date';
        Font.Color := rgb(255,128,0);
        Visible := True;
      end;//with lblAgeInfo
      Exit;
  end;//if

  if CompareDate(Date,dDOB) < 0 then //If DOB is future date
  begin
    //Change label
    with lblAgeInfo do
      begin
        Caption := '🗵 Cannot be a future date';
        Font.Color := rgb(255,0,0);
        Visible := True;
      end;//with lblAgeInfo
      Exit;
  end;//if

  if YearsBetween(dDOB,Date) < 13 then //If user is younger than 13
  begin
    //Change label
    with lblAgeInfo do
      begin
        Caption := '🗵 You must be 13 or older';
        Font.Color := rgb(255,0,0);
        Visible := True;
      end;//with lblAgeInfo
      Exit;
  end;//if

  //No errors! Change label
  with lblAgeInfo do
  begin
    Caption := '☑ Valid ('+IntToStr(YearsBetween(dDOB,Date))+' years old)';
    Font.Color := rgb(0,153,0);
    Visible := True;
  end;//with lblAgeInfo

end;

//---------------------------------\\
// User Declared Function: Encrypt \\
//---------------------------------\\
//Use this function to Encrypt/Decrypt passwords
function TfrmSignupLogin.Encrypt(sString: String): String;
var
  k : Integer;
begin
  Result := sString;
  for k := 1 to length(sString) do
    Result[k] := chr(not(ord(sString[k])));//Use reversable formula to encrypt or decrypt password
end;

//---------------------------------------------\\
// Form Activated: Change Component Properties \\
//---------------------------------------------\\
procedure TfrmSignupLogin.FormActivate(Sender: TObject);
var
  sFact, sLine, sTemp : String;
  iCountries, iBut, k, l : Integer;
  FCountries : TextFile;
  arrCountries : Array[1..250] of String;
begin
//Change Main form (and component) properties
{$REGION 'Login and Signup Main Form'}
  with frmSignupLogin do
  begin
    //Signup & Login Form Properties
    Width := 1248;
    Height := 744;
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
{$ENDREGION}

//Change Login panel (and component) properties
{$REGION 'Login Panel'}
  with pnlLogin do
  begin
    //Login Panel Properties
    Caption := '';
    Enabled := True;
    //Size
    Height := 649;
    Width := 1235;
    //Position
    Top := 57;
    Left := 0;
  end;//with pnlLogin

  with lblLoginTitle do
  begin
    //Login Title Label Properties
    Top := -16;
    Left := 0;
    Font.Color := clBlack;
    Font.Size := 45;
    Font.Style := [fsBold];
    Font.Name := 'Arial Black';
    Width := 1233;
    Alignment := taCenter;
    //Change the Login Panel's Title Text here
    Caption := 'Login';
  end;//with lblLoginTitle

  with btnLogin do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnLogin

  with lblLoginFactTitle do
  begin
    Caption := 'Did you know?';
    Top := 7;
    Left := 0;
    Width := 1201;
    Height := 27;
    Alignment := taCenter;
  end;//with lblLoginFactTitle

  objFactLoader := TFactLoader.Create('Facts Login');
  sFact := objFactLoader.GetFact;
  with lblLoginFact do
  begin
    Top := 40;
    Left := 16;
    Width := 1169;
    Height := 81;
    WordWrap := True;
    Layout := tlCenter;
    Alignment := taCenter;
    Font.Name := 'Arial';
    Font.Size := 14;
    Caption := sFact;
  end;//with lblLoginFact

  with lblGoSignUp do
  begin
    Alignment := taCenter;
    Font.Color := clMenuHighLight;
    Font.Name := 'Arial';
    Font.Size := 12;
  end;//with lblGoSignUp

  with btnLoginHelp do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with btnLoginReset do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  //Password Show/Hide
  imgLoginEye.Picture.LoadFromFile('imgHide.jpg');
  bLoginShow := False;
  lbledtLoginPassword.PasswordChar := '*';
  lbledtLoginUsername.SetFocus;

  tmrLoginFact.Interval := Length(sFact)*TimerMultiplier;
  tmrLoginFact.Enabled := True;

{$ENDREGION}

//Change Signup panel (and component) properties
{$REGION 'Signup Panel'}
  with pnlSignup do
  begin
    //Signup Panel Properties
    Caption := '';
    Enabled := False;
    Visible := False;
    //Size
    Height := 649;
    Width := 1235;
    //Position
    Top := 57;
    Left := 0;
  end;//with pnlSignup

  with lblSignupTitle do
  begin
    //Signup Title Label Properties
    Top := -16;
    Left := 0;
    Font.Color := clBlack;
    Font.Size := 45;
    Font.Style := [fsBold];
    Font.Name := 'Arial Black';
    Width := 1233;
    Alignment := taCenter;
    //Change the Login Panel's Title Text here
    Caption := 'Signup';
  end;//with lblSignupTitle

  with btnSignup do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with btnSignupHelp do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with btnSignupReset do
  begin
    Color := rgb(51, 102, 51);
    Font.Color := clWhite;
  end;//with btnSignup

  with lblSignupFactTitle do
  begin
    Caption := 'Did you know?';
    Top := 7;
    Left := 0;
    Width := 1201;
    Height := 27;
    Alignment := taCenter;
  end;//with lblSignupFactTitle

  with lblSignupFact do
  begin
    Top := 40;
    Left := 16;
    Width := 1169;
    Height := 81;
    WordWrap := True;
    Layout := tlCenter;
    Alignment := taCenter;
    Font.Name := 'Arial';
    Font.Size := 14;
    Caption := sFact;
  end;//with lblSignupFact

  with lblGoLogin do
  begin
    Alignment := taCenter;
    Font.Color := clMenuHighLight;
    Font.Name := 'Arial';
    Font.Size := 12;
  end;//with lblGoSLogin

  with pnlSignupOne do
  begin
    Color := rgb(205,205,205);
  end;

  with pnlSignupTwo do
  begin
    Color := rgb(205,205,205);
  end;

  dtpSignupDOB.Date := Date;

  //Password Show/Hide
  imgSignupEye.Picture.LoadFromFile('imgHide.jpg');
  bSignupShow := False;
  lbledtSignupPassword.PasswordChar := '*';

  lbledtSignupPWConfirm.Enabled := False;
  lbledtSignupEmailConfirm.Enabled := False;

{$ENDREGION}

  //Must remain last in the procedure!
  //Countries combo boxes
  //Countries.txt gotten from https://gist.github.com/kalinchernev/486393efcca01623b18d
  iCountries := 0;
  if FileExists('Countries.txt') = FALSE then //If countries.txt doesn't exist
  begin
    iBut := MessageDlg('The Countries.txt file that is used to load a list of countries could not be found. Unfortunately, this is required to sign up. Contact a Developer to fix this Error.',mtError,[mbAbort],0);
    Exit;
  end;//if FileExists('Countries.txt') = FALSE
  AssignFile(FCountries,'Countries.txt');
  reset(FCountries);

  //If it does, load countries from countries.txt into array
  while NOT(EOF(FCountries)) do
  begin
    readln(FCountries,sLine);
    inc(iCountries);
    arrCountries[iCountries] := sLine;
  end;// while NOT(EOF(FCountries))

  //Sort array in ASC
  for k := 1 to iCountries - 1 do
    for l := k+1 to iCountries do
    begin
      if arrCountries[k] > arrCountries[l] then
      begin
        sTemp := arrCountries[k];
        arrCountries[k] := arrCountries[l];
        arrCountries[l] := sTemp;
      end;//for l := k+1 to iCountries
    end;//for k := 1 to iCountries - 1 do

    //Load array contents into component
    for k := 1 to iCountries do
    begin
      cmbSignupCountries.Items.Add(arrCountries[k]);
    end;//for k := 1 to iCountries

    //Set default country
    cmbSignupCountries.ItemIndex := cmbSignupCountries.Items.IndexOf(DefaultCountry);
    //Close file
    Closefile(FCountries);
end;

//-----------------------\\
// Login Eye Image Click \\
//-----------------------\\
procedure TfrmSignupLogin.imgLoginEyeClick(Sender: TObject);
begin
  if bLoginShow = False then//If Password is not visible
  begin
    //Make password visible
    imgLoginEye.Picture.LoadFromFile('imgShow.jpg');
    lbledtLoginPassword.PasswordChar := #0;
    bLoginShow := True;
  end//if bLoginShow = False
  else
  begin//If Password is visible
    //Make password invisible
    imgLoginEye.Picture.LoadFromFile('imgHide.jpg');
    lbledtLoginPassword.PasswordChar := '*';
    bLoginShow := False;
  end;//else of if bLoginShow = False

end;

//------------------------\\
// Signup Eye Image Click \\
//------------------------\\
procedure TfrmSignupLogin.imgSignupEyeClick(Sender: TObject);
begin
  if bSignupShow = False then//If Password is not visible
  begin
    //Make password visible
    imgSignupEye.Picture.LoadFromFile('imgShow.jpg');
    lbledtSignupPassword.PasswordChar := #0;
    bSignupShow := True;
  end//if bLoginShow = False
  else
  begin//If pPassword is visible
    //Make password invisible
    imgSignupEye.Picture.LoadFromFile('imgHide.jpg');
    lbledtSignupPassword.PasswordChar := '*';
    bSignupShow := False;
  end;//else of if bLoginShow = False
end;

//---------------------------------------\\
// Email Edit Changed: Validation labels \\
//---------------------------------------\\
procedure TfrmSignupLogin.lbledtSignupEmailChange(Sender: TObject);
var
  sText : String;
  k, iDot, iAt : Integer;
begin
  //Input
  sText := lbledtSignUpEmail.Text;

  if sText = '' then //If email is empty
  begin
    lblEmailInfo.Visible := False;
    lblEmailInfo.Caption := '';
    Exit;
  end;//if sText := ''

  iDot := 0;
  iAt := 0;
  for k := 1 to length(sText) do
  begin
    if sText[k] = ' ' then
    begin
      lbledtSignupEmailConfirm.Enabled := False;
      with lblEmailInfo do
      begin
        Caption := '🗵 No spaces allowed';
        Font.Color := rgb(225,0,0);
        Visible := True;
      end;//with lblEmailInfo
      Exit;
    end;//if sText[k] = ' '
    if sText[k] = '.' then
      inc(iDot);
    if sText[k] = '@' then
      inc(iAt);
  end;//for k := 1 to length(sText)

  if length(sText) < 6 then //If email is shorter than 6 chars
  begin
    //Errors! Not Confirmable and Change labels
    lbledtSignupEmailConfirm.Enabled := False;
    with lblEmailInfo do
      begin
        Caption := '🗵 Must be at least 6 characters';
        Font.Color := rgb(255,128,0);
        Visible := True;
      end;//with lblEmailInfo
      Exit;
  end;//if length(sText) < 6

  if length(sText) > 25 then //If email is longer than 25 chars
  begin
    //Errors! Not Confirmable and Change labels
    lbledtSignupEmailConfirm.Enabled := False;
    with lblEmailInfo do
      begin
        Caption := '🗵 Must be less than 26 characters';
        Font.Color := rgb(255,0,0);
        Visible := True;
      end;//with lblEmailInfo
      Exit;
  end;//if length(sText) > 30

  if (iDot>0) AND (iAt=0) then //If email has . and requires @
  begin
    //Errors! Not Confirmable and Change labels
    lbledtSignupEmailConfirm.Enabled := False;
    with lblEmailInfo do
      begin
        Caption := '🗵 Reguires an @';
        Font.Color := rgb(225,128,0);
        Visible := True;
      end;//with lblEmailInfo
      Exit;
  end;//if
  if (iDot=0) AND (iAt>0) then //If email has @ and requires .
  begin
    //Errors! Not Confirmable and Change labels
    lbledtSignupEmailConfirm.Enabled := False;
    with lblEmailInfo do
      begin
        Caption := '🗵 Reguires a . (full stop)';
        Font.Color := rgb(225,128,0);
        Visible := True;
      end;//with lblEmailInfo
      Exit;
  end;//if
  if (iDot=0) AND (iAt=0) then //If email requires @ and .
  begin
    //Errors! Not Confirmable and Change labels
    lbledtSignupEmailConfirm.Enabled := False;
    with lblEmailInfo do
      begin
        Caption := '🗵 Reguires a . (full stop) and an @';
        Font.Color := rgb(204,102,0);
        Visible := True;
      end;//with lblEmailInfo
      Exit;
  end;//if

  if (iDot>0) AND (iAt>0) AND (Length(sText) IN [6..25]) then
  begin
    //No errors! Confirmable and Change labels
    lbledtSignupEmailConfirm.Enabled := True;
    with lblEmailInfo do
      begin
        Caption := '☑ Valid';
        Font.Color := rgb(0,153,0);
        Visible := True;
      end;//with lblEmailInfo
      Exit;
  end;//if
    

end;

//-----------------------------------------------\\
// Confirm Email Edit Changed: Validation labels \\
//-----------------------------------------------\\
procedure TfrmSignupLogin.lbledtSignupEmailConfirmChange(Sender: TObject);
var
  sEmail, sConfirm : String;
begin
  //Input
  sEmail := lbledtSignupEmail.Text;
  sConfirm := lbledtSignupEmailConfirm.Text;

  //Processing and Output
  if sEmail = sConfirm then //If email and confirm email is the same
    lbledtSignupEmailConfirm.Color := rgb(102,255,102) //green
  else
    lbledtSignupEmailConfirm.Color := rgb(255,102,102);//red

end;

//--------------------------------------------\\
// First Name Edit Changed: Validation labels \\
//--------------------------------------------\\
procedure TfrmSignupLogin.lbledtSignupFirstNameChange(Sender: TObject);
var
  sText : String;
  k : Integer;
  bFound : Boolean;
begin
  //Input
  sText := lbledtSignUpFirstName.Text;

  if sText = '' then //If first name is empty
  begin
    lblFirstNameInfo.Visible := False;
    lblFirstNameInfo.Caption := '';
    Exit;
  end;//if sText := ''

  for k := 1 to length(sText) do
  begin
    if sText[k] = ' ' then //If first name contains space
    begin
      //Change label
      with lblFirstNameInfo do
      begin
        Caption := '🗵 No spaces allowed';
        Font.Color := rgb(225,0,0);
        Visible := True;
      end;//with lblFirstNameInfo
      Exit;
    end;//if sText[k] = ' '
  end;//for k := 1 to length(sText)

  if length(sText) < 2 then //If first name short than 2 chars
  begin
    //Change label
    with lblFirstNameInfo do
      begin
        Caption := '🗵 Must be at least 2 characters';
        Font.Color := rgb(255,128,0);
        Visible := True;
      end;//with lblFirstNameInfo
      Exit;
  end;//if length(sText) < 2

  if length(sText) > 15 then //If first name longer than 2 chars
  begin
    //Change label
    with lblFirstNameInfo do
      begin
        Caption := '🗵 Must be less than 16 characters';
        Font.Color := rgb(255,0,0);
        Visible := True;
      end;//with lblFirstNameInfo
      Exit;
  end;//if length(sText) > 15

  //No errors! Change label
  with lblFirstNameInfo do
  begin
    Caption := '☑ Valid';
    Font.Color := rgb(0,153,0);
    Visible := True;
  end;//with lblContactNoInfo
end;

//--------------------------------------------\\
// Last Name Edit Changed: Validation labels \\
//--------------------------------------------\\
procedure TfrmSignupLogin.lbledtSignupLastNameChange(Sender: TObject);
var
  sText : String;
  k : Integer;
  bFound : Boolean;
begin
  //Input
  sText := lbledtSignUpLastName.Text;

  if sText = '' then //If last name is empty
  begin
    lblLastNameInfo.Visible := False;
    lblLastNameInfo.Caption := '';
    Exit;
  end;//if sText := ''

  if length(sText) < 2 then //If last name shorter than 2 chars
  begin
    //Change label
    with lblLastNameInfo do
      begin
        Caption := '🗵 Must be at least 2 characters';
        Font.Color := rgb(255,128,0);
        Visible := True;
      end;//with lblLastNameInfo
      Exit;
  end;//if length(sText) < 2

  if length(sText) > 15 then //If last name longer than 2 chars
  begin
    //Change label
    with lblLastNameInfo do
      begin
        Caption := '🗵 Must be less than 16 characters';
        Font.Color := rgb(255,0,0);
        Visible := True;
      end;//with lblLastNameInfo
      Exit;
  end;//if length(sText) > 15

  //No errors! Change label
  with lblLastNameInfo do
  begin
    Caption := '☑ Valid';
    Font.Color := rgb(0,153,0);
    Visible := True;
  end;//with lblContactNoInfo
end;

//--------------------------------------------\\
// Contact No Edit Changed: Validation labels \\
//--------------------------------------------\\
procedure TfrmSignupLogin.lbledtSignupNumberChange(Sender: TObject);
var
  sText : String;
  k : Integer;
  bFound : Boolean;
begin
  //Input
  sText := lbledtSignUpNumber.Text;

  if sText = '' then //If contact no is empty
  begin
    lblContactNoInfo.Visible := False;
    lblContactNoInfo.Caption := '';
    Exit;
  end;//if sText := ''

  for k := 1 to length(sText) do
  begin
    if sText[k] = ' ' then //If contact no contains space
    begin
      //Change label
      with lblContactNoInfo do
      begin
        Caption := '🗵 No spaces allowed';
        Font.Color := rgb(225,0,0);
        Visible := True;
      end;//with lblContactNoInfo
      Exit;
    end;//if sText[k] = ' '
  end;//for k := 1 to length(sText)

  for k := 1 to length(sText) do
  begin
    if NOT(sText[k] IN ['0'..'9']) then //if contact no has other chars
    begin
      //Change label
      with lblContactNoInfo do
      begin
        Caption := '🗵 Only numbers (0-9) allowed';
        Font.Color := rgb(225,0,0);
        Visible := True;
      end;//with lblContactNoInfo
      Exit;
    end;//if sText[k] = ' '
  end;//for k := 1 to length(sText)

  if length(sText) <> 10 then //if contact number not 10 chars
  begin
    //Change label
    with lblContactNoInfo do
      begin
        Caption := '🗵 Must be 10 characters';
        Font.Color := rgb(255,128,0);
        Visible := True;
      end;//with lblContactNoInfo
      Exit;
  end//if length(sText) <> 10
  else
  begin
    with lblContactNoInfo do //No errors! Chance label
      begin
        Caption := '☑ Valid';
        Font.Color := rgb(0,153,0);
        Visible := True;
      end;//with lblContactNoInfo
  end;//else of if length(sText) <> 10
  
end;

//------------------------------------------\\
// Password Edit Changed: Validation labels \\
//------------------------------------------\\
procedure TfrmSignupLogin.lbledtSignupPasswordChange(Sender: TObject);
var
  iHigh, iLow, iSpecial, iNumber, k : Integer;
  sText : String;
begin
  //Input
  sText := lbledtSignUpPassword.Text;

  if sText = '' then //If password empty
  begin
    //Not confirmable and change labels
    lblPasswordInfo.Visible := False;
    lblPasswordInfo.Caption := '';
    lbledtSignupPWConfirm.Enabled := False;
    Exit;
  end;//if sText := ''

  for k := 1 to length(sText) do
  begin
    if sText[k] = ' ' then //If password contains space
    begin
      //Not confirmable and change labels
      lbledtSignupPWConfirm.Enabled := False;
      with lblPasswordInfo do
      begin
        Caption := '🗵 No spaces allowed';
        Font.Color := rgb(225,0,0);
        Visible := True;
      end;//with lblPasswordInfo
      Exit;
    end;//if sText[k] = ' '
  end;//for k := 1 to length(sText)

  if length(sText) < 8 then //If password shorter than 8 chars
  begin
    //Not confirmable and change labels
    lbledtSignupPWConfirm.Enabled := False;
    with lblPasswordInfo do
      begin
        Caption := '🗵 Must be at least 8 characters';
        Font.Color := rgb(255,128,0);
        Visible := True;
      end;//with lblPasswordInfo
      Exit;
  end;//if length(sText) < 6

  if length(sText) > 30 then //If password longer than 30 chars
  begin
    //Not confirmable and change labels
    lbledtSignupPWConfirm.Enabled := False;
    with lblPasswordInfo do
      begin
        Caption := '🗵 Must be less than 31 characters';
        Font.Color := rgb(255,0,0);
        Visible := True;
      end;//with lblPasswordInfo
      Exit;
  end;//if length(sText) > 30

  //Processing: Test password strength
  iHigh := 0;
  iLow := 0;
  iSpecial := 0;
  iNumber := 0;

  for k := 1 to length(sText) do
  begin
    if sText[k] IN ['a'..'z'] then
      inc(iLow)
    else if sText[k] IN ['A'..'Z'] then
      inc(iHigh)
    else if sText[k] IN ['0'..'9'] then
      inc(iNumber)
    else inc(iSpecial);
  end;//for k := 1 to length(sText)

  //High Strength: aaAA###00a 2 Low, 2 High, 2 Number, 3 Special, 10+ characters (Default in demonstration: QWer12!@#$ )
  if (iLow>1) AND (iHigh>1) AND (Length(sText)>9) AND (iSpecial>2) AND (iNumber>1) then
  begin
    //Confirmable and change labels
    with lblPasswordInfo do
    begin
      Caption := '☑ High strength';
      Font.Color := rgb(0,153,0);
      Visible := True;
      lbledtSignupPWConfirm.Enabled := True;
    end;//with lblPasswordInfo
  end//if High
  //Medium Strength: aaAA#1aa 2 Low, 2 High, 1 Number, 1 Special, 8+ characters
  else if (iLow>1) AND (iHigh>1) AND (Length(sText)>7) AND (iSpecial>0) AND (iNumber>0) then
  begin
    //Confirmable and change labels
    with lblPasswordInfo do
    begin
      Caption := '☑ Medium strength';
      Font.Color := rgb(255,128,0);
      Visible := True;
      lbledtSignupPWConfirm.Enabled := True;
    end;//with lblPasswordInfo
  end//if Medium
  //Low: aaaaaaaa If not medium, then Low
  else
  begin
    //Not confirmable and change labels
    with lblPasswordInfo do
    begin
      Caption := '🗵 Low strength';
      Font.Color := rgb(255,0,0);
      Visible := True;
      lbledtSignupPWConfirm.Enabled := False;
    end;//with lblPasswordInfo
  end;//Is Low
end;

//--------------------------------------------------\\
// Password Confirm Edit Changed: Validation labels \\
//--------------------------------------------------\\
procedure TfrmSignupLogin.lbledtSignupPWConfirmChange(Sender: TObject);
var
  sPassword, sConfirm : String;
begin
  //Input
  sPassword := lbledtSignupPassword.Text;
  sConfirm := lbledtSignupPWConfirm.Text;

  if sPassword = sConfirm then //If email and confirm email the same
    lbledtSignupPWConfirm.Color := rgb(102,255,102) //green
  else
    lbledtSignupPWConfirm.Color := rgb(255,102,102);//red

end;

//------------------------------------------\\
// Username Edit Changed: Validation labels \\
//------------------------------------------\\
procedure TfrmSignupLogin.lbledtSignupUsernameChange(Sender: TObject);
var
  sText : String;
  k : Integer;
  bFound : Boolean;
begin
  //Input
  sText := lbledtSignUpUserName.Text;

  if sText = '' then //If username empty
  begin
    lblUsernameInfo.Visible := False;
    lblUsernameInfo.Caption := '';
    Exit;
  end;//if sText := ''

  for k := 1 to length(sText) do
  begin
    if sText[k] = ' ' then //If username contains space
    begin
      //Change label
      with lblUsernameInfo do
      begin
        Caption := '🗵 No spaces allowed';
        Font.Color := rgb(225,0,0);
        Visible := True;
      end;//with lblUsernameInfo
      Exit;
    end;//if sText[k] = ' '
  end;//for k := 1 to length(sText)

  if length(sText) < 6 then //If username shorter than 6 chars
  begin
    //Change label
    with lblUsernameInfo do
      begin
        Caption := '🗵 Must be at least 6 characters';
        Font.Color := rgb(255,128,0);
        Visible := True;
      end;//with lblUsernameInfo
      Exit;
  end;//if length(sText) < 6

  if length(sText) > 20 then //If username longer than 20 chars
  begin
    //Change label
    with lblUsernameInfo do
      begin
        Caption := '🗵 Must be less than 21 characters';
        Font.Color := rgb(255,0,0);
        Visible := True;
      end;//with lblUsernameInfo
      Exit;
  end;//if length(sText) > 30

  //Search for username in database
  bFound := False;
  dmCarbonFootprint.tblUsers.First;
  while NOT(dmCarbonFootprint.tblUsers.EOF) AND (bFound = False) do
  begin
    if dmCarbonFootprint.tblUsers['Username'] = sText then //If username found in database
    begin
      bFound := True;
      //Change label
      with lblUsernameInfo do
      begin
        Caption := '🗵 Username already taken';
        Font.Color := rgb(255,0,0);
        Visible := True;
      end;//with lblUsernameInfo
    end else//if dmCarbonFootprint.tblUsers['Username'] = sText
    begin
    with lblUsernameInfo do //No errors! Change labels
      begin
        Caption := '☑ Username available';
        Font.Color := rgb(0,153,0);
        Visible := True;
      end;//with lblUsernameInfo
      dmCarbonFootprint.tblUsers.Next;
    end;//else of if dmCarbonFootprint.tblUsers['Username'] = sText
  end;//while NOT(dmCarbonFootprint.tblUsers.EOF) AND (bFound = False)
end;

//-------------------------\\
// Go to Login Label Click \\
//-------------------------\\
procedure TfrmSignupLogin.lblGoLoginClick(Sender: TObject);
begin
  //Hide & Clear Signup panel
  pnlSignup.Enabled := False;
  pnlSignup.Visible := False;
  SignupClear;

  //Show Login panel
  pnlLogin.Enabled := True;
  pnlLogin.Visible := True;
end;

//--------------------------\\
// Go to Singup Label Click \\
//--------------------------\\
procedure TfrmSignupLogin.lblGoSignUpClick(Sender: TObject);
begin
  //Hide & Clear Login panel
  pnlLogin.Enabled := False;
  pnlLogin.Visible := False;
  lbledtLoginUsername.Clear;
  lbledtLoginPassword.Clear;
  imgLoginEye.Picture.LoadFromFile('imgHide.jpg');
  lbledtLoginPassword.PasswordChar := '*';
  bLoginShow := False;

  //Show Signup panel
  pnlSignup.Enabled := True;
  pnlSignup.Visible := True;
  lbledtSignupUsername.SetFocus;
end;

//-----------------------------------\\
// User Declared Procedure: LoadHelp \\
//-----------------------------------\\
//Use this procedure to show help messages
procedure TfrmSignupLogin.LoadHelp(sFileName: String);
var
  FHelp : TextFile;
  sMessage, sLine : String;
  iBut : Integer;
begin
  //Validation
  //Is the Help file there?
  if FileExists('Help\'+sFileName+'.txt') = False then
  begin
    iBut := MessageDlg('The file that is used to display this help message could not be found. Unfortunately, the program is unable to display the help message. Contact a Developer to fix this Error.',mtError,[mbAbort],0);
    Exit;
  end;

  //Input
  sMessage := '';
  AssignFile(FHelp,'Help\'+sFileName+'.txt');
  Reset(FHelp);

  //Processing
  //Generate Help message
  while NOT EOF(FHelp) do
  begin
    if sMessage = '' then //If it's the first line, do not add an empty line in the message itself
      sMessage := sLine
    else
      sMessage := sMessage + #10 + sLine;

    ReadLn(FHelp, sLine);
  end;//while NOT EOF(FHelp)

  //Output
  iBut := MessageDlg(sMessage,mtInformation,[mbOk],0);

  CloseFile(FHelp);
end;

//------------------\\
// Login Help Click \\
//------------------\\
procedure TfrmSignupLogin.btnLoginHelpClick(Sender: TObject);
begin
  LoadHelp('Login');
end;

//-------------------\\
// Login Reset Click \\
//-------------------\\
procedure TfrmSignupLogin.btnLoginResetClick(Sender: TObject);
begin
  //Clear and reset login form
  lbledtLoginUsername.Clear;
  lbledtLoginPassword.Clear;
  imgLoginEye.Picture.LoadFromFile('imgHide.jpg');
  lbledtLoginPassword.PasswordChar := '*';
  bLoginShow := False;
  lbledtLoginUsername.SetFocus;
end;

//--------------------------------------\\
// User Declared Procedure: SignupClear \\
//--------------------------------------\\
//Use this procedure to clear all components on the Signup form
procedure TfrmSignupLogin.SignupClear;
begin
  //Clear components
  lbledtSignupUsername.Clear;
  lbledtSignupPassword.Clear;
  lbledtSignupPWConfirm.Clear;
  lbledtSignupPWConfirm.Color := clWhite;
  lbledtSignupPWConfirm.Enabled := False;
  lbledtSignupFirstName.Clear;
  lbledtSignupLastName.Clear;
  cmbSignupCountries.ItemIndex := cmbSignupCountries.Items.IndexOf(DefaultCountry);
  lbledtSignupNumber.Clear;
  lbledtSignupEmail.Clear;
  lbledtSignupEmailConfirm.Clear;
  lbledtSignupEmailConfirm.Color := clWhite;
  lbledtSignupEmailConfirm.Enabled := False;
  dtpSignupDOB.Date := Date;
  cmbSignupGender.ItemIndex := -1;

  lblUsernameInfo.Visible := False;
  lblUsernameInfo.Caption := '';
  lblPasswordInfo.Visible := False;
  lblPasswordInfo.Caption := '';
  lblFirstNameInfo.Visible := False;
  lblFirstNameInfo.Caption := '';
  lblLastNameInfo.Visible := False;
  lblLastNameInfo.Caption := '';
  lblContactNoInfo.Visible := False;
  lblContactNoInfo.Caption := '';
  lblEmailInfo.Visible := False;
  lblEmailInfo.Caption := '';
  lblAgeInfo.Visible := False;
  lblAgeInfo.Caption := '';

  imgSignupEye.Picture.LoadFromFile('imgHide.jpg');
  lbledtSignupPassword.PasswordChar := '*';
  bSignupShow := False;
end;

//------------------------------\\
// Timer Triggered: Change Fact \\
//------------------------------\\
procedure TfrmSignupLogin.tmrLoginFactTimer(Sender: TObject);
var
  sFact : String;
begin
  sFact := objFactLoader.GetFact;

  lblLoginFact.Caption := sFact;
  lblSignupFact.Caption := sFact;
  tmrLoginFact.Interval := Length(sFact)*TimerMultiplier;
end;

end.
