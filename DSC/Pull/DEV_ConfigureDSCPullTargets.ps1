[DSCLocalConfigurationManager()]
configuration PullClientConfigID
{
    param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $NodeName
    )

    Node $NodeName
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
    }
}

PullClientConfigID -NodeName MRHOMADS03.mikelab.local -OutputPath c:\DSCConfigs\TargetNodes
Set-DSCLocalConfigurationManager -ComputerName MRHOMADS03.mikelab.local –Path c:\DSCConfigs\TargetNodes –Verbose