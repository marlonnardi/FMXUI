{*******************************************************}
{                                                       }
{       FMX UI Toast Automatic disappearance            }
{                                                       }
{       Copyright (C) 2016 YangYxd                      }
{                                                       }
{*******************************************************}

unit UI.Toast;

interface

uses
  UI.Base,
  {$IFNDEF ANDROID}
  UI.Toast.AndroidLike,
  {$ENDIF}
  System.SysUtils,
  System.Classes;

type
  TToastLength = (LongToast, ShortToast);

type
  [ComponentPlatformsAttribute(AllCurrentPlatforms)]
  TToastManager = class(TComponent)
  private
    {$IFNDEF ANDROID}
    FToast: TToast;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Toast(const Msg: string);
  end;

procedure Toast(const Msg: string; Duration: TToastLength = ShortToast);

implementation

{$IFDEF ANDROID}
uses
  UI.Toast.Android;
{$ELSE}
var
  [Weak] LToast: TToast = nil;
{$ENDIF}

{$IFDEF ANDROID}
procedure Toast(const Msg: string; Duration: TToastLength = ShortToast);
begin
  UI.Toast.Android.Toast(Msg, Duration);
end;
{$ENDIF}

{$IFNDEF ANDROID}
procedure Toast(const Msg: string; Duration: TToastLength = ShortToast);
begin
  if (LToast <> nil) and (Msg <> '') then
    LToast.ShowToast(Msg);
end;
{$ENDIF}

{ TToastManager }

constructor TToastManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFNDEF ANDROID}
  if not (csDesigning in ComponentState) then begin
    FToast := TToast.Create(AOwner);
    LToast := FToast;
  end;
  {$ENDIF}
end;

destructor TToastManager.Destroy;
begin
  {$IFNDEF ANDROID}
  FToast := nil;
  {$ENDIF}
  inherited;
end;

procedure TToastManager.Toast(const Msg: string);
begin
  UI.Toast.Toast(Msg);
end;

initialization

finalization

end.
