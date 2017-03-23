function New-Widget {
    $Var5 = Add-Widget
    "Var5 is $Var5"
    $Var6 = "$ModulePathBin\Widget"
    "Bin directory: $Var6"

    Start-DscConfiguration -Wait -Verbose -ComputerName localhost -Path "$ModulePathLib\WidgetInit"
}