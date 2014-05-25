@ECHO OFF
REM *************************************************
REM *  testLogParser.cmd
REM *************************************************
REM *  Author:  Joaquin Menchaca (JM)
REM *  Copyright 2012 - Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)
REM *************************************************
REM *  Updates:
REM *   20070725 JM  Document Creation
REM ************************************************
 
SETLOCAL
 
SET INPUTFORMAT=-i:FS -recurse:0
SET OUTPUTFORMAT=-o:NAT -rtp:-1
 
SET SELECT=SELECT Name, Size
SET FROM=FROM C:\Windows\System32\*.exe
SET WHERE=WHERE SIZE ^> 300000
SET ORDER=ORDER BY Size DESC
SET QUERY="%SELECT% %FROM% %WHERE% %ORDER%"
 
logparser %QUERY% %INPUTFORMAT% %OUTPUTFORMAT%
