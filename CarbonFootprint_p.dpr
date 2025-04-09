program CarbonFootprint_p;

uses
  Forms,
  CarbonFootprint1_u in 'CarbonFootprint1_u.pas' {frmSignupLogin},
  clsFactLoader_u in 'clsFactLoader_u.pas',
  dmCarbonFootprint_u in 'dmCarbonFootprint_u.pas' {dmCarbonFootprint: TDataModule},
  NormalUser_u in 'NormalUser_u.pas' {frmNormalUser},
  clsGenerator_u in 'clsGenerator_u.pas',
  Admin_u in 'Admin_u.pas' {frmAdmin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Carbon Footprint Calculator';
  Application.CreateForm(TfrmSignupLogin, frmSignupLogin);
  Application.CreateForm(TdmCarbonFootprint, dmCarbonFootprint);
  Application.CreateForm(TfrmNormalUser, frmNormalUser);
  Application.CreateForm(TfrmAdmin, frmAdmin);
  Application.Run;
end.
