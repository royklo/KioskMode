#------------------------------------
#     Functions Definition 
#   Do NOT TOUCH this section!  
#------------------------------------
Set-Location $PSScriptRoot
Add-Type -Path Tomin.Tools.KioskMode.dll

$WinAPI = [Tomin.Tools.KioskMode.WinApi]
$Helpers = [Tomin.Tools.KioskMode.Helper]

if (!$EdgeStartDelay) { $EdgeStartDelay = 3 }
if (!$EdgePath) { $EdgePath = 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe' }
if (!$EdgeArguments) { $EdgeArguments = '--new-window --incognito' }

function Global:Wait-ForProcess($procName, $procTitle) {
    $sw = [Diagnostics.Stopwatch]::StartNew()
    while ($true) {
        $res = Get-Process -Name $procName | Where-Object { $_.MainWindowHandle -ne ([IntPtr]::Zero) -and (!$procTitle -or $_.MainWindowTitle -eq $procTitle) }
        if ($res) {
            return $res 
        }
        Start-Sleep -Milliseconds 100
        
        if ($sw.Elapsed.TotalMinutes -gt 5) {
            Write-Error TimeOut
            return
        }
    }
}

function Global:Edge-Kiosk($Url, $MonitorNum) {
    Write-Output "starting Edge $Url , monitor: $MonitorNum"
    Start-Process $EdgePath "$EdgeArguments $Url"
    Start-Sleep -Seconds $EdgeStartDelay

    $window = (Get-Process -Name msedge | Where-Object MainWindowHandle -NE ([IntPtr]::Zero) | Select-Object -First 1).MainWindowHandle

    $WinAPI::ShowWindow($window, [Tomin.Tools.KioskMode.Enums.ShowWindowCommands]::Restore)
    $Helpers::MoveToMonitor($window, $MonitorNum)
    $Helpers::SendKey($window, '{F11}')
    Start-Sleep -Seconds $EdgeStartDelay
}

function Global:Cockpit-Start($MonitorNum) {
    Start-Process $cockpitPath

    #main window
    $window = (Wait-ForProcess .Cockpit.CommunicationSpace 'COCKPIT COMMUNICATION SPACE' | Select-Object -First 1).MainWindowHandle
    
    $WinAPI::ShowWindow($window, [Tomin.Tools.KioskMode.Enums.ShowWindowCommands]::Restore)
    $Helpers::MoveToMonitor($window, $MonitorNum)
    $WinAPI::ShowWindow($window, [Tomin.Tools.KioskMode.Enums.ShowWindowCommands]::Maximize)
}