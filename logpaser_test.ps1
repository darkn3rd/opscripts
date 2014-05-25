# *************************************************
# *  testLogParser.ps
# *************************************************
# *  Author:  Joaquin Menchaca (JM)
# *  Copyright 2012 - Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)
# *************************************************
# *  Updates:
# *   20070725 JM  Document Creation
# *************************************************
$objLogParser=New-Object -comobject MSUtil.LogQuery
$objInputFormat=New-Object -comobject MSUtil.LogQuery.FileSystemInputFormat
$objInputFormat.recurse=0

$objOutputFormat=New-Object -comobject MSUtil.LogQuery.NativeOutputFormat
$objOutputFormat.rtp=-1

$strQuery="SELECT Name, Size FROM C:\Windows\System32\*.exe WHERE SIZE > 300000 ORDER BY Size DESC"
$objLogParser.ExecuteBatch($strQuery, $objInputFormat, $objOutputFormat)
