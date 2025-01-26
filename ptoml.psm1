using module nestedmodules/colorconsole/libs/cmdlets/New-ColorConsole.psm1
using module cmdlets/New-TomlFile.psm1
using module cmdlets/Import-Toml.psm1
using module cmdlets/Add-TomlProperty.psm1
using module cmdlets/Get-TomlProperties.psm1
using module cmdlets/Get-TomlProperty.psm1
using module cmdlets/Expand-TomlKey.psm1
using module cmdlets/Remove-TomlProperty.psm1
using module cmdlets/Set-TomlProperty.psm1
using module cmdlets/Import-HashtableToTomltable.psm1
using module cmdlets/Convert-PSObjectToHashTable.psm1
using module cmdlets/ConvertTo-Toml.psm1
# using namespace tomlyn
# using namespace Ptoml


# Load types
add-Type -Path '.\lib\ptoml\tomlyn.dll'
add-Type -Path '.\lib\ptoml\ptoml.dll'

$ptoml_instance = new-object -typename 'ptoml.tomlParser'

# Setup global variable
$global:_ptoml = @{
    rootpath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
    instance = $ptoml_instance
    kvString = {
        param($keyName, $valueType)
        return "{ Key-($(csole -s $keyName -c magenta)) : ValueType-($(csole -s $valueType -c yellow)) }"
    }
    misc = @{
        'logname' = "$(csole -s 'ptoml' -c gray)$(csole -s ' ⁛ ' -c darkcyan)"
        'tn'      = "$(csole -s '<tomltable>' -c gray)" # TableNotation
        'ht'      = "$(csole -s '<hashtable>' -c gray)"
        'psco'    = "$(csole -s '<PSCustomObject>' -c blue)"
        'pso'     = "$(csole -s '<PSObject>' -c blue)"
        'pp'      = "$(csole -s '⇾' -c darkcyan)"
        'remove'  = "$(csole -s '■-' -c gray)$(csole -s 'remove' -c red)"
        'Set'     = "$(csole -s '■-' -c gray)$(csole -s 'set' -c yellow)"
        'add'     = "$(csole -s '■-' -c gray)$(csole -s 'add' -c green)"
        'create'  = "$(csole -s '■-' -c gray)$(csole -s 'create' -c green)"
        'purge'   = "$(csole -s '■-' -c gray)$(csole -s 'purge' -c darkcyan)"
        'import'  = "$(csole -s '■-' -c gray)$(csole -s 'import' -c magenta)"
        'get'     = "$(csole -s '■-' -c gray)$(csole -s 'get' -c gray)"
        'parse'   = "$(csole -s '■-' -c gray)$(csole -s 'parse' -c blue)"
        'expand'  = "$(csole -s '■-' -c gray)$(csole -s 'expand' -c blue)"
    }
}

# Export functions
$module_config = @{
    function = @(
        'New-TomlFile', 
        'Import-Toml', 
        'Add-TomlProperty', 
        'Get-TomlProperties',
        'Get-TomlProperty', 
        'Set-TomlProperty',
        'Expand-TomlKey',
        'Remove-TomlProperty', 
        'Import-HashtableToTomltable',
        'Convert-PSObjectToHashTable',
        'ConvertTo-Toml'
        )
    alias = @(
        'ptnf', 
        'ptim', 
        'ptap', 
        'ptps',
        'ptgp', 
        'ptrp',
        'ptek', 
        'ptsp',
        'ptiht',
        'ptcoth'
        'ptct'
        )
}

Export-ModuleMember @module_config