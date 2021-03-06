﻿[DSCLocalConfigurationManager()]
configuration PullClientConfigNames
{
        Settings
        {
            RefreshMode          = 'Pull'
            RefreshFrequencyMins = 30 
            RebootNodeIfNeeded   = $false
            AllowModuleOverwrite = $TRUE
        }

        ConfigurationRepositoryWeb MikeLab-PullSrv
        {
            ServerURL          = 'https://dsc.mikelab.local:8080/PSDSCPullServer.svc'
            RegistrationKey    = 'b260b714-a6d9-452c-8dcb-bf021b6cff06'
            ConfigurationNames = @('DSCBaseConfig')
        }   

        ReportServerWeb MikeLab-PullSrv
        {
            ServerURL       = 'https://dsc.mikelab.local:8080/PSDSCPullServer.svc'
            RegistrationKey = 'b260b714-a6d9-452c-8dcb-bf021b6cff06'
        }

        PartialConfiguration DSCBaseConfig
        {
            Description = "DSCBaseConfig"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]MikeLab-PullSrv")
        }
}

PullClientConfigNames -OutputPath c:\DSCConfigs\TargetNodes
Remove-Item "c:\DSCConfigs\TargetNodes\MRHOMHUB02.meta.mof" -Force
Rename-Item "c:\DSCConfigs\TargetNodes\localhost.meta.mof" "c:\DSCConfigs\TargetNodes\MRHOMHUB02.meta.mof"
Set-DSCLocalConfigurationManager -ComputerName MRHOMHUB02 –Path c:\DSCConfigs\TargetNodes –Verbose