using module ../nestedmodules/colorconsole/libs/cmdlets/New-ColorConsole.psm1

<#
.SYNOPSIS
Converts a PowerShell object (Hashtable) to a TomlTable object.

.DESCRIPTION
This cmdlet converts a PowerShell object (Hashtable) into a TomlTable Object, returns a toml string.

.PARAMETER HashTable
The PowerShell object to be converted to TOML.

.OUTPUTS
The TOML string representation of the input PowerShell object.

.EXAMPLE
ConvertFrom-Hashtable -HashTable @{}

.EXAMPLE
@{prop:value; @{prop:value}} | ConvertFrom-Hashtable

.EXAMPLE
$tomlString = ConvertTo-Toml -HashTable @{ servermembers = @{ properties = @{ MyColor = 'blue' } } }
#>

function Import-HashtableToTomltable {
    [CmdletBinding()]
    [alias('ptih')]
    [OutputType([void])]
    param (
        [Parameter(Mandatory = $false, valueFromPipeline = $true)]
        [hashtable]$HashTable,

        [Parameter(Mandatory = $false)]
        [switch]$log
    )

    process {

        $logname = $global:_ptoml.misc.logname
        $tn = $global:_ptoml.misc.tn
        $pp = $global:_ptoml.misc.pp

        try {
            $log -or $global:_ptoml.verbose ? [console]::write("$logname Enumerating $pp $(csole -s $($HashTable.GetType().Name) -c yellow) object to $pp $tn`n") : $null

            # Purge Table Data
            $global:_ptoml.instance.purgeTableData()

            # Loop through key the hashtable for each key value ptoml with do the nested conversion
            foreach($h in $HashTable.GetEnumerator()){ 
                if($h.GetType().Name -eq 'PSCustomObject' -or $h.GetType().Name -eq 'PSObject'){
                    [console]::write("$logname nested $($global:_ptoml.kvString.invoke($h.Key, $h.value.GetType().Name))...`n")
                    $h = Convert-PSObjectToHashTable -PSObject $h
                }
                
                $log -or $global:_ptoml.verbose ? [console]::write("$logname add $tn $pp $($global:_ptoml.kvString.invoke($h.Key, $h.value.GetType().Name))...`n") : $null
                Add-TomlProperty -NodePath $h.Key -PValue $h.Value
            }
        }
        catch {
            [console]::write("$logname convert $pp $(csole -s $($HashTable.GetType().Name) -c yellow) object to $pp $tn failed $pp $(csole -s $_.Exception.Message -c red)`n")
        }

    }
}

# Export cmdlet
$cmdlet_config = @{
    function = @('Import-HashtableToTomltable')
    alias    = @('ptiht')
}

Export-ModuleMember @cmdlet_config
