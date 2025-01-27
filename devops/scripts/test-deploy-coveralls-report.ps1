# Codecov Coverage Report

#---CONFIG----------------------------

#---CONFIG----------------------------

#------------------------------------
if (!(get-command codecov)) {
    throw [system.exception]::new("Unable to find converalls in $env:path")
    break;
}
codecov upload-process --file coverage.xml --build $(Get-GitAutoVersion).version --branch $(git rev-parse --abbrev-ref HEAD)