Configuration DSCBaseConfig
{

    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -Name MSFT_xSmbShare
    Import-DscResource -Name xTimeZone

    node localhost{

        WindowsFeature DSCService
        {
            Name = "DSC-Service"
            Ensure = "Present"
        }

        File SrvCust 
        # Configure folder for server customization tools
        {
            Type = "Directory"
            DestinationPath = "C:\SrvCust"
            Ensure = "Present"
        }

        File Scripts
        # Configure folder for common scripts
        {
            Type = "Directory"
            DestinationPath = "C:\SrvCust\Scripts"
            Ensure = "Present"
            DependsOn = "[File]SrvCust"
        }

        File CTemp
        # Configure TEMP folder
        {
            Type = "Directory"
            DestinationPath = "C:\TEMP"
            Ensure = "Present"
        }

        Environment TEMP
        # Configure TEMP environment variable to point to C:\TEMP
        {
            Ensure = "Present"
            Name = "TEMP"
            Value = "C:\TEMP"
            DependsOn = "[File]CTemp"
        }

        Environment TMP
        # Configure TMP environment variable to point to C:\TEMP
        {
            Ensure = "Present"
            Name = "TMP"
            Value = "C:\TEMP"
            DependsOn = "[File]CTemp"
        }

        Environment PATH
        # Append scripts folder to PATH
        {
            Ensure = "Present"
            Name = "PATH"
            Path = $TRUE
            Value = "C:\SrvCust\Scripts"
            DependsOn = "[File]Scripts"
        }

        xTimeZone TZ
        {
            IsSingleInstance = "Yes"
            TimeZone = "Eastern Standard Time"
        }
    }
}

DSCBaseConfig -OutPut "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"
Remove-Item "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration\DSCBaseConfig.mof"
Remove-Item "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration\DSCBaseConfig.mof.checksum"
Rename-Item "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration\localhost.mof" "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration\DSCBaseConfig.mof"
New-DscCheckSum -Path "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration" -Force