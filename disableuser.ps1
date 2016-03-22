$user = Read-Host 'Username to Disable?'

#Disable-ADAccount -Identity $user

$MemberofGroups = Get-ADUser -Identity $user -Properties memberof | select -ExpandProperty memberof 

#write-host $MemberofGroups
$MemberofGroups | out-file ".\$user Groups.csv"


Dir C:\Scripts\Powershell\DisableUser\*.csv | Start-Process -FilePath ".\$user Groups.csv" –Verb Print





############################################################################### 
 
###########Define Variables######## 
 
$fromaddress = "userdisabled@domain.local" 
$toaddress = "user@domain.local" 
$Subject = "$user Disabled" 
$body = "$user has been disabled and moved to the $OU organizational unit.  Attached is a list of the groups the user belongs too." 
#$body = $MemberofGroups 
$attachment = "C:\Scripts\Powershell\DisableUser\$user Groups.txt" 
$smtpserver = "smtp.domain.local" 
 
#################################### 
 
$message = new-object System.Net.Mail.MailMessage 
$message.From = $fromaddress 
$message.To.Add($toaddress) 
$message.CC.Add($CCaddress) 
$message.Bcc.Add($bccaddress) 
$message.IsBodyHtml = $True 
$message.Subject = $Subject 
$attach = new-object Net.Mail.Attachment($attachment) 
$message.Attachments.Add($attach) 
$message.body = $body 
$smtp = new-object Net.Mail.SmtpClient($smtpserver) 
#$smtp.Send($message) 
 
#################################################################################
