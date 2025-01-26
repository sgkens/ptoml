BeforeAll {
    $global:testHashtable = @{
        'servermembers' = @{
            'properties' = @{
                'servers' = @{
                    'server1' = '1.1.1.1';
                    'server2' = '1.1.1.2';
                    'server3' = '1.1.1.3';
                }
            }
        }
    }
    import-module -name .\
}

Describe 'cmdlet.New-TomlFile' {

    It 'should create a new TOML file with specified properties with hashtable input' {
        New-TomlFile -TomlContent $global:testHashtable -FilePath 'test.toml'
        Test-Path -Path 'test.toml' | Should -BeTrue
    }

    it 'Check Properties imported from new toml file to tomltable instance ' {
        import-toml -TomlString (Get-Content -Path 'test.toml' -Raw)
        (Get-TomlProperties -AsHashTable).servermembers.properties.servers.server1 | Should -eq '1.1.1.1'
    }

    # It 'Import TOML from string or file' {
    #     Import-toml -TomlString  (Get-Content -Path 'test.toml' -Raw) | Should -BeOfType $null
    # }

    # it "Delete File" {
    #     Remove-Item -Path 'test.toml'
    # }                
}

Describe 'Import-Toml.psm1' {

    It 'Import TOML from string or file' {
        $global:_ptoml.instance.purgeTableData()
        # cmdlet Import-toml and C# lib sln ptoml.tomlparser return void so unsure why it returns @($null, $null) 
        # works in this case a little confusing.
        Import-toml -TomlString  (Get-Content -Path 'test.toml' -Raw) | Should -Be @($null, $null) 
        (Get-TomlProperties -AsHashTable).servermembers.properties.servers.server1 | Should -eq '1.1.1.1'
    }
}

Describe 'Add-TomlProperty' {

    It 'Add a property to the toml object' {
        Add-TomlProperty -NodePath 'servermembers.properties.servers.server4' -PValue '10.10.10.10' | Should -Be $null
        # Add duplicate property should fail throws and catchs error output log message to console
        Add-TomlProperty -NodePath 'servermembers.properties.servers.server4' -PValue '10.10.10.10' | Should -Be $null
        (Get-TomlProperties -AsHashTable).servermembers.properties.servers.server4 | Should -eq '10.10.10.10'

    }
}

Describe 'Remove-TomlProperty' {

    It 'Remove a property from the toml object' {
        Remove-TomlProperty -PropertyPath 'servermembers.properties.servers.server4' | Should -Be $null
        (Get-TomlProperties -AsHashTable).servermembers.properties.servers.server4 | Should -eq $null
    }
}


Describe 'Set-TomlProperty' {

    It 'Set a property to the toml object' {
        Set-TomlProperty -NodePath 'servermembers.properties.servers.server4' -PValue '10.10.10.20' | Should -Be $null
        (Get-TomlProperties -AsHashTable).servermembers.properties.servers.server4 | Should -eq '10.10.10.20'
    }
}