@{

    RootModule           = 'ptoml.psm1'
    ModuleVersion     = '0.1.0.0' # 4th number must be omiited if using pre-release
    # CompatiblePSEditions = @()
    GUID                 = '32103f6a-74d0-4870-8d28-0856f84010a8'
    Author               = 'Garvey k. Snow'
    CompanyName          = 'phellams'
    Copyright            = '2024 @ Garvey k. Snow. All rights reserved.'
    Description          = 'Simple Toml Parser for PowerShell built using the tomlyn**](https://github.com/xoofx/Tomlyn) Library.'
    PowerShellVersion    = '7.0'
    # PowerShellHostName = ''
    # PowerShellHostVersion = ''
    # DotNetFrameworkVersion = ''
    # ClrVersion = ''
    # ProcessorArchitecture = ''
    # RequiredModules = @()
    RequiredAssemblies = @()
    # ScriptsToProcess = @()
    # TypesToProcess = @()
    # FormatsToProcess = @()
    FunctionsToExport    = @(
        'New-TomlFile', 
        'Import-Toml', 
        'Add-TomlProperty', 
        'Get-TomlProperties', 
        'Get-TomlProperty',
        'Expand-TomlKey',
        'Set-TomlProperty',
        'Remove-TomlProperty',
        'Import-HashtableToTomltable',
        'Convert-PSObjectToHashTable',
        'ConvertTo-Toml'
        )
    CmdletsToExport      = @()
    VariablesToExport    = @()
    AliasesToExport      = @(
        'ptnf', 
        'ptim', 
        'ptap', 
        'ptps',
        'ptgp', 
        'ptrp',
        'ptek',
        'ptsp',
        'ptiht',
        'ptcoth',
        'ptct'
        )
    NestedModules        = @()
    # DscResourcesToExport = @()
    ModuleList = @()
    # FileList = @()
    PrivateData          = @{
        PSData = @{
            Tags             = 'parser', 'toml', 'automation', 'configuration'
            LicenseUrl       = 'https://choosealicense.com/licenses/mit'
            ProjectUrl       = 'https://github.com/phellams/ptoml'
            IconUrl          = 'https://raw.githubusercontent.com/phellams/phellams-general-resources/main/logos/ptoml/ptoml.png'
            ReleaseNotes     = 'https://github.com/sgkens/ptoml/-/blob/main/Releases'
            #Prerelease       = 'preview'
            # RequireLicenseAcceptance = $false
            # ExternalModuleDependencies = @()
            Docsurl          = 'https://pages.gitlab.io/sgkens/ptoml'
            MailingListUrl   = 'https://github.com/phellams/ptoml/issues'
            projectSourceUrl = 'https://github.com/phellams/ptoml'
            bugTrackerUrl    = 'https://github.com/phellams/ptoml/issues'
            Summary          = 'Simple Toml Parser for PowerShell built using the tomlyn**](https://github.com/xoofx/Tomlyn) Library.'
        }
    }
    HelpInfoURI          = ''
    #DefaultCommandPrefix = ''
}

