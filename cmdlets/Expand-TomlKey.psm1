<#

.SYNOPSIS
Expands the key value from tomltable powershell object and returns the value

.DESCRIPTION
Expands the key value from tomltable powershell object and returns the value

.PARAMETER TomlObject
The tomltable powershell object

.PARAMETER KeyName
The key name to be expanded

.OUTPUTS
The value of the key

.EXAMPLE
GetTomlProperties | Expand-TomlKey -KeyName 'KeyName'

.EXAMPLE
Get-TomlProperty -NodePath 'Path.to.property' | Expand-TomlKey -KeyName 'KeyName'
#>

function Expand-TomlKey {
    [CmdletBinding()]
    [Alias('ptek')]
    param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [Object[]]$TomlObject,

        [Parameter(Mandatory = $true)]
        [string]$KeyName
    )

    process {
        return $TomlObject.Where({ $_.Key -eq $KeyName }).Value
    }
}

$cmdlet_config = @{
    function = @('Expand-TomlKey')
    alias    = @('ptek')
}

# Export functions  
Export-ModuleMember @cmdlet_config