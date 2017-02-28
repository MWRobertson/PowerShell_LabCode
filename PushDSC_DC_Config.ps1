Install-Module -Name xSmbShare -Force -Verbose

Configuration DCConfig {

    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -Name MSFT_xSmbShare

    node localhost{

        WindowsFeature DSCService
        {
            Name = "DSC-Service"
            Ensure = "Present"
        }

        File SPAFolder {
            Type = "Directory"
            DestinationPath = "C:\SPA"
            Ensure = "Present"
        }

        xSmbShare SPAShare
        {
            Ensure = "Present" 
            Name   = "SPA"
            Path = "C:\SPA"  
            Description = "Shared required for Server Performance Analyzer"
            FullAccess = "Administrators"
            DependsOn = "[File]SPAFolder"          
        }
    }
}

DCConfig -Output ".\DSCConfigs"
Start-DscConfiguration -Wait -Verbose -ComputerName localhost -Path C:\DSCConfigs