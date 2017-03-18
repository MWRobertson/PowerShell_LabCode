function New-AutoModuleManifest
{
    param(
        [Parameter(Mandatory=$TRUE,Position=1)][String]$ModulePath,
        [Parameter][String]$Author = "Mike Robertson",
        [Parameter][String]$Company = "MikeLab"
    )

    New-ModuleManifest -Path $ModulePath -Author $Author -CompanyName $Company
}