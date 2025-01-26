import-module -name .\

$tabledata = get-content -Path .\ptoml-test-2.toml -raw | ConvertFrom-Toml

Add-TomlTableProperty -PathString 'servermembers' -Value @('file1', 'file2')