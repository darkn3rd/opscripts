' *************************************************
' *  getyesterday.vbs
' *   returns date of yesterday
' *************************************************
' *  Author:  Joaquin Menchaca (JM)
' *  Copyright 2012 - Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)
' *************************************************
' *  Updates:
' *   20070817 JM  Document Creation
' *************************************************
' *  References:
' *   Hey, Scripting Guy! - How Can I Get Yesterday's Date?
' *   http://www.microsoft.com/technet/scriptcenter/resources/qanda/aug04/hey0803.mspx
' *************************************************

dtmYesterday = Date() - 1
Wscript.Echo dtmYesterday
