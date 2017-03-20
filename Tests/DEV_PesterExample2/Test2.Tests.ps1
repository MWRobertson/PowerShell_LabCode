$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Test2" {
    It "returns Var1" {
        $Var1 | Should Be "This is Var1"
    }
    It "returns Var2"{
        $Var2 | Should Be "This is Var2"
    }
    It "returns Var3" {
        $Var3 | Should Be "This is Var4"
    }
}
