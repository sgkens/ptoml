<#
.SYNOPSIS
Creates a new TOML file with specified content, takes a hashtable of properties, parsed as TOML and writes it to the specified file.

.DESCRIPTION
This cmdlet creates a new TOML file at the specified path and writes the provided TOML string content to it.

.PARAMETER FilePath
The path where the TOML file will be created.

.PARAMETER TomlContent
The TOML content to be written to the file.

.EXAMPLE
New-TomlFile -FilePath 'C:\path\to\newfile.toml' -TomlContent $tomlString
#>

function New-TomlFile {
    [CmdletBinding()]
    [OutputType([void])]
    [alias('ptln')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$FilePath,
        
        [Parameter(Mandatory = $false)]
        [hashtable]$HashTable,

        [Parameter(Mandatory = $false)]
        [switch]$Log
    )
    process {
        $logname = $global:_ptoml.misc.logname
        $pp = $global:_ptoml.misc.pp
        $tn = $global:_ptoml.misc.tn
        $create = $global:_ptoml.misc.create
        $parse = $global:_ptoml.misc.parse

        try {
            if ((Get-ItemProperty -Path $FilePath -ErrorAction SilentlyContinue)) { Throw "New-TomlFile - file already exists: $FilePath`n" }
            if(!$TomlContent) { 
                $Log ? [console]::write("$logname $create empty TOML file $pp $(csole -s $FilePath -c yellow)`n")  : $null
                New-Item -Path $FilePath -ItemType File
                $global:_ptoml.instance.purgeTableData()
            }else{
                $global:_ptoml.instance.purgeTableData()
                foreach ($key in $HashTable.Keys) {
                    [console]::write("$logname $add property $pp $($global:_ptoml.kvString.invoke($key, $HashTable[$key].GetType().Name)) object`n")
                    Add-TomlProperty -NodePath $key -PValue $HashTable[$key]
                }
                $Log ? [console]::write("$logname $parse $tn object to TOML string`n")  : $null
                $tomlString = $global:_ptoml.instance.ToToml()
                $Log ? [console]::write("$logname $create empty TOML file $pp $(csole -s $FilePath -c yellow)`n") : $null
                New-Item -Path $FilePath -ItemType File 
                $tomlString | Out-File -FilePath $FilePath
                $Log ? [console]::write("$logname TOML file exported $pp $(csole -s $((Get-ItemProperty -Path $FilePath).FullName) -c yellow)`n") : $null
            }
        }
        catch {
            [console]::write("$logname failed to create TOML file pp $(csole -s $_.exception.message -c red)`n")
        }
    }
}

# Export cmdlet from psm
$cmdlet_config = @{
    function = @('New-TomlFile')
    alias    = @('ptln')     
}
Export-ModuleMember @cmdlet_config


