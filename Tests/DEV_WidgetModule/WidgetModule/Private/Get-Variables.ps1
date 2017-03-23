$ModulePathRoot = (Split-Path -Path "$PSScriptRoot" -Parent)
$ModulePathBin = (Split-Path -Path "$PSScriptRoot" -Parent) + "\bin"
$ModulePathLib = (Split-Path -Path "$PSScriptRoot" -Parent) + "\lib"
$ModulePathPrivate = (Split-Path -Path "$PSScriptRoot" -Parent) + "\Private"
$ModulePathPublic = (Split-Path -Path "$PSScriptRoot" -Parent) + "\Public"

$Var1 = "This is Var1"
$Var2 = "This is Var2"
$Var3 = 42
$Var4 = "$ModulePathBin\Widget"

$WidgetPath = "C:\WidgetTest"