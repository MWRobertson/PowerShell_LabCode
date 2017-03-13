configuration Sample_xDscPullServer
{ 
    param  
    ( 
            [string[]]$NodeName = 'localhost', 

            [ValidateNotNullOrEmpty()] 
            [string] $certificateThumbPrint,

            [Parameter(Mandatory)]
            [ValidateNotNullOrEmpty()]
            [string] $RegistrationKey 
     ) 


     Import-DSCResource -ModuleName xPSDesiredStateConfiguration
     Import-DSCResource –ModuleName PSDesiredStateConfiguration

     Node $NodeName 
     { 
         WindowsFeature DSCServiceFeature 
         { 
             Ensure = 'Present'
             Name   = 'DSC-Service'             
         } 

         xDscWebService PSDSCPullServer 
         { 
             Ensure                   = 'Present' 
             EndpointName             = 'PSDSCPullServer' 
             Port                     = 8080 
             PhysicalPath             = "$env:SystemDrive\inetpub\PSDSCPullServer" 
             CertificateThumbPrint    = $certificateThumbPrint          
             ModulePath               = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules" 
             ConfigurationPath        = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration" 
             State                    = 'Started'
             DependsOn                = '[WindowsFeature]DSCServiceFeature'     
             UseSecurityBestPractices = $false
         } 

        File RegistrationKeyFile
        {
            Ensure          = 'Present'
            Type            = 'File'
            DestinationPath = "$env:ProgramFiles\WindowsPowerShell\DscService\RegistrationKeys.txt"
            Contents        = $RegistrationKey
        }
    }
}

Sample_xDSCPullServer -certificateThumbprint 'DDDD417BAA7A9D2D284F53F7B9285F5628B8289A' -RegistrationKey 'b260b714-a6d9-452c-8dcb-bf021b6cff06' -OutputPath c:\DSCConfigs\PullServer
Start-DscConfiguration -Path c:\DSCConfigs\PullServer -Wait -Verbose -Force