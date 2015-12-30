
function Init-Domain {

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

Import-Module ADDSDeployment
Install-ADDSForest `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainMode Win2008R2 `
    -DomainName "mikelab.local" `
    -DomainNetBIOSName "MIKELAB" `
    -ForestMode Win2008R2 `
    -InstallDNS:$true `
    -LogPath "C:\Windows\NTDS" `
    -NoRebootOnCompletion:$false `
    -SYSVOLPath "C:\Windows\SYSVOL" `
    -Force:$true
}

function Init-DefSite {

New-ADReplicationSite -Name "COR"
New-ADReplicationSubnet -Name "10.10.1.0/24" -Site "COR" -Location "Lab Core"
Move-ADDirectoryServer -Identity (Get-ADDomainController).Name -Site "COR"

#MS recommends not deleting or renaming Default-First-Site
#Remove-ADReplicationSite -Identity "Default-First-Site-Name"
}