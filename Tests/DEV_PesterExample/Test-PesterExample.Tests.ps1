$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Test-PesterExample" {
    It "says Hello" {
        Test-PesterExample | Should Be "Hello"
    }
}
