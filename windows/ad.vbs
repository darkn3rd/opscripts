on error resume next
Const ADS_SCOPE_SUBTREE = 2
Const ADS_PROPERTY_CLEAR = 1
Const ADS_PROPERTY_UPDATE = 2
dim samname,uidnumber
samname= InputBox("Enter SAMAccountName :")
 
Set objConnection = CreateObject("ADODB.Connection")
Set objCommand = CreateObject("ADODB.Command")
objConnection.Provider = "ADsDSOObject"
objConnection.Open "Active Directory Provider"
Set objCOmmand.ActiveConnection = objConnection
objCommand.CommandText = "Select distinguishedname  from ‘LDAP://DC=<xxx>,DC=<xxx>' " & "where objectCategory='person' and objectclass='user' and samaccountname='" & samname & "‘"
objCommand.Properties("Page Size") = 1000
objCommand.Properties("Timeout") = 30
objCommand.Properties("Searchscope") = ADS_SCOPE_SUBTREE
objCommand.Properties("Cache Results") = False
Set objRecordSet = objCommand.Execute
objRecordSet.MoveFirst
 
Do Until objRecordSet.EOF
   strUserDN = objRecordSet.Fields("distinguishedname").Value
   set objuser = GetObject("LDAP://" & strUserDN & "")

   uid = ""
   objuser.GetInfoEx Array("uid", "sn"), 0
   For Each value in objuser.GetEx("uid")
     uid = uid & "" & value & ";"
   Next
   uid = Mid(uid,1,len(uid)-1)
   uid = InputBox("Please Enter the value for the Uid value","",uid)
   pos=InStr(uid,";")
   if pos <> 0 and not isempty(uid) then
     uidarray = Split(uid,";")
     dim strarr()
     dim i
     For i = lbound(uidarray) to ubound(uidarray)
       redim preserve strarr(i)
       strarr(i) = uidarray(i)
     Next
     if (ubound(uidarray)>=0) then
       objuser.PutEx ADS_PROPERTY_CLEAR,"uid", 0
       objuser.SetInfo
       objuser.GetInfoEx Array("uid"), 0
       objuser.PutEx ADS_PROPERTY_UPDATE, "uid", strarr
       objuser.SetInfo
     end if
   else
     objuser.Put "uid", uid
     objuser.SetInfo
   end if

   uidNumber = ""
   uidNumber = objuser.Get("uidNumber")
   uidNumber = InputBox("Please Enter the value for the uidNumber value","",uidNumber)
   objUser.Put "uidNumber", uidNumber
   objuser.setinfo  
   
   gidNumber = ""
   gidNumber = objuser.Get("gidNumber")
   gidNumber = InputBox("Please Enter the value for the gidNumber value","",gidNumber)
   objUser.Put "gidNumber", gidNumber
   objuser.setinfo
          
   unixHomeDirectory = ""
   unixHomeDirectory = objuser.Get("unixHomeDirectory")
   unixHomeDirectory = InputBox("Please Enter the value for the unixHomeDirectory value","",unixHomeDirectory)
   objUser.Put "unixHomeDirectory", unixHomeDirectory
   objuser.setinfo
   
   loginShell = ""
   loginShell = objuser.Get("loginShell")
   loginShell = InputBox("Please Enter the value for the loginShell value","",loginShell)
   objUser.Put "loginShell", loginShell
   objuser.setinfo  

   msSFU30Name = ""
   msSFU30Name = objuser.Get("msSFU30Name")
   msSFU30Name = InputBox("Please Enter the value for the msSFU30Name value","",msSFU30Name)
   objUser.Put "msSFU30Name", msSFU30Name
   objuser.setinfo
   objuser.setinfo
   set objuser = nothing
objRecordSet.MoveNext
Loop
