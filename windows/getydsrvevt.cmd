@echo off
REM *************************************************
REM *   getydsrvevt.cmd
REM *     Grabs Error and Warning events from all the
REM *     domain controllers in the forest
REM *************************************************
REM *   Requirements:
REM *     eventquery.vbs   - winxp/2k3    
REM *       cmdlib.wsc     - winxp/2k3  
REM *     dsquery          - win2k3
REM *     getyesterday.vbs - any
REM *************************************************     
REM *   Note:
REM *     This script checks for Windows 2003, but
REM *     can work with Windows XP + AdminPak
REM *************************************************
REM *   Author:  Joaquin Menchaca (JM)
REM *   Copyright 2012 - Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)
REM *************************************************
REM *   Updates:
REM *     20061020 JM  Document Creation
REM *     20070817 JM  Added mechanism for getting yesterday
REM *************************************************
 
SETLOCAL
SET LOGTYPES="Application","System","Directory Service","File Replication Service"
SET CSCRIPT=CSCRIPT //NOLOGO
SET EVENTQUERY=%CSCRIPT% %SYSTEMROOT%\system32\eventquery.vbs
SET TYPEFLTR=/FI "TYPE eq ERROR or TYPE eq WARNING"
SET FORMAT=/FO CSV
 
rem -- reference a vbscript as process way complex in batch
SET GETYESTERDAY=%CSCRIPT% getYesterday.vbs
 
REM ========== Check Version ========================
  rem split on "[]" to get only version string 
  for /f "tokens=2 delims=[] usebackq" %%a in (`ver`) do (
    rem split on spaces to get numeral data
    for /f "tokens=2" %%b in ("%%a") do (
      rem split on "." to extract major revision number
      for /f "tokens=1-2 delims=." %%c in ("%%b") do (
         set vers=%%c.%%d
      )
    )
  )
 
  if "%VERS%" lss "5.2" ( goto :WRONGVERSION )
REM =================================================
 
REM ========== Set Yesterday ========================
  rem -- from subshell rip out components
  for /f "tokens=1-3 delims=/ usebackq" %%a in (`%GETYESTERDAY%`) do ( 
    set month=%%a
    set day=%%b
    set year=%%c
  )
   
  rem -- configure date format for eventquery script --
  set yesterday=%MONTH%/%DAY%/%YEAR%,12:00:00am
REM =================================================
 
REM ========== Query Events from DCs ================
  set datefltr=/FI "DateTime gt %YESTERDAY%"
  set outfile=%YEAR%%MONTH%%DAY%.serverevts.log.csv
 
  echo %OUTFILE%
   
  rem -- grab list of all servers --
  for /f "tokens=2 delims==, usebackq" %%a in (`dsquery server`) do ( 
    rem -- foreach server grab events and output to file
    for /f "tokens=1-4 delims=," %%b in ("%LOGTYPES%") do (
      echo %EVENTQUERY% /s %%a /l %%b %TYPEFLTR% %DATEFLTR% %FORMAT% /V > %outfile%
      echo %EVENTQUERY% /s %%a /l %%c %TYPEFLTR% %DATEFLTR% %FORMAT% /NH /V >> %outfile%
      echo %EVENTQUERY% /s %%a /l %%d %TYPEFLTR% %DATEFLTR% %FORMAT% /NH /V >> %outfile%
      echo %EVENTQUERY% /s %%a /l %%e %TYPEFLTR% %DATEFLTR% %FORMAT% /NH /V >> %outfile%
    )   
  )
REM =================================================
 
goto :EXIT
REM =================================================
 
:WRONGVERSION
echo\
echo   This command file only works with Windows 2003 or greater.
echo\
 
:EXIT
