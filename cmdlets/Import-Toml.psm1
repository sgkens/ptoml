using module ../nestedmodules/colorconsole/libs/cmdlets/New-ColorConsole.psm1

<#
.SYNOPSIS
Converts a TOML string to a C# Tomlyn.Model.TomlTable object compatible with tomlyn.

.DESCRIPTION
This cmdlet parses a TOML string and converts it into a C# Tomlyn.Model.TomlTable object compatible with tomlyn.

.PARAMETER TomlString
The TOML string to be parsed.

.EXAMPLE
Import-Toml -TomlString $tomlContent

.EXAMPLE
$psObject = Import-Toml -TomlString (Get-Content -Raw -Path 'test.toml')
Get-Content -Raw -Path 'test.toml' | Import-Toml
#>

function Import-Toml {
    [CmdletBinding()]
    [Alias('ptim')]
    [OutputType([void])]
    param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, Position = 0)]
        [string]$TomlString,

        [Parameter(Mandatory = $false)]
        [switch]$Log
    )

    process {
        $logname = $global:_ptoml.misc.logname
        $tn = $global:_ptoml.misc.tn
        $pp = $global:_ptoml.misc.pp
        $import = $global:_ptoml.misc.import

        try {
            if($TomlString -eq $null -or $TomlString -eq "") { throw "No TOML string provided."}
            
            $Log ? [console]::write("$logname $import TOML string...`n") : $null

            $global:_ptoml.instance.FromToml($TomlString)
        }
        catch {
            [console]::write("$logname failed to parse TOML string: $(csole -s $_.Exception.Message -c red)`n")
        }
    }
}

# Export cmdlet

$cmdlet_config = @{
    function = @('Import-Toml')
    alias    = @('ptim')
}

Export-ModuleMember @cmdlet_config
