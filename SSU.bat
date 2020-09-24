@echo off
chcp 65001
mode con: cols=130 lines=30
color 07
title Sistema Secundario de Usuario
@echo off
goto A

============================================

		EXTRAS

:FAIL
echo Invalid Password 
pause>nul
goto A

============================================

:A
cls
set /p pass=<lg4.cfg
type lg.cfg
echo.
echo By Bloutware™
echo -------------------------------------------------------------Beta 3.7------------------------------------------------------------- 
echo.
set "psCommand=powershell -Command "$pword = read-host 'Password' -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
      [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
        for /f "usebackq delims=" %%p in (`%psCommand%`) do set pw=%%p
if NOT %pw%==%pass% goto :FAIL


:MAIN
cls
set /p pass=<lg4.cfg
type wlcm.cfg
echo.
echo.
echo ============= INDICE =============
cmdMenuSel f870 "General" "NULL" "Password" "NULL" "NULL"

IF %ERRORLEVEL% == 1 goto GENERAL
IF %ERRORLEVEL% == 2 goto MAIN
IF %ERRORLEVEL% == 3 goto PASS
IF %ERRORLEVEL% == 4 goto MAIN
IF %ERRORLEVEL% == 5 goto MAIN

:GENERAL
cls
echo.
echo.
echo ============= GENERAL =============
cmdMenuSel f870 "Commands" "Notes" "Del Recents" "Downloads" "Run As Invoker" "Windows" "back"

IF %ERRORLEVEL% == 1 goto SEL3
IF %ERRORLEVEL% == 2 goto SEL20
IF %ERRORLEVEL% == 3 goto SEL16
IF %ERRORLEVEL% == 4 goto DOWN
IF %ERRORLEVEL% == 5 goto RAI
IF %ERRORLEVEL% == 6 goto WIN
IF %ERRORLEVEL% == 7 goto MAIN

:SEL16
reg import recent.reg
goto GENERAL

:RAI
cls
echo.
echo.
echo ============= RUN AS INVOKER =============
echo.
echo.
echo Choose a file.
echo.
set ps_cmd=powershell "Add-Type -AssemblyName System.Windows.Forms|Out-Null; $f=New-Object System.Windows.Forms.OpenFileDialog; $f.InitialDirectory=pwd; $f.Filter='All files (*.*)|*.*'; $f.ShowHelp=$true; $f.Multiselect=$false; $f.ShowDialog()|Out-Null; $f.FileName"
		for /f "delims=" %%I in ('%ps_cmd%') do set "filename=%%I"
if NOT defined filename goto GENERAL

set __COMPAT_LAYER=RunAsInvoker
start "%filename%" "%filename%"
goto GENERAL


:DOWN
cls
echo.
echo.
echo ============= DOWNLOADS =============
cmdMenuSel f870 "Videos" "Others" "back"

IF %ERRORLEVEL% == 1 goto YTDL
IF %ERRORLEVEL% == 2 goto MAIN
IF %ERRORLEVEL% == 3 goto MAIN


:YTDL
cls
echo.
echo.
echo ============= VIDEOS =============
echo.
echo.
set /p link="Video Link: "
ytdl %link%
pause>nul
goto GENERAL


:SEL3
cls
echo.
echo commands
echo.
cmdMenuSel f870 "Audio Gain" "MsgBox" "Voice" "back"

IF %ERRORLEVEL% == 1 set text=video
IF %ERRORLEVEL% == 2 set text=msgbox
IF %ERRORLEVEL% == 3 set text=voice
IF %ERRORLEVEL% == 4 goto GENERAL

:Texts
cls
type %text%.txt
pause>nul
goto SEL3

:SEL20
cls
type notes.txt
echo.
echo.
cmdMenuSel f870 "AddNote" "DelNotes" "back"

IF %ERRORLEVEL% == 1 goto SEL21
IF %ERRORLEVEL% == 2 goto SEL22
IF %ERRORLEVEL% == 3 goto GENERAL

:SEL21
set /p note="AddNote: "
echo %note%>> notes.txt
goto SEL20

:SEL22
del notes.txt
echo Deleted.
pause>nul
goto SEL20



:PASS
cls
echo.
echo ============= CHANGE PASSWORD =============
echo.
echo ID Check
set "psCommand=powershell -Command "$pword = read-host 'Old Password' -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
      [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
        for /f "usebackq delims=" %%p in (`%psCommand%`) do set pw=%%p
if NOT %pw%==%pass% echo Incorrect Password && pause>nul && goto PASS
cls
echo.
echo ============= CHANGE PASSWORD =============
echo.
echo [WARNING]: There'll be no confirmation. Check it twice.
echo.
set /p word="New Password: "
echo %word% > lg4.cfg
echo Password Changed.
pause>nul
goto MAIN


:WINDOWS
cls
echo.
echo ============= WINDOWS =============
echo.
echo. "slmgr/upk" to wipe old keys
echo.
set p/ serial="Serial (with dashs): "
pause
goto MAIN
pause
slmgr.vbs /ipk %serial%
pause
slmgr.vbs /skms kms.lotro.cc
pause
slmgr.vbs /ato
pause
echo Activated.
pause>nul
goto MAIN


EXIT
