Configuration BaseBuildConfig {

    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'
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

Install-PackageProvider NuGet -Force

Install-Module -Name xSmbShare -Force -Verbose
Install-Module -Name xTimeZone -Force -Verbose

BaseBuildConfig -Output "C:\DSCConfigs"
Start-DscConfiguration -Wait -Verbose -ComputerName localhost -Path C:\DSCConfigs