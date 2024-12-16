######################################################
##########            Kiosk Mode          ############
######################################################
#
# Runs Edge and other apps in full-screen mode 
# on predefined screens
# ----------------------------------------------------

$EdgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$EdgeArguments = '--new-window --incognito'
# if Window not moved (especially on machine start) - try increaing the delay. 
$EdgeStartDelay = 3

#Set-Location $PSScriptRoot
.\HelperFunctions.ps1

# Kill all running instances
# &taskkill /im msedge* /F

Edge-Kiosk 'https://google.com' -MonitorNum 1 
Edge-Kiosk 'https://github.com' -MonitorNum 2

