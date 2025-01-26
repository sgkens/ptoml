im .\ -force
import-toml -TomlString (Get-Content -Path .\ptoml-new.toml -raw)
#get-TomlProperties
get-TomlProperties | Expand-TomlKey -KeyName 'test' -log

@(@{test='test'}) | expand-TomlKey -KeyName 'test'
