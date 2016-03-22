################## Import Nimble Storage CMD-LETS ##################

#iex (new-object System.Net.WebClient).DownloadString('https://raw.github.com/jrich523/NimblePowerShell/master/Install.ps1')

################## Connect to Nimble  ##################
Connect-NSArray -SystemName "IPADDRESSOFNIMBLE" -Password password   

################## Array of LUNs ######################
			
$jdelogpluns = @("Nimble Lun","Nimble Lun") #InitiatorGroup Name
			
################## Create JDE Clones - Production ################

foreach ($lun in $jdelogpluns) {	
	
	$lunname = $lun + "-DR"
	Get-NSSnapShot $lun| New-NSClone -Name $lunname
	Write-host $lunname "Created"
	Start-Sleep -Seconds 5
	Add-NSInitiatorGroupToVolume -InitiatorGroup JDELOGP -Volume $lunname -Access Volume
	Write-host $lunname " Initator Created"
}
