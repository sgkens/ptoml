using module ../nestedmodules/colorconsole/libs/cmdlets/New-ColorConsole.psm1
<#
.SYNOPSIS

Converts a PowerShell object to a TOML string

.DESCRIPTION

Converts a PowerShell object to a TOML string

.PARAMETER object

Supported types: hashtable, pscustomobject

.EXAMPLE

$object | ConvertTo-Toml


#>
function ConvertTo-Toml {
    [cmdletbinding()]
    [OutputType([string])]
    [alias('ptct')]
    param(
        [Parameter(Mandatory=$false,ValueFromPipeline=$true)]
        $object # psobject of one of the supported types
    )
    process {
        
        [string]$tomlstring = $null
        
        if ($object.GetType().Name -eq 'hashtable') {
            $tomlImport = Import-HashtableToTomlTable -HashTable $object
        }elseif($object.GetType().Name -eq 'psobject') {
            $tomlImport = Convert-PSObjectToHashTable -PSObject $object  | Import-HashtableToTomlTable
        }elseif($object.GetType().Name -eq 'pscustomobject') {
            $tomlImport = Convert-PSObjectToHashTable -PSObject $object | Import-HashtableToTomlTable  
        }else{
            [console]::write("$logname $Convert $pp $(csole -s "≡$($object.GetType().Name)≡" -c yellow) object not supported`n")
        }
        return $global:_ptoml.instance.ToToml()
    }
}

$cmdlet_config = @{
    function = @('ConvertTo-Toml')
    alias    = @('ptct')
}

Export-ModuleMember @cmdlet_config