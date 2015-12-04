@ECHO OFF
REM *************************************************
REM * Browse SQL Servers (browsql.bat)
REM *************************************************
REM * Requirements: 
REM *   browstat.exe - w2k reskit, w2k3/xp spprt tools
REM *     Microsoft LAN Manager DLL (NETAPI32.DLL)
REM *************************************************     
REM * Description:
REM *   List SQL Servers on subnet broadcasting 
REM *   MS SQL services.  
REM *************************************************
REM * Author:  Joaquin Menchaca (JM)
REM *   Copyright 2012 - Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)
REM *************************************************
REM * Updates:
REM *   20060406 JM  Document Creation
REM *************************************************
 
FOR /F "TOKENS=2" %%a IN ('browstat VIEW Transport^|find "\Device\"') DO (
 FOR /F "TOKENS=1,4" %%b IN ('browstat VIEW %%a^|findstr /L /B "\\"^|find "SQL"') DO (
  FOR /F "DELIMS=\ TOKENS=1" %%d IN ('echo %%b') DO ( echo %%d )
 )
)
