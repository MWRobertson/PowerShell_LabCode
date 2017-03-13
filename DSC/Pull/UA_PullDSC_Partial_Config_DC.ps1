Configuration DSCDCConfig
{

    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -Name MSFT_xSmbShare

    node localhost{

        WindowsFeature Backup 
        {
            Ensure = "Present"
            Name = "Windows-Server-Backup"
        }

        File SPAFolder 
        # Configure an empty share with Administrators read permission for SPA to collect performance data
        {
            Type = "Directory"
            DestinationPath = "C:\SPA"
            Ensure = "Present"
        }

        xSmbShare SPAShare
        # Configure an empty share with Administrators read permission for SPA to collect performance data
        {
            Ensure = "Present" 
            Name   = "SPA"
            Path = "C:\SPA"  
            Description = "Shared required for Server Performance Analyzer"
            FullAccess = "Administrators"
            DependsOn = "[File]SPAFolder"          
        }

        Registry GarbageCollection
        # Configure auditing to track AD database whitespace
        {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics"
            ValueName = "6 Garbage Collection"
            ValueData = "1"
            ValueType = "Dword"
        }

        Registry LDAPInterfaceEvent
        # Configure LDAP auditing to track clients not using secure LDAP
        {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics"
            ValueName = "16 LDAP Interface Events"
            ValueData = "1"
            ValueType = "Dword"
        }

        Registry MaxTokenSize
        # Legacy configuration choice. Needs evaluation to determine if its still correct or necessary
        {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\Kerberos\Parameters"
            ValueName = "MaxTokenSize"
            ValueData = "65000"
            ValueType = "Dword"
        }

        Registry DFSDnsConfig
        # Configure DFS to use DNS resolution rather than NetBIOS
        {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Dfs"
            ValueName = "DFSDnsConfig"
            ValueData = "1"
            ValueType = "Dword"
        }

        Registry NSPIMaxSessions
        # Legacy configuration choice. Needs evaluation to determine if its still correct or necessary
        {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters"
            ValueName = "NSPI max sessions per user"
            ValueData = "250"
            ValueType = "Dword"
        }
    }
}

DSCDCConfig -OutPut "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"
Remove-Item "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration\DSCDCConfig.mof"
Remove-Item "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration\DSCDCConfig.mof.checksum"
Rename-Item "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration\localhost.mof" "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration\DSCDCConfig.mof"
New-DscCheckSum -Path "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration" -Force