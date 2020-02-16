unit UBackup;

interface

uses
  System.SysUtils, System.Classes;

type TBackup = class(TObject)
  private
    //usar para declarar objeto backup
  public
    constructor Create;
    destructor Destroy; override;
end;

implementation

{ TConfig }

constructor TBackup.Create;
begin
  inherited;
end;

destructor TBackup.Destroy;
begin
  inherited;
end;

end.
