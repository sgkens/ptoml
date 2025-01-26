# `P`-toml

<!--license-->
<a href="https://github.com/sgkens/ptoml/blob/main/LICENSE">
<img src="https://img.shields.io/badge/license-mit-blue?style=for-the-badge&logo=unlicense&label=License&logoColor=rgba(70%2C130%2C180%2C1)&labelColor=rgba(245%2C245%2C245%2C1)&color=rgba(255%2C245%2C238%2C1)"></a><!--Code-Factor-->     
<a href="https://www.codefactor.io/repository/github/sgkens/ptoml">
<img src="https://img.shields.io/codefactor/grade/github/sgkens/ptoml?style=for-the-badge&logo=codefactor&label=codefactor&logoColor=70%2C130%2C180%2C1&labelColor=rgba(245%2C245%2C245%2C1)&color=rgba(255%2C245%2C238%2C1)"></a><!--coverage-->
<a href="https://coveralls.io/github/sgkens/ptoml">
<img src="https://img.shields.io/coverallsCoverage/github/sgkens/ptoml?style=for-the-badge&logo=coveralls&label=coveralls&logoColor=rgba(70%2C130%2C180%2C1)&labelColor=rgba(245%2C245%2C245%2C1)&color=rgba(255%2C245%2C238%2C1)"></a>  


Simple *Toml Parser* for PowerShell built using the [**tomlyn**](https://github.com/xoofx/Tomlyn) Library.

Supports:  
✅-<kbd>Windows|linix</kbd> PowerShell(**pwsh**) `7.x` 
❌-Powershell(`powershell`) `5.x`

## 🔰 Features

`💧` **CRUD** Operations, cmdlets support `.` notation for nested `TomlTables`:
   - ***`New-TomlFile`*** [🔻](#🔅-New-TomlFile)
   - ***`Add-TomlProperty`*** [🔻](#🔅-Add-TomlProperty)
   - ***`Remove-TomlProperty`*** [🔻](#🔅-Remove-TomlProperty)
   - ***`Get-TomlProperty`*** [🔻](#🔅-Get-TomlProperty)
   - ***`Get-TomlProperties`*** [🔻](#🔅-Get-TomlProperties)
   - ***`Set-TomlProperty`*** [🔻](#🔅-Set-TomlProperty)
   - ***`Expand-TomlKey`*** [🔻](#🔅-Expand-TomlKey)

`💧` **Parse** or **Export** between the following formats:
Supported nested `TomlTables` are `inline-tables` in toml, ***ptoml*** treats them as `hashtables` in PowerShell, `PSCustomObject` are converted to `hashtables` using `Convert-PSObjectToHashTable` cmdlet.
   - *`Toml`* to *`TomlTable`* using [***`Import-Toml`***](#🔅-Import-Toml)🔻
   - *`JSON`* to *`TomlTable`* using [***`ConvertTo-Toml`***](#🔅-ConvertTo-Toml)🔻
   - *`Hashtable`* to *`TomlTable`* using [***`Import-HashTableToTomlTable`***](#🔅-ConvertFrom-HashTable)🔻
   - *`PSObject`* to *`TomlTable`* using [***`Convert-PSObjectToHashTable`***](#🔅-Convert-PSObjectToHashTable)🔻 and [***`Import-HashTableToTomlTable`***](#🔅-ConvertFrom-HashTable)🔻 to convert `PSObject` to `Hashtable` and then `Hashtable` to `TomlTable`
   - *`PSCustomObject`* to *`TomlTable`* using [***`Convert-PSObjectToHashTable`***](#🔅-Convert-PSObjectToHashTable)🔻 and [***`Import-HashTableToTomlTable`***](#🔅-ConvertFrom-HashTable)🔻 to convert `PSCustomObject` to `Hashtable` and then `Hashtable` to `TomlTable`
   - `TomlTable` to *`Toml`* using [***`Get-TomlProperties`***](#🔅-Get-TomlProperties)🔻
   - `TomlTable` to *`JSON`* using [***`Get-TomlProperties`***](#🔅-Get-TomlProperties)🔻
   - `TomlTable` to *`Hashtable`* using [***`Get-TomlProperties`***](#🔅-Get-TomlProperties)🔻

`❓` Convert Toml Tables to PowerShell Hashtables including nested tables

####  Miscellaneous Features:
`💧` **PSObject** to **Hashtable** using `Convert-PSObjectToHashTable` cmdlet.
`💧` **JSON** to **Hashtable** using `Convert-PSObjectToHashTable` cmdlet.

## 🔰 Installing Module

#### Package Repositories
PSGallery, Chocolatey or Gitlab Packages see: 🥽 **Releases** for Instructions on how to install from from one of the following package sources.

#### Clone and build module
1. 📥 Cone Repository.
    ```bash 
    # clone the repository
    git clone https://gitlab.com/phallems/ptoml.git
    
    # build the module
    # requires powershell 7.x
    # requires modules:
    #   - psscriptanalyzer
    #   - pester
    #   - csverify
    #   - psmpacker
    #   - nupsforge
    # Run the build script
    .\devops\local\build.ps1
    # outputs
    # .\dist\ptoml
    # .\dist\psgal\ptoml.zip
    # .\dist\choco\ptoml.nupkg
    # .\dist\nuget\ptoml.nupkg
    # before rebuilding the module, run the clean script
    .\devops\local\run-cleanup.ps1

    # build config file for module
    .\devops\build-config.ps1
    
    Import-Module -Name .\dist\ptoml
    ```



## 🔰 Aliases for Cmdlets
|🔹═Cmdlet|⚡═Alias|
|-|-|
|`🔅` [**Import-Toml**](#🔅-Import-Toml)|⚡ ***`ptim`*** |
|`🔅` [**New-TomlFile**](#🔅-New-TomlFile)|⚡ ***`ptnf`***|
|`🔅` [**Get-TomlProperty**](#🔅-Get-TomlProperty)|⚡ ***`ptgp`*** |
|`🔅` [**Get-TomlProperties**](#🔅-Get-TomlProperties)|⚡ ***`ptps`*** |
|`🔅` [**Add-TomlProperty**](#🔅-Add-TomlProperty)|⚡ ***`ptap`*** |
|`🔅` [**Set-TomlProperty**](#🔅-Set-TomlProperty)|⚡ ***`ptsp`*** |
|`🔅` [**Expand-TomlKey**](#🔅-Expand-TomlKey)|⚡ ***`ptek`*** |
|`🔅` [**Remove-TomlProperty**](#🔅-Remove-TomlProperty)|⚡ ***`ptrp`*** |
|`🔅` [**Import-HashtableToTomltable**](#🔅-Import-HashtableToTomltable)|⚡ ***`ptiht`*** |
|`🔅` [**Convert-PSObjectToHashTable**](#🔅-Convert-PSObjectToHashTable)|⚡ ***`ptcoth`*** |
|`🔅` [**ConvertTo-Toml**](#🔅-Convertto-Toml)|⚡ ***`ptct`*** |

## 🔰 Cmdlets

### `🔅` Import-Toml 
Imports **TOML** from a string or file to a **TomlTable** object compatible with `tomlyn`.

##### 🟢 *Parameters*:
```Powershell
Import-Toml [-TomlString|t] <string>
            [-PName|pn] <string> 
            [-log|l $false] <bool>
            [<CommonParameters>]
```


##### 🔵 *Example*: 
```powershell
# Import-Toml from string 
Import-Toml -TomlString $tomlContent

# Import-Toml from file
Import-Toml -TomlString (get-content -raw -path 'test.toml')

# Alias 
ptim -t $tomlContent
```

---

### `🔅` New-TomlFile

Creates a new **.toml** file, takes a **hashtable** of properties, updates the `TomlTable` and writes it to the specified file in **TOML** string format.

##### 🟢 *Parameters*:
```powershell
[New-TomlFile|ptnf] [-FilePath|f] <string> 
                    [-HashTable|h] <hashtable>
                    [-Log|l $false] <bool>
                    [<CommonParameters>]
```

##### 🔵 *Example*: 
```powershell
# HashTable to to Export As Toml
$tomlcontent = @{
    foo = 'bar'
    sdc = @{
        sdc1 = @{ sdc1 = $true }
        sdc2 = 'sdc2'
    }
}

# Import-Toml from string 
New-TomlFile -FilePath 'C:\path\to\newfile.toml' -TomlContent $tomlcontent

# Alias
ptnf -f 'C:\path\to\newfile.toml' -t $tomlcontent
```

---

### `🔅` Get-TomlProperty
Gets a property from a **TomlTable** object, returns the property of the **TOML** object as new **TomlTable** object. cmdlets supports `.` notation for nested `TomlTables` -> `inline-tables` in toml.

##### 🟢 *Parameters*:
```powershell
Get-TomlProperty [-NodePath|n] <string>
                 [-PName|p] <string>
                 [-Log|l $false] <bool>
                 [<CommonParameters>]
```

##### 🔵 *Example*: 
```powershell
# Import Toml from string or file
$tomlContent = Import-Toml -TomlString (get-content -raw -path 'test.toml')

# Get the property Property
Get-TomlProperty -NodePath 'Path.to.property' -PName 'Name'

# Alias
ptgp -n 'Path.to.property' -p 'Name'
```

Use the pipeline to expand table data value, some examples below:

##### 🔵 *Example*: 
```powershell
(Get-TomlProperty Path.to.property).where({$_.key -eq 'KeyName'}).Value

# or via Pipe
Get-TomlProperty Path.to.property | Select-Object -ExpandProperty KeyName

# or 
(Get-TomlProperties -AsHashTable).Path.to.property.KeyName
```

---

### `🔅` Get-TomlProperties
Get all properties from a **TomlTable** root object. Returns the properties of the **TOML** object As Toml `[string]` or the powershell representation of the **TomlTable** object, the parse object is a `System.Collections.Generic.KeyValuePair2[[System.String],[System.Object]]` from the model `Tomlyn.model.TomlTable` which PowerShell interpret as a `system.object[]` essentially allowing you to access the toml object using `array-indexing`, `where`, `pipes` etc.

>  **📌 TIP** 
> `-AsHashTable` parameter to return the toml object as a `[hashtable]`.
> `-AsJson` parameter to return the toml object as a `[json]`.
> `Default` Get-TomlProperties` returns the `Tomlyn.model.TomlTable` which in powershell is a `system.object[key,value]` 

##### 🟢 *Parameters*:
```powershell
Get-TomlProperties [-AsTomlString|t] <bool>
                   [-AsHashTable|h] <bool>
                   [-AsJson|j] <bool>
                   [-Log|l $false] <bool>
                   [<CommonParameters>]
```

##### 🔵 *Example*: 
```powershell
# Import Toml from string or file into powershell session
Import-Toml -TomlString (get-content -raw -path 'test.toml')

# returns the properties as tomltable array
# Outputs the toml string representation of the TOML object
Get-TomlProperties -TomlString 

# returns the properties as hashtable
# Outputs TomlTable in powershell repesentation of the tomlTable Object
Get-TomlProperties -AsHashTable

# returns the properties as json
# Outputs TomlTable in powershell repesentation of the tomlTable Object
Get-TomlProperties -AsJson

# Default: Outputs TomlTable in powershell repesentation of the tomlTable Object
Get-TomlProperties 

# Alias for Get-TomlProperties
ptps -t # returns the properties as tomltable array
ptps -h # returns the properties as hashtable
ptps -j # returns the properties as json
```

Accessing Table Data Values

##### 🔵 *Example*: 
```powershell

# List all keys in tomltable root object
Get-TomlProperties

# cmdlet to expand the tomltable object
Expand-TomlKey -NodePath 'Path.to.property' -KeyName 'Name'

# Using where to filter the tomltable object
(Get-TomlProperties).where({$_.key -eq 'KeyName'}).Value

# or via Pipe to filter the tomltable object
Get-TomlProperties | Where-Object {$_.key -eq 'KeyName'}
Get-TomlProperties | Expand-TomlKey -KeyName 'KeyName'
```

---

### `🗜` Add-TomlProperty
Adds a property to the `TomlTable` object, cmdlets supports `.` notation for nested `TomlTables`, cmdlets supports `.` notation for nested `TomlTables`.

##### 🟢 *Parameters*:
```powershell
Add-TomlProperty [-NodePath|n] <string>
                 [-PValue|p] <object>
                 [-Log|l $false] <bool>
                 [<CommonParameters>]
```

##### 🔵 *Example*: 
```powershell
# Import Toml from string or file into powershell session
Import-Toml -TomlString (get-content -raw -path 'test.toml')

# Add the property Property to the tomltable object
Add-TomlProperty -NodePath 'Path.to.property' -TValue $value

# Alias for Add-TomlProperty
ptap -n 'Path.to.property' -tv $value
```

---

### `🗜` Set-TomlProperty
Update a property in a `TomlTable` object, cmdlets supports `.` notation for nested `TomlTables`, cmdlets supports `.` notation for nested `TomlTables` -> `inline-tables` in toml.

##### 🟢 *Parameters*:
```Powershell
Set-TomlProperty [-NodePath|n] <string> 
                 [-PName|pn] <string> 
                 [-PValue|pv] <object>
                 [-Log|l $false] <bool>
                 [<CommonParameters>]
```

##### 🔵 *Example*: 
```powershell
# Import Toml from string or file
$tomlContent = Import-Toml -TomlString (get-content -raw -path 'test.toml')

# Get the property Property
Set-TomlProperty -NodePath 'Path.to.property' -TName 'Name' -TValue $value

# Alias
ptsp -n 'Path.to.property' -tn 'name' -tv $value
```

---

### `🗜` Expand-TomlKey
Expands a `system.object[]` `KeyValuePair` Property, Supports any `System.Object[]`

##### 🟢 *Parameters*:
```Powershell
Expand-TomlKey [-Object|n] <object> 
               [-KeyName|k] <string> 
               [-Log|l $false] <bool>
               [<CommonParameters>]
```

##### 🔵 *Example*: 
```powershell
# Import Toml from string or file into powershell session
Import-Toml -TomlString (get-content -raw -path 'test.toml')

# Expand TomlTable Key using pipe
Get-Properties | Expand-TomlKey -KeyName 'KeyName'

# Alias for Expand-TomlKey
ptps | ptek -k 'KeyName'
```
 
---

### `🔅` Remove-TomlProperty
Removes a property from the `TomlTable` object, cmdlets supports `.` notation for nested `TomlTables` -> `inline-tables` in toml.

##### 🟢 *Parameters*:
```Powershell
Remove-TomlProperty [-NodePath|n] <object> 
                    [-Log|l $false] <bool>
                    [<CommonParameters>]
```

##### 🔵 *Example*: 
```powershell
# Import Toml from string or file
Import-Toml -TomlString (get-content -raw -path 'test.toml')

# Remove the property Property
Remove-TomlProperty -NodePath 'Path.to.property' -PropertyName 'Name'

# Alias
ptrp -n 'Path.to.property' -p 'Name'
```

---

### `🔅` Import-HashtableToTomltable
Converts a PowerShell `[Hashtable]` **object** to a `TomlTable` **object**, use `Get-TomlProperties -TomlString` to get the toml string representation of the TOML object, or `Export-TomlFile` or `Get-TomlProperties -TomlString | Out-File -file 'path'` to save the toml string to a file.

> 📌 **!NOTE** 
> Nested `TomlTables` are `inline-tables` in toml, ***ptoml*** treats them as `hashtables` in PowerShell.

> 📌 **!TIP** 
> A quick and easy way to create a new toml file is to use `@{} | New-TomlFile -FilePath` or `@{} | ptnf -f` to create a new toml file from a hashtable.

##### 🟢 *Parameters*:
```Powershell
Import-HashtableToTomltable [-HashTable|h] <string> 
                            [-Log|l $false] <bool>
                            [<CommonParameters>]
```

##### 🔵 *Example*: 
```powershell
$hashtable = @{
    foo = 'bar'
    sdc = @{
        sdc1 = @{ enabled = $true, status = 'online' }
        sdc2 = @{ enabled = $false, status = 'offline' }
    }
}

# Import Toml from string or file into powershell session
Import-HashtableToTomltable -HashTable $hashtable
# or
$hashtable | Import-HashtableToToml

# returns tomltable, toml string, hashtable or json representation of the toml object
Get-TomlProperties # returns tomltable object
Get-TomlProperties -TomlString # returns toml string
Get-TomlProperties -AsHashTable # returns hashtable
Get-TomlProperties -AsJson # returns json
```

---

### `🔅` Convert-PSObjectToHashTable
Converts a PowerShell `[psobject]` or `[pscustomobject]` to a `[hashtable]` **object**. supports nested `psobjects` and `pscustomobjects`.

*🟢 Parameters*:
```Powershell
Convert-PSObjectToHashTable [-PsObject|p] <PSObject> 
                            [-Log|l $false] <bool>
                            [<CommonParameters>]
```

*🦚 Example*: 
```powershell
$psobject | Convert-PSObjectToHashTable

# or via pipe to convert a psobject to hashtable and import hashtable to tomltable
Convert-PSObjectToHashTable -PSObject $psobject | Import-HashtableToToml

# export toml string to file
Get-TomlProperties -TomlString | Out-File -FilePath .\test.toml
```

---

### `🔅` ConvertTo-Toml
Converts a PowerShell `[psobject]` or `[pscustomobject]` to a `[hashtable]` **object**. supports nested `psobjects` and `pscustomobjects`, extracts membertype `noteproperty` and converts to `tomltable` or `hashtable`.

🟢 *Parameters*:
```Powershell
Convertto-Toml [-PsObject|p] <PSObject> 
               [-Log|l $false] <bool>
               [<CommonParameters>]
```

##### 🔵 *Example 1*: 

```powershell
# Convert PSCustomObject to TomlTable
$pscustomobject | Convertto-Toml
$psobject | Convertto-Toml
$hashtable | Convertto-Toml
```