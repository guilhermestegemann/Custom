object Backup: TBackup
  OldCreateOrder = False
  DisplayName = 'BackupService'
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 150
  Width = 215
  object Timer: TTimer
    Interval = 5000
    OnTimer = TimerTimer
    Left = 96
    Top = 64
  end
end
