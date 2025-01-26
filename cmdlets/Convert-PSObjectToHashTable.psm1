using module ../nestedmodules/colorconsole/libs/cmdlets/New-ColorConsole.psm1

<#
.SYNOPSIS

Converts a PowerShell object (PsObject or PsCustomObject) to a HashTable object.

.DESCRIPTION

Converts a PowerShell object (PsObject or PsCustomObject) to a HashTable object.

.PARAMETER PSObject

Supported types: pscustomobject, psobject

.PARAMETER Log

Switch to enable logging

.EXAMPLE

Convert-PSObjectToHashTable -PSObject $PSObject

Convert-PSObjectToHashTable -PSObject 

.EXAMPLE

$PSObject | Convert-PSObjectToHashTable

$PSCustomObject | Convert-PSObjectToHashTable

.OUTPUTS 

HashTable
#>

function Convert-PSObjectToHashTable {
    [CmdletBinding()]
    [alias('ptcoth')]
    [OutputType([hashtable])]
    param (
        [Parameter(Mandatory = $true, valueFromPipeline = $true, Position = 0)]
        $PSObject,
        
        [Parameter(Mandatory = $false)]
        [switch]$log
    )

    process {
        $HashTable = @{}
        $logname = $global:_ptoml.misc.logname
        $psco = $global:_ptoml.misc.psco
        $pp = $global:_ptoml.misc.pp
        $Convert = $global:_ptoml.misc.Convert
        $add = $global:_ptoml.misc.add

        if ($log) {
            [console]::write("$logname converting $pp $(csole -s "≡$($PSObject.GetType().Name)≡" -c yellow) object to $pp $psco`n")
            [console]::write("$logname enumerating $psco note properties... `n")
        }
        # Supports Nested PsObjects
        try {
            foreach ($p in $PSObject.psobject.properties.where({ $_.MemberType -eq 'NoteProperty' })) {
                if($p.GetType().Name -eq 'PSCustomObject' -or $p.GetType().Name -eq 'PSObject') {
                    if ($log) {
                        [console]::write("$logname enumerating nested $($global:_ptoml.kvString.invoke($p.Name, $p.value.GetType().Name)) object...`n")
                    }
                    ConvertNestedPSObject($p)
                }else{
                    if ($log) {
                        [console]::write("$logname $add $($global:_ptoml.kvString.invoke($p.Name, $p.value.GetType().Name)) to $tn object...`n")
                    }
                    $HashTable.Add($p.Name, $p.Value)
                }
                
            }
        }
        catch [System.Exception] {
            [console]::write("$logname $Convert $pp $(csole -s "≡$($PSObject.GetType().Name)≡" -c yellow) object failed $pp $(csole -s $_.Exception.Message -c red)`n")
        }

        function ConvertNestedPSObject($PSObject){
            if($log){
                [console]::write("$logname enumerating nested $psco note properties... `n")
            }
            foreach ($p in $PSObject.psobject.properties.where({$_.MemberType -eq 'NoteProperty'})) {
                if ($p.GetType().Name -eq 'PSCustomObject' -or $p.GetType().Name -eq 'PSObject') {
                    if ($log) {
                        [console]::write("$logname nested $($p.Name) $pp $(csole -s "<$($p.GetType().Name)>" -c yellow) object...`n")
                    }
                    ConvertNestedPSObject($p)
                }else{
                    if ($log) {
                        [console]::write("$logname $add $($global:_ptoml.kvString.invoke($p.Name, $p.value.GetType().Name)) to $tn object..`n")
                    }
                    $HashTable.Add($p.Name, $p.Value)
                }
            }
        }

        return $HashTable
    }
}

$cmdlet_config = @{
    function = @('Convert-PSObjectToHashTable')
    alias    = @('ptcoth')
}

Export-ModuleMember @cmdlet_config