#remove old test snaps

################## Connect to Nimble Storage ##################
Connect-NSArray -SystemName "IPADDRESS OF NIMBLE" -Password password   

############### Prod

Set-NSVolumeState "Name of the Lun" -offline

Remove-NSVolume "Name of the Lun" -force





