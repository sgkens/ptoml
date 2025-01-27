#---CONFIG----------------------------
$ModuleConfig = Get-Content -Path .\devops\build_config.json | ConvertFrom-Json
$ModuleName                 = $ModuleConfig.moduleName
$gitlab_username            = $ModuleConfig.gituser
$gitlab_uri                 = "https://$($ENV:GITLAB_HOST)"
$projectid                  = $ModuleConfig.gitlabId
#---CONFIG----------------------------

#------------------------------------
$ModuleManifest   = Test-ModuleManifest -path ".\dist\$ModuleName\$ModuleName.psd1"
$SemVerVersion    = $ModuleManifest.Version -replace "\.\d+$", ""
$NugetProjectPath = "api/v4/projects/$projectid/packages/nuget/index.json"

try {
  Write-host -foregroundcolor yellow "Attempting to Register Gitlab: $gitlab_uri@$Gitlab_Username"
  #dotnet nuget add source $gitlab_uri/$NugetProjectPath --name gitlab --username $GitLab_Username --password $ENV:GITLAB_API_KEY
  nuget sources add -name "gitlab_$projectid_$ModuleName`_Packages" -source $gitlab_uri/$NugetProjectPath -username $GitLab_Username -password $env:GITLAB_API_KEY
  Write-host -foregroundcolor green "Complete"
}
catch [system.exception] {
  Write-Host "Failed to push to gitlab"
  Write-Host $_
}

try {
  Write-host -foregroundcolor yellow "Attempting to push $modulename to Gitlab: $gitlab_uri/$NugetProjectPath"
  #dotnet nuget push .\dist\nuget\$modulename.$SemVerVersion.nupkg --source gitlab 
  nuget push .\dist\nuget\$modulename.$SemVerVersion.nupkg -Source "gitlab_$projectid_$ModuleName`_Packages" -ApiKey $env:GITLAB_API_KEY
  nuget sources remove -Name "gitlab_$projectid_$ModuleName`_Packages"
}
catch [system.exception] {
  Write-Host "Failed to push to gitlab"
  Write-Host $_
}