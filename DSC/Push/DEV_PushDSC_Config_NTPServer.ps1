Configuration Config-NTPServer {

    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    node localhost{

        Registry SetNTPServer
        # Change server type to NTP
        {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Parameters"
            ValueName = "Type"
            ValueData = "NTP"
            ValueType = "String"
        }

        Registry SetNTPAnnounceFlags
        # Announce as NTP server
        {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config"
            ValueName = "AnnounceFlags"
            ValueData = "5"
            ValueType = "Dword"
        }

        Registry EnableNTPServer
        # Enable NTP server
        {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders"
            ValueName = "NtpServer"
            ValueData = "1"
            ValueType = "Dword"
        }

        Registry NTPPeerList
        # Define the list of external NTP servers to sync with
        {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Parameters"
            ValueName = "NtpServer"
            ValueData = "0.pool.ntp.org,0x1 1.pool.ntp.org,0x1 2.pool.ntp.org,0x1 3.pool.ntp.org,0x1"
            ValueType = "String"
        }

        Registry MaxPosPhaseCorrection
        # Enable maximum positive phase correction to 15 minutes
        {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config"
            ValueName = "MaxPosPhaseCorrection"
            ValueData = "900"
            ValueType = "Dword"
        }

        Registry MaxNegPhaseCorrection
        # Enable maximum negative phase correction to 15 minutes
        {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config"
            ValueName = "MaxNegPhaseCorrection"
            ValueData = "900"
            ValueType = "Dword"
        }
    }
}

Config-NTPServer -OutPut "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"
Start-DscConfiguration -Wait -Verbose -ComputerName localhost -Path "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"

Start-Sleep -Seconds 10

Restart-Service -Name W32Time -Verbose -Force