Configuration DSCBaseConfig
{

    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -Name MSFT_xSmbShare

    Node $AllNodes.Where{$_.Role -eq "Base"}.NodeName
    {
        File SrvCust 
        # Configure folder for server customization tools
        {
            Type = "Directory"
            DestinationPath = "C:\SrvCust"
            Ensure = "Present"
        }
    }

    Node $AllNodes.Where{$_.Role -eq "DomainController"}.NodeName
    {
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
    }
}

DSCBaseConfig -ConfigurationData .\PullDSC_SingleConfig_ServerList.psd1 -OutPut "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"