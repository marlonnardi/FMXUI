unit UI.ListView.Header;

interface

uses
  UI.ListView,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UI.Base, UI.Standard;

type
  /// <summary>
  /// ListView default header
  /// </summary>
  TListViewDefaultHeader = class(TFrame, IListViewHeader)
    RelativeLayout1: TRelativeLayout;
    tvText: TTextView;
    AniView: TAniIndicator;
    vImg: TView;
    View2: TView;
  private
    { Private declarations }
    FStatePullDownStart, FStatePullDownOK, FStatePullDownFinish, FStatePullDownComplete: string;
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
    procedure DoUpdateState(const State: TListViewState; const ScrollValue: Double);
    procedure SetStateHint(const State: TListViewState; const Msg: string);
  end;

implementation

{$R *.fmx}

uses
  UI.Frame;

{ TListViewDefaultHeader }

constructor TListViewDefaultHeader.Create(AOwner: TComponent);
begin
  inherited;
  FStatePullDownStart := 'Pull down to refresh';
  FStatePullDownOK := 'Release and refresh immediately';
  FStatePullDownFinish := 'Refreshing...';
  FStatePullDownComplete := 'Refresh completed';
end;

procedure TListViewDefaultHeader.DoUpdateState(const State: TListViewState;
  const ScrollValue: Double);
begin
  case State of
    TListViewState.None, TListViewState.PullDownStart:
      begin
        AniView.Visible := False;
        AniView.Enabled := False;
        tvText.Text := FStatePullDownStart;
        tvText.Checked := False;
        vImg.Visible := True;
        vImg.Checked := False;
        Visible := State <> TListViewState.None;
      end;

    TListViewState.PullDownOK:
      begin
        AniView.Visible := False;
        AniView.Enabled := False;
        tvText.Text := FStatePullDownOK;
        tvText.Checked := False;
        vImg.Visible := True;
        vImg.Checked := True;
      end;

    TListViewState.PullDownFinish:
      begin
        vImg.Visible := False;
        AniView.Enabled := True;
        AniView.Visible := True;
        tvText.Text := FStatePullDownFinish;
        tvText.Checked := False;
      end;

    TListViewState.PullDownComplete:
      begin
        vImg.Visible := False;
        AniView.Enabled := False;
        AniView.Visible := False;
        tvText.Text := FStatePullDownComplete;
        tvText.Checked := True;
      end;
  end;
end;

procedure TListViewDefaultHeader.SetStateHint(const State: TListViewState;
  const Msg: string);
begin
  case State of
    TListViewState.None, TListViewState.PullDownStart:
      FStatePullDownStart := Msg;
    TListViewState.PullDownOK:
      FStatePullDownOK := Msg;
    TListViewState.PullDownFinish:
      FStatePullDownFinish := Msg;
    TListViewState.PullDownComplete:
      FStatePullDownComplete := Msg;
  end;
end;

end.
