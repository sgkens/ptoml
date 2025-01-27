using module ..\Get-GitAutoVersion.psm1

#---CONFIG----------------------------
$ModuleConfig = Get-Content -Path .\devops\build_config.json | ConvertFrom-Json
[string[]]$ModuleFiles = $ModuleConfig.ModuleFiles
[string[]]$ModuleFolders = $ModuleConfig.ModuleFolders
[string[]]$ModuleExclude = $ModuleConfig.ModuleExclude
[string]$moduleName = $ModuleConfig.moduleName
#---CONFIG----------------------------

# Remove dist folder if it exists
if (test-path ".\dist") { remove-item .\dist -Recurse -Force -erroraction silentlycontinue }
else { New-Item -Path .\ -Name dist -ItemType Directory }

# build and copy ptoml.tomlparser C# library includes tomlyn.dll and ptoml.dll
if (!(Test-Path -path '.\lib\ptoml' -ErrorAction SilentlyContinue)) { 
    New-Item -ItemType Directory -Path '.\lib\ptoml' -Force  
}
dotnet publish -c release -r win-x64
copy-item -path '.\ptoml\bin\release\net8.0\win-x64\publish\ptoml.deps.json' `
    -Destination '.\lib\ptoml' `
    -Recurse `
    -Verbose
copy-item -path '.\ptoml\bin\release\net8.0\win-x64\publish\ptoml.pdb' `
    -Destination '.\lib\ptoml' `
    -Recurse `
    -Verbose
copy-item -path '.\ptoml\bin\release\net8.0\win-x64\publish\ptoml.dll' `
    -Destination '.\lib\ptoml' `
    -Verbose
copy-item -path '.\ptoml\bin\release\net8.0\win-x64\publish\Tomlyn.dll' `
    -Destination '.\lib\ptoml' `
    -Recurse `


[console]::Write("Module Name:  $moduleName")

$AutoVersion = (Get-GitAutoVersion).Version

# for csverify
if (!(Test-Path -Path ".\dist\$moduleName\tools")) { 
    New-Item -Path ".\dist\$moduleName\tools" -ItemType Directory 
}

# Create dist folder
if (!(Test-Path -Path .\dist)){ 
    New-Item -Path '.\dist' -ItemType Directory 
}

Build-Module -SourcePath .\ `
             -DestinationPath '.\dist' `
             -Name $moduleName `
             -IncrementVersion None `
             -FilesToCopy $ModuleFiles `
             -FoldersToCopy $ModuleFolders `
             -ExcludedFiles $ModuleExclude `
             -Manifest `
             -Version $AutoVersion
