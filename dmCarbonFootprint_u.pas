unit dmCarbonFootprint_u;

interface

uses
  SysUtils, Classes, DB, ADODB, Dialogs{, CarbonFootprint1_u};

type
  TdmCarbonFootprint = class(TDataModule)
    conCarbonFootprint: TADOConnection;
    tblUsers: TADOTable;
    dscUsers: TDataSource;
    tblEmission: TADOTable;
    dscEmission: TDataSource;
    tblElectricity: TADOTable;
    dscElectricity: TDataSource;
    tblGenerator: TADOTable;
    dscGenerator: TDataSource;
    qryElectricity: TADOQuery;
    dscElecSQL: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmCarbonFootprint: TdmCarbonFootprint;

implementation

{$R *.dfm}

procedure TdmCarbonFootprint.DataModuleCreate(Sender: TObject);
var
  iBut : Integer;
begin
  try
    tblUsers.Active := True;
    dscUsers.DataSet.Active := True;
    //tblTickets.Active := True;
    //dscTickets.DataSet.Active := True;
    tblEmission.Active := True;
    dscEmission.DataSet.Active := True;
    tblElectricity.Active := True;
    dscElectricity.DataSet.Active := True;
    tblGenerator.Active := True;
    dscGenerator.DataSet.Active := True;
  except
    iBut := MessageDlg('There seems to be an issue with loading the Databases. Unfortunately, this is required to use the program. Contact a Developer to fix this Error.',mtError,[mbAbort],0);
    //CarbonFootprint1_u.frmSignupLogin.Free;
  end;

end;

end.
