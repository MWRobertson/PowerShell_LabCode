#region Initialization
# Source the files from which we'll pull our functions
. \DeployVMs.ps1
. \DeployInitCode.ps1
#endregion

#region Step 1 - Build New VMS
#Highlight the following code block and press F8
Deploy-NewVM MRLABDC01 2k12 Core
Deploy-NewVM MRLABIT01 2k12 GUI

break
#endregion
#region Step 2 - Push code to new VMs
#Wait until VMs are completely built. 
#Highlight the following code block and press F8
Deploy-VMInit MRLABDC01 10.10.1.100
Deploy-VMInit MRLABIT01 10.10.1.121

break
#endregion
#region Step 3 - Rename VMs and configure NICs
#Connect the console of each VM 
#Run the following command locally on each VM
#  . C:\Scripts\VMInit.ps1; Init-NameAndNIC

break
#endregion
#region Step 4 - Build domain
#Wait until DC finishes rebooting
#Run the following command locally on the first DC
# . C:\Scripts\DomInit.ps1; Init-Domain

break
#endregion
#region Step 5 - Initial domain config
#Wait until DC finishes rebooting
#Run the following command locally on the first DC
# . C:\Scripts\DomInit.ps1; Init-DefSite

break
#endregion
#region Step 6 - Join servers to domain
#Connect the console of each remaining VM 
#Run the following command locally on each
#  . C:\Scripts\VMInit.ps1; Init-JoinDomain mikelab.local

break
#endregion