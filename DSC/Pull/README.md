# DSC Pull Configuration Tools
Scripts used to create a DSC pull server, build configurations, and deploy to clients. 

### DEV_ConfigureDSCPartialPullTargets.ps1
Sandbox partial configuration script. Used as a template for new configurations which will be saved as production scripts.

### DEV_ConfigureDSCPullTargets.ps1
Sandbox full configuration script. Used as a template if partial configurations will not be used. 

### DEV_Tools_PublishCustomModules.ps1
Takes a list of modules and builds the ZIP and checksum files to load onto a DSC pull server

### DEV_Tools_SaveCustomModules.ps1
Retrieves a module from the internet and saves it locally

### UA_ConfigureDSCPullServer.ps1
Install a DSC pull server

### UA_PullDSC_Partial_Config_Base.ps1
Compile the partial configuration for base server builds

### UA_PullDSC_Partial_Config_DC.ps1
Compile the partial configuration for domain controllers

### UA_PullDSC_Deploy_Config_Base.ps1
Compile the LCM MOF for base servers and deploy

### UA_PullDSC_Deploy_Config_DC.ps1
Compile the LCM MOF for domain controllers and deploy

### DEV_PullDSC_SingleConfig.ps1
Sandbox single configuration

### DEV_PullDSC_SingleConfig_ServerList.psd1
Node data associated with DEV_PullDSC_SingleConfig.ps1