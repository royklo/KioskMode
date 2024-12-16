# Microsoft Edge Kiosk Mode

Moves browser windows in full screen to several displays, creating a sort of Kiosk mode on Windows with multiple displays.

## Features

- Start all browser instances in full screen mode automatically
- Move them to certain monitors
- Allow opening multiple tabs (e.g., to cycle through the tabs)

## Why Not Alternative Solutions?

### Alternative 1 - Native CLI

Example from Stack Overflow Answer:

```ps
start msedge.exe --app="http://www.domain1.com" --window-position=0,0 --kiosk --user-data-dir=c:/monitor1
```

**Downsides:**
- Requires profile folders per monitor
- App mode does not allow tabs 😕

### Alternative 2 - Native CLI + Javascript

Example from Another Stack Overflow Answer:

```ps
"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" 
    --profile-directory="Default"
    --app="data:text/html,<html><body><script>window.moveTo(580,240);window.resizeTo(800,600);window.location='http://www.test.de';</script></body></html>"
```

**Downsides:**
- Works only in app mode, which does not allow tabs 😕

## Steps

1. **Download and Extract**
   - Download the latest release and extract contents to `C:\Kiosk-Mode`. You may put it into another folder – but ensure you rename the path in all places.

2. **Modify Kiosk.ps1**
   - Put necessary URLs and monitor numbers (starting from 1).

3. **Enable Scripts Execution**
   - Run PowerShell as Administrator and execute the following, confirm when prompted:
    ```ps
    Set-ExecutionPolicy RemoteSigned
    ```

4. **Launch Shortcut**
   - Double click on the link (`Start – Kios – modifypath.lnk`) to ensure browsers are started and opened on necessary displays. Note: you may need to modify your link if you put the file not into `C:\Kiosk-Mode`. Right click on it -> properties and fill it accordingly.

5. **Autostart**
   - Copy the link/shortcut to the desktop for easy access and to your startup folder.

## Troubleshooting

- If the window is not moved to another desktop – try increasing the delay in the script (add `-StartDelay` parameter to commands).
- The script has been tested on a Windows 11 machine.# KioskMode
