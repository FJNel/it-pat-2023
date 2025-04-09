  unit clsGenerator_u;

interface

type
  TGenerator = class(TObject)
  private
  var
    fName : String;
    fBrand : String;
    fType : String;
    fCapacity : Real;
    fEmissions : Real;
    fConsumed : Integer;
  public
    constructor Create(sName, sBrand , sType : String; rCapacity, rEmissions : Real);
    Function CalculateEmissions:Real;
    Procedure SetConsumed(iLitres:Integer);
    Function GetConsumed:Integer;
    Function GetEmission:Real;
    Function CreateEmissionType:String;
    Function ToString:String;
    Function CalculateLiters(iMin:Integer):Integer;
  end;

implementation

uses
  SysUtils, Math;

{ TGenerator }

//Sets the amount of Litres consumed by setting fConsumed to
// the value of iLitres
function TGenerator.CalculateEmissions: Real;
begin
  result := fConsumed * fEmissions;
end;

//Calculates the amount of litres consumed, using fType and iMin
function TGenerator.CalculateLiters(iMin:Integer): Integer;
var
  rConsumption : Real;
begin
  //For illustration only: Average fuel consumed per kVA per hour, according to generator type
  rConsumption := 0;
  if fType = 'Diesel' then
    rConsumption := 0.35;
  if fType = 'Petrol' then
    rConsumption := 0.45;
  if fType = 'LP Gas' then
    rConsumption := 0.4;
  if fType = 'Natural Gas' then
    rConsumption := 0.3;
  //Returns the amount used depending on generator type
  result := Ceil(fCapacity * rConsumption * iMin/60);

end;

//This is used to create the object using the parameters.
constructor TGenerator.Create(sName, sBrand , sType : String; rCapacity, rEmissions : Real);
begin
  fName := sName;
  fBrand := sBrand;
  fType := sType;
  fCapacity := rCapacity;
  fEmissions := rEmissions;
  fConsumed := 0;
end;

//Creates the emission type that is used in the Database, using
// the object’s attributes
function TGenerator.CreateEmissionType: String;
begin
  result := 'G '+fBrand+' '+fName+' '+FloatToStrF(fCapacity,ffFixed,5,2)+' ('+fType[1]+')';
end;

//Returns the value of fConsumed
function TGenerator.GetConsumed: Integer;
begin
  result := fConsumed;
end;

//Returns the value of fEmissions
function TGenerator.GetEmission: Real;
begin
  result := fEmissions;
end;

//Sets the amount of Litres consumed by setting fConsumed to
// the value of iLitres
procedure TGenerator.SetConsumed(iLitres: Integer);
begin
  fConsumed := iLitres;
end;

//Returns the object’s attributes so that it can be displayed in
// a richedit

function TGenerator.ToString: String;
begin
  result := '';
  result := result + 'Name: '+#9+fName;
  result := result +#10+ 'Brand: '+#9+fBrand;
  result := result +#10+ 'Type: '+#9+fType;
  result := result +#10+ 'Capacity: '+#9+FloatToStrF(fCapacity,ffFixed,10,2)+' kVA or kW';
  result := result +#10+ 'Emissions: '+#9+FloatToStrF(fEmissions,ffFixed,10,2)+' kg CO2e per Liter consumed';
end;

end.
