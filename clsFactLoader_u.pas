unit clsFactLoader_u;

interface

type
  TFactLoader = class(TObject)
    private
    const
      //Change this value to have more than 1000 facts
      MaxFacts = 1000;
      NoFileErrorMsg = 'Error: No Facts/Tips Found';
    var
      //fFactCount: Integer;
      farrFacts: Array[1..MaxFacts] of String;
      farrUsedFacts: Array[1..MaxFacts] of Boolean;
      farrHeadings: Array[1..MaxFacts] of String;
      fFactCount: Integer;
      fLastUsed : Integer;

    public
      constructor Create(sFile : String);
      function GetFact:String;
      function GetNextFact:String;
      function GetNextHeading:String;
      function GetFactCount:Integer;
    end;

implementation

uses
  SysUtils, Math, Dialogs;

{ TFactLoader }

//This is used to create the object.
//sFile specifies the file name where the facts will be loaded
// from
constructor TFactLoader.Create(sFile : String);
var
  FFactFile : TextFile;
  sFact : String;
  k, iBut : Integer;
begin
  //Assign File
  AssignFile(FFactFile,'Facts/'+sFile+'.txt');

  //Test if the file Exists
  if FileExists('Facts/'+sFile+'.txt') = False then //Show Error if File does not Exist
  begin
    iBut := MessageDlg('Could not find Fact file! Continuing without Facts.',mtError,[mbOk],0);
    farrFacts[1] := NoFileErrorMsg;
    fFactCount := 1;
    Exit;
  end;//if FileExists = False

  Reset(FFactFile);

  //Initialise
  fLastUsed := 0;
  fFactCount := 0;

  //Load Facts into Arrays
  if Pos('Facts',sFile) <> 0 then //If file name contains 'Facts', no headings will be used
  begin
    while (NOT(EOF(FFactFile))) AND (fFactCount < MaxFacts) do
    begin
      ReadLn(FFactFile, sFact);
      inc(fFactCount,1);
      farrHeadings[fFactCount] := '';
      farrFacts[fFactCount] := sFact;

    end;//while
  end//if
  else //If the file name does not contain 'Facts', headings will be used
  begin
    while (NOT(EOF(FFactFile))) AND (fFactCount < MaxFacts) do
    begin
      ReadLn(FFactFile, sFact);
      //If not empty, and first char is a *: Heading
      if (Length(sFact) <> 0) AND (sFact[1] = '*') then
      begin
        inc(fFactCount,1);
        farrHeadings[fFactCount] := Copy(sFact,2);
      end else
      //If not empty and first char comething else: Normal fact
      if (Length(sFact) <> 0) AND (sFact[1] <> '*') then
        farrFacts[fFactCount] := sFact;
    end;//while
  end;//else

  //Change all the Facts to not used
  for k := 1 to fFactCount do
  begin
    farrUsedFacts[k] := False;
  end;//for k

  CloseFile(FFactFile);

end;

//This function retrieves a random fact from farrFacts,
// and returns it.
//Facts will only be repeated once all facts have been returned.
function TFactLoader.GetFact: String;
var
  k, iFact : Integer;
  bReset : Boolean;
begin
  //Generate rancom number
  iFact := RandomRange(1,fFactCount+1);

  while farrUsedFacts[iFact] = True do //If the Fact is already used, get a new Fact
  begin
    iFact := RandomRange(1,fFactCount+1)
  end;//while

  farrUsedFacts[iFact] := True;
  Result := farrFacts[iFact];//Return value

{$REGION 'Check if all Facts are used'}
  bReset := True;
  for k := 1 to fFactCount do
  begin
    if farrUsedFacts[k] = False then
      bReset := False;
  end;//for

  if bReset = True then
  begin
    for k := 1 to fFactCount do
      farrUsedFacts[k] := False;
  end;//if
{$ENDREGION}
end;

//Returns the value of fFactCount
function TFactLoader.GetFactCount: Integer;
begin
  result := fFactCount;
end;

//This function retrieves a fact in order from farrFacts,
// and returns it. A random fact will not be returned.
//Facts cannot be repeated.
function TFactLoader.GetNextFact: String;
begin
  result := farrFacts[fLastUsed];
end;

//This function retrieves the heading from farrHeadings,
// and returns it.

function TFactLoader.GetNextHeading: String;
begin
  inc(fLastUsed);
  farrUsedFacts[fLastUsed] := True;
  result := farrHeadings[fLastUsed];
end;

end.
