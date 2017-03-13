
function Deploy-NewDC {

    param(
    [Parameter(Mandatory=$True,Position=1)][String]$DCtoPromo
    )

Install-WindowsFeature -Name AD-Domain-Services -ComputerName $DCtoPromo -IncludeManagementTools

Invoke-Command -ComputerName $DCtoPromo -ScriptBlock {
    Import-Module ADDSDeployment
    Install-ADDSDomainController `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainName "mikelab.local" `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -NoGlobalCatalog:$false `
    -SiteName 'COR' `
    -NoRebootOnCompletion:$true `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Credential (Get-Credential)`
    -Force:$true
}

Restart-Computer $DCtoPromo -Wait -For PowerShell -Force -Confirm:$false

}
