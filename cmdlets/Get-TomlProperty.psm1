using module ../nestedmodules/colorconsole/libs/cmdlets/New-ColorConsole.psm1
<#
.SYNOPSIS
Returns the property of the TOML object, As TomlString or TomlTable

.DESCRIPTION
Returns the properties of the TOML object, As TomlString or TomlTable

This is constructed by the Tomlyn library as a System.Collections.Generic.KeyValuePair`2[[System.String],[System.Object]] from the model Tomlyn.module.TomlTable

Note While you can manipulate this object, this is not the same as the TOML object, powershell performs a deep copy of the object, 
so changes to the original TOML object will not be reflected in the TOML object returned by this cmdlet.

.PARAMETER AsTomlString
Returns the TOML string representation of the TOML object

.PARAMETER AsHashTable
Returns the HashTable representation of the TOML object

.EXAMPLE
Get-TomlProperties

.EXAMPLE
Get-TomlProperty -NodePath 'servermembers.properties.members'
#>
function Get-TomlProperty {
    [CmdletBinding()]
    [alias('ptgp')]
    [OutputType('system.object')]
    param (
        [parameter(mandatory = $false)]
        [string]$NodePath,

        [parameter(mandatory = $false)]
        [switch]$log
    )

    process {
        $logname = $global:_ptoml.misc.logname
        $tn = $global:_ptoml.misc.tn
        $pp = $global:_ptoml.misc.pp
        $get = $global:_ptoml.misc.get

        try {
            $log ? [Console]::Write("$logname $get $tn property at pathNode $pp $(csole -s $NodePath -c cyan)`n")  : $null
            return $global:_ptoml.instance.GetProperty($NodePath)
        }catch [system.exception] {
            [console]::write("$logname $get $tn property failed $pp $(csole -s $_.Exception.Message -c red)`n")
        }
    }
}

$cmdlet_config = @{
    function = @('Get-TomlProperty')
    alias    = @('ptgp')
}

# Export functions
Export-ModuleMember @cmdlet_config