using module ../nestedmodules/colorconsole/libs/cmdlets/New-ColorConsole.psm1

<#
.SYNOPSIS
Adds a property to the TomlTable object.

.DESCRIPTION
This cmdlet adds a new property to the TOML table. 

The value can be any type supported by TOML, including strings, arrays, hashtables, booleans, nested hashtables, etc.

.PARAMETER NodePath
The NodePath where the property should be added in the TOML structure, e.g., 'servermembers.properties.members'.

.PARAMETER PValue
The value to be assigned to the property, e.g., @{ member1=1; member2=2 }.

.PARAMETER log

Switch to enable logging

.EXAMPLE
Add-TomlProperty -NodePath 'servermembers' -PValue @{ MyColor='blue'; members=@{ member1=1; member2=2 } }

.EXAMPLE
Add-TomlProperty -NodePath 'servermembers.config_files' -PValue @('file1', 'file2')
#>

function Add-TomlProperty {
    [CmdletBinding()]
    [Alias('ptap')]
    [OutputType('[system.object[]')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$NodePath,
        
        [Parameter(Mandatory = $true)]
        $PValue,
        
        [Parameter(Mandatory = $false)]
        [switch]$log
    )

    process {
        $logname = $global:_ptoml.misc.logname
        $tn = $global:_ptoml.misc.tn
        $pp = $global:_ptoml.misc.pp
        $add = $global:_ptoml.misc.add

        try {
            $log ? [Console]::Write("$logname $add $tn property at pathNode $pp $($global:_ptoml.kvString.invoke($NodePath, $PValue.GetType().Name))`n") : $null
            #$global:_ptoml.instance.AddProperty($NodePath, $PValue)
            Add-TomlProperty -NodePath $NodePath -PValue $PValue
        }
        catch {
            [console]::write("$logname add $tn property failed $pp $(csole -s $_.Exception.Message -c red)`n")
        }
    }


}

# Export cmdlet
$cmdlet_config = @{
    function = @('Add-TomlProperty')
    alias    = @('ptap')
}

Export-ModuleMember @cmdlet_config
