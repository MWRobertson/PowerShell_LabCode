function Init-NameAndNIC {
$VMName = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Virtual Machine\Guest\Parameters").VirtualMachineName

Set-Volume C -NewFileSystemLabel "$VMName-C" 

$VMIPInfo = Get-Content "C:\Scripts\$VMName.cfg"
$NICname = (Get-NetAdapter *).Name

New-NetIPAddress -InterfaceAlias $NICname -IPAddress $VMIPInfo[0] -PrefixLength $VMIPInfo[1] -DefaultGateway $VMIPInfo[2]
Set-DNSClientServerAddress -InterfaceAlias $NICname -ServerAddresses $VMIPInfo[3]

Rename-Computer -NewName $VMName -Restart
}

function Init-JoinDomain {
    param(
        [Parameter(Mandatory=$True,Position=1)][String]$VMDomain
        )
Add-Computer -DomainName $VMDomain -Verbose
Restart-Computer
}