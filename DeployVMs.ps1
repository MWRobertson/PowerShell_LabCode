
function Deploy-NewVM {
    param(
    [Parameter(Mandatory=$True,Position=1)][String]$VMName,
    [Parameter(Mandatory=$True,Position=2)][ValidateSet("2k8","2k12","2k16","CentOS")][String]$OSChoice,
    [Parameter(Mandatory=$False,Position=3)][ValidateSet("GUI","Core")][String]$OSCore,
    [Parameter(Mandatory=$False)][String]$VMvCPU = "1",
    [Parameter(Mandatory=$False)][Int64]$VMvMem = 1GB,
    [Parameter(Mandatory=$False)][UInt64]$VMvHD1 = 30GB
    )

#region Static variables
$VMPath = "C:\Virtual Machines\"

# Location of OS install media
$ISORoot = "C:\ISOs\"
$ISO2k8 = "SW_DVD5_Windows_Svr_DC_EE_SE_Web_2008_R2_64Bit_English_w_SP1_MLF_X17-22580.ISO"
$ISO2k12 = "SW_DVD9_Windows_Svr_Std_and_DataCtr_2012_R2_64Bit_English_-3_MLF_X19-53588.ISO"
$ISO2k16 = "10586.0.151029-1700.TH2_RELEASE_SERVER_OEMRET_X64FRE_EN-US.ISO"
$ISOCentOS = "CentOS-7-x86_64-Minimal-1503-01.iso"

# Location of virtual floppy disks containing OS unattended answer file
$VFDRoot = "C:\ISOs\VFDs"
$VFD2k8Std = "W2K8STD.vfd"
$VFD2k12Std = "W2K12STD.vfd"
$VFD2k12StdCore = "W2K12STDCore.vfd"
$VFD2k16Std = "W2K16STD.vfd"
$VFD2k16StdCore = "W2K16STDCore.vfd"
$GenericOS = "GenericOS.vfd"

$VMNetwork = "VMPrivate"
#endregion
#region OS choice logic
switch ($OSChoice)
    {
    "2k8" {$ISOPath = "$ISORoot\$ISO2k8"
           $VFDPath = "$VFDRoot\$VFD2k8Std"
          }
    "2k12" {$ISOPath = "$ISORoot\$ISO2k12"
            switch ($OSCore)
            {
            "GUI" {$VFDPath = "$VFDRoot\$VFD2k12Std"}
            "CORE" {$VFDPath = "$VFDRoot\$VFD2k12StdCore"}
            default {$VFDPath = "$VFDRoot\$VFD2k12Std"}
            }
           }
    "2k16" {$ISOPath = "$ISORoot\$ISO2k16"
            switch ($OSCore)
            {
            "GUI" {$VFDPath = "$VFDRoot\$VFD2k16Std"}
            "CORE" {$VFDPath = "$VFDRoot\$VFD2k16StdCore"}
            default {$VFDPath = "$VFDRoot\$VFD2k16Std"}
            }
           }
    "CentOS" {$ISOPath = "$ISORoot\$ISOCentOS"
              $VFDPath = "$VFDRoot\$GenericOS"
             }
    default {$ISOPath = "$ISORoot\$ISO2k12"
             $VFDPath = "$VFDRoot\$GenericOS"
            }
    }
#endregion

# Create the VM and a vDisk for the system partition
New-VM -Name $VMName -Path $VMPath -MemoryStartupBytes $VMvMem
New-VHD -Path "$VMPath\$VMName\Virtual Hard Disks\$VMName-C.vhdx" -SizeBytes $VMvHD1 -Dynamic

# Attach the hard disk, configure CPU, configure NIC, and attach the DVD drive containing install media
Add-VMHardDiskDrive -VMName $VMName -Path "$VMPath\$VMName\Virtual Hard Disks\$VMName-C.vhdx"
Set-VMProcessor -VMName $VMName -Count $VMvCPU
Get-VMNetworkAdapter -VMName $VMName | Connect-VMNetworkAdapter -SwitchName $VMNetwork
Set-VMDvdDrive -VMName $VMName -ControllerNumber 1 -Path "$ISOPath"

# Attach the floppy disk containing the unattended answer file for OS installation. 
# Make sure the VM is granted rights to mount and access the disk
Set-VMFloppyDiskDrive -VMName $VMName -Path "$VFDPath"
$VMGuid = (Get-VM $VMName).Id
icacls $VFDPath /grant "NT VIRTUAL MACHINE\$VMGuid"":(F)"

# Power up the VM
# Windows OS installation should launch automatically
# CentOS installation will still need to be attended
Start-VM -Name $VMName

}
