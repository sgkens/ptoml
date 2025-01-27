#---CONFIG----------------------------
$ModuleName           = Get-KeyfromFile -path '.\devops\build_config.json' -key 'ModuleName'
$ModuleManifest       = Test-ModuleManifest -path ".\dist\$ModuleName\$ModuleName`.psd1"
$SemVerVersion        = $ModuleManifest.Version -replace "\.\d+$",""
#---CONFIG----------------------------

#------------------------------------
if(Get-command choco.exe){
  write-host "Chocolatey is installed, skipping install"
  write-host "Pushing to chocolatey https://community.chocolatey.org/"
  choco push .\dist\choco\$ModuleName.$SemVerVersion.nupkg --source 'https://community.chocolatey.org/' --api-key $ENV:CHOCO_API_KEY
  write-host "Pushed to chocolatey - Complete"
}else{
  write-host "Chocolatey is not installed, please install chocolatey https://community.chocolatey.org/"
  break;
}