using module ../nestedmodules/colorconsole/libs/cmdlets/New-ColorConsole.psm1

<#
.SYNOPSIS
Updates an existing property in the TOML object.

.DESCRIPTION
This cmdlet updates an existing property in the TOML table with a new value.

.PARAMETER PropertyPath
The path of the property to be updated.

.PARAMETER PValue
The new value for the property.

.PARAMETER Log

Switch to enable logging

.EXAMPLE
Update-Property -PropertyPath 'servermembers.properties.members' -Value @{ member1 = 'NewValue'; member2 = 'NewValue' }
#>

function Set-TomlProperty {
    [CmdletBinding()]
    [Alias('ptsp')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$NodePath,
        
        [Parameter(Mandatory = $true)]
        $PValue,

        [Parameter(Mandatory = $false)]
        [switch]$Log
    )
    
    process {
        try {
            $logname = $global:_ptoml.misc.logname
            $tn = $global:_ptoml.misc.tn
            $pp = $global:_ptoml.misc.pp

            $global:_ptoml.instance.SetProperty($NodePath, $PValue)
            $Log ? [Console]::Write("$logname $update $tn property at pathNode $pp $(csole -s $NodePath -c cyan) $pp $($global:_ptoml.kvString.invoke($NodePath, $PValue.GetType().Name))`n") : $null
        }
        catch {
            [console]::write("$logname update $tn property failed $pp $(csole -s $_.Exception.Message -c red)`n")
        }   
    } 
}

$cmdlet_config = @{
    function = @('Set-TomlProperty')
    alias    = @('ptsp')
}

Export-ModuleMember @cmdlet_config