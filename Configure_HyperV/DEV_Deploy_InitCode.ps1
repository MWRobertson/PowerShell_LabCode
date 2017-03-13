function Deploy-VMInit {
    param(
        [Parameter(Mandatory=$true,Position=1)][String]$VMName,
        [Parameter(Mandatory=$true,Position=2)][String]$VMIPAddress,
        [Parameter(Mandatory=$false,Position=3)][Int]$VMIPSubmask = 24,
        [Parameter(Mandatory=$false,Position=4)][String]$VMIPGateway = "10.10.1.1",
        [Parameter(Mandatory=$false,Position=5)][String]$VMIPDNS = "10.10.1.100"
    )

$CodePath = "C:\MyCode\PowerShell Dev"
$LocalPath = "C:\Scripts"

$VMIPInfo = (
        $VMIPAddress,
        $VMIPSubmask,
        $VMIPGateway,
        $VMIPDNS
        ) | Out-File "$CodePath\$VMName.cfg"

$ScriptList = (
    "VMInit.ps1",
    "DomInit.ps1",
    "DeployNewDC.ps1",
    "$VMName.cfg"
    )

Enable-VMIntegrationService -Name Guest* -VMName $VMName -Passthru

Foreach ($InitScript in $ScriptList){
    Copy-VMFile $VMName -SourcePath "$CodePath\$InitScript" -DestinationPath "$LocalPath\$InitScript" -CreateFullPath -FileSource Host
}

Remove-Item "$VMName.cfg"

}