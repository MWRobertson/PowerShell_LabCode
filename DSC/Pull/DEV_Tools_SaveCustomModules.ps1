
function Save-DSCModuleLocally {

    param(
        [Parameter(Mandatory=$True,Position=1)][String]$ModuleName
    )

    Find-Module $ModuleName | Save-Module -Path \\mikelab.local\Shared\PSModules -Verbose -Force

}

Save-DSCModuleLocally -ModuleName xTimeZone