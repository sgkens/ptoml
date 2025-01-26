using module ../nestedmodules/colorconsole/libs/cmdlets/New-ColorConsole.psm1

<#
.SYNOPSIS
Removes a property from the TOML object.

.DESCRIPTION
This cmdlet removes a specified property from the TOML object.

.PARAMETER PropertyPath
The path of the property to be removed.

.EXAMPLE
Remove-Property -PropertyPath 'servermembers.properties.config_files'
#>

function Remove-TomlProperty {
    [CmdletBinding()]
    [Alias('ptrp')]
    [OutputType('system.object[]')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$NodePath,

        [Parameter(Mandatory = $false)]
        [switch]$Log
    )

    try {
        $logname = $global:_ptoml.misc.logname
        $tn = $global:_ptoml.misc.tn
        $pp = $global:_ptoml.misc.pp
        $remove = $global:_ptoml.misc.remove

        $global:_ptoml.instance.RemoveProperty($PropertyPath)
        $verbose ? [Console]::Write("$logname $remove $tn property $pp $(csole -s $PropertyPath -c cyan) removed from $tn") : $null
    }
    catch {
        [console]::write("$logname remove $tn property failed $pp $(csole -s $_.Exception.Message -c red)`n")
    }
}

# Export cmdlet
$cmdlet_config = @{
    function = @('Remove-TomlProperty')
    alias    = @('ptrp')
}

Export-ModuleMember @cmdlet_config
