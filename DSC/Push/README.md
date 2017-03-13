# DSC Push Configs

These are self-contained scripts intended to be run locally on a server to define an initial DSC configuration. They will be adapted to run remotely in a later version. Right now they're just being used for proof of concept testing in the lab. 

### DEV_PushDSC_Config_Prereqs.ps1
Prereq script to install necessary modules from the gallery if they're not available locally

### DEV_PushDSC_Config_Base.ps1
A push configuration for base builds

### DEV_PushDSC_Config_DC.ps1
A push configuration for domain controllers