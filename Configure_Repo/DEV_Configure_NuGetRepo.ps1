Register-PSRepository  -Name InternalPowerShellModules -SourceLocation  http://dsc.mikelab.local:81/nuget/MikeLabPowerShell/ -PackageManagementProvider NuGet -PublishLocation http://dsc.mikelab.local:81/nuget/MikeLabPowerShell/ -InstallationPolicy Trusted

Publish-Module -Name xTimeZone -Repository InternalPowerShellModules -NuGetApiKey Admin:Admin

Find-Module -Name xTimeZone -Repository  InternalPowerShellModules