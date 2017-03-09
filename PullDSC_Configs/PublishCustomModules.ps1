$moduleList = @(
    "xComputerManagement",
    "xExchange",
    "xHyper-V",
    "xNetworking",
    "xPendingReboot",
    "xPSDesiredStateConfiguration",
    "xRemoteDesktopAdmin",
    "xSmbShare",
    "xTimeZone",
    "xWindowsUpdate"
    ) 

Publish-DSCModuleAndMof -Source \\mikelab.local\Shared\PSModules -ModuleNameList $moduleList 