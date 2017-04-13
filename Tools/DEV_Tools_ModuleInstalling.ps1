$MyModulePath = "\\mikelab.local\Shared\PSModules"

function Import-MyModule
{
    [CmdletBinding(SupportsShouldProcess)]

    param(
        [Parameter(Mandatory=$TRUE)][String]$ModuleName,
        [Parameter()][String]$Version
    )

    try {
        Write-Verbose "Checking for module $ModuleName on $MyModulePath"
        $TestModule = Get-ChildItem -Path $MyModulePath -Directory -Filter "$ModuleName" -ErrorAction Stop
    }
        catch [System.ArgumentException]{
            Write-Verbose "Module name $ModuleName may contain illegal characters. Please retry." -Verbose
        }
        catch [System.Management.Automation.ItemNotFoundException]{
            Write-Verbose "Module path $MyModulePath not found. Please verify path." -Verbose
        }
        catch {
            Write-Verbose "Unspecified error. Unable to retrieve module information." -Verbose
        }

    if ($TestModule -eq $NULL)
    {
        Write-Host "Module name $ModuleName not found. Try using Find-MyModule to search for available modules." -ForegroundColor Yellow
    }
    else {
        Write-Verbose "$ModuleName located on $MyModulePath"
        Write-Verbose "Importing module $ModuleName"
        Import-Module "$MyModulePath\$TestModule" 
        Write-Verbose "Import of $ModuleName complete"
    }
}

function Install-MyModule
{
    [CmdletBinding(SupportsShouldProcess)]

    param(
        [Parameter(Mandatory=$TRUE)][String]$ModuleName,
        [Parameter()][String]$Version
    )

    try {
        Write-Verbose "Checking for module $ModuleName on $MyModulePath"
        $TestModule = Get-ChildItem -Path $MyModulePath -Directory -Filter "$ModuleName" -ErrorAction Stop
    }
        catch [System.ArgumentException]{
            Write-Verbose "Module name $ModuleName may contain illegal characters. Please retry." -Verbose
        }
        catch [System.Management.Automation.ItemNotFoundException]{
            Write-Verbose "Module path $MyModulePath not found. Please verify path." -Verbose
        }
        catch {
            Write-Verbose "Unspecified error. Unable to retrieve module information." -Verbose
        }

    if ($TestModule -eq $NULL)
    {
        Write-Host "Module name $ModuleName not found. Try using Find-MyModule to search for available modules." -ForegroundColor Yellow
    }
    else {
        Write-Verbose "$ModuleName located on $MyModulePath"
        Write-Verbose "Checking to see if $ModuleName is already installed locally"
        if (Test-Path -Path "$env:PROGRAMFILES\PowerShell\Modules\$ModuleName"){
            if ($PSCmdlet.ShouldContinue("A version of $ModuleName is already installed. Overwrite it?","Existing Module")){
                Write-Verbose "Forcing installation of module $ModuleName"
                Copy-Item -Path "$MyModulePath\$TestModule" -Destination "$env:PROGRAMFILES\PowerShell\Modules" -Force
                Write-Verbose "Installation of $ModuleName complete"
            }
        }
        else {
                Write-Verbose "$ModuleName is not installed locally"
                Write-Verbose "Installing module $ModuleName"
                Copy-Item -Path "$MyModulePath\$TestModule" -Destination "$env:PROGRAMFILES\PowerShell\Modules" -Force
                Write-Verbose "Installation of $ModuleName complete"
            }
    }
}

function Find-MyModule
{
    [CmdletBinding()]

    param(
        [Parameter(Mandatory=$TRUE)][String]$ModuleName
    )

    try {
        $TestModule = Get-ChildItem -Path $MyModulePath -Directory -Filter "*$ModuleName*" -ErrorAction Stop
    }
        catch [System.ArgumentException]{
            Write-Verbose "Module name $ModuleName may contain illegal characters. Please retry." -Verbose
        }
        catch [System.Management.Automation.ItemNotFoundException]{
            Write-Verbose "Module path $MyModulePath not found. Please verify path." -Verbose
        }
        catch {
            Write-Verbose "Unspecified error. Unable to retrieve module information." -Verbose
        }

    if ($TestModule -eq $NULL)
    {
        Write-Host "Module name $ModuleName not found" -ForegroundColor Yellow
    }
    else {
        $TestModule | Select-Object -Property Name, LastWriteTime | ft
    }
}

