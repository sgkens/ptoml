using module ../nestedmodules/colorconsole/libs/cmdlets/New-ColorConsole.psm1
<#
.SYNOPSIS
Returns the properties of the TOML object, As TomlString, HashTable or TomlTable

.DESCRIPTION
Returns the properties of the TOML object, As TomlString, HashTable or TomlTable

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
Get-TomlProperties -NodePath 'servermembers.properties.members'

.EXAMPLE
Get-TomlProperties -AsTomlString
#>
function Get-TomlProperties {
    [CmdletBinding()]
    [alias('ptps')]
    param (
        [parameter(mandatory = $false)]
        [switch]$AsTomlString,
        [parameter(mandatory = $false)]
        [switch]$AsHashTable,
        [parameter(mandatory = $false)]
        [switch]$AsJson
    )

    process {
        $logname = $global:_ptoml.misc.logname
        $tn = $global:_ptoml.misc.tn
        $pp = $global:_ptoml.misc.pp
        $get = $global:_ptoml.misc.get
        
        try {
            if($AsTomlString){
                $log ? [console]::write("$logname $get $tn string representation of $tn object`n") : $null
                $log ? [Console]::Write("$(csole -s '.toml' -c gray) $(csole -s '◢' -c magenta)`n`n") : $null
                $data = $global:_ptoml.instance.ToToml(); 
            }elseif($AsHashTable){
                $log ? [console]::write("$logname $get $tn hashtable representation of $tn object`n") : $null
                $data = $global:_ptoml.instance.GetHashTable();
            }elseif($AsJson){
                $log ? [console]::write("$logname $get $tn json representation of $tn object`n") : $null
                $log ? [Console]::Write("$(csole -s '.json' -c gray) $(csole -s '◢' -c magenta)`n`n") : $null
                $data = $global:_ptoml.instance.GetHashTable() | ConvertTo-Json -Depth 20
            }else{
                $log ? [console]::write("$logname $get $tn object`n") : $null
                $data = $global:_ptoml.instance.ToTomlTable();
            }
        } catch [system.exception] {
            [console]::write("$logname $get $tn properties failed $pp $(csole -s $_.Exception.Message -c red)`n")
        }
        return $data
    }
}

$cmdlet_config = @{
    function = @('Get-TomlProperties')
    alias    = @('ptps')
}

# Export functions
Export-ModuleMember @cmdlet_config