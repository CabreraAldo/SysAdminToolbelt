Import-Module ActiveDirectory

$accountsexp = Search-ADAccount -AccountExpiring -TimeSpan "14"

$Target = @()

foreach ( $account in $accountsexp){

	$TargetObject = get-aduser -identity $account  -Properties * | select name, samaccountname,department, AccountExpirationDate, manager
	
	$Target += $TargetObject
	
	} 
	
write-host $Target | Format-Table -wrap

$Target | export-csv C:\Scripts\ExpiringAccounts\report.csv -NoTypeInformation


Start-Sleep -s 4

$filename = “C:\Scripts\ExpiringAccounts\report.csv” 
$t = Get-Date
$smtpServer = “SMTP.domain.local” 
$msg = new-object Net.Mail.MailMessage 
$att = new-object Net.Mail.Attachment($filename) 
$smtp = new-object Net.Mail.SmtpClient($smtpServer) 
$msg.From = “ADAccountsExpiring@domain.local” 
#$msg.To.Add("user@domain.local")
$msg.Subject = “CHECK THE ATTACHMENT: Accounts Expiring in the Next 14 Days Attached” 
$msg.Body = “The attached will show accounts expiring in the next 14 days” 
$msg.Attachments.Add($att) 
$smtp.Send($msg) 
 
