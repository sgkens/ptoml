#---CONFIG----------------------------
$ModuleConfig = Get-Content -Path .\devops\build_config.json | ConvertFrom-Json
$ModuleName = $ModuleConfig.moduleName
$ModuleManifest = Test-ModuleManifest -path ".\dist\$ModuleName\$ModuleName.psd1"
$PreRelease = $ModuleManifest.PrivateData.PSData.Prerelease
#---CONFIG----------------------------



if (!(Test-Path -path ".\dist\nuget")) { mkdir ".\dist\nuget" }
if (!(Test-Path -path ".\dist\choco")) { mkdir ".\dist\choco" }
if (!(Test-Path -path ".\dist\psgal")) { mkdir ".\dist\psgal" }



# ===========================================
#                https://raw.githubusercontent.com/yokoffing/Betterfox/main/user.js
# ===========================================
$NuSpecParams = @{
  path          = ".\dist\$ModuleName"
  ModuleName    = $ModuleName
  ModuleVersion = $ModuleManifest.Version #-replace "\.\d+$", ""
  Author        = $ModuleManifest.Author
  Description   = $ModuleManifest.Description
  ProjectUrl    = $ModuleManifest.PrivateData.PSData.ProjectUrl
  License       = $ModuleConfig.License
  company       = $ModuleManifest.CompanyName
  Tags          = $ModuleManifest.Tags
  dependencies  = $ModuleManifest.ExternalModuleDependencies
  PreRelease    = $PreRelease
}
# Copy Custom Readme base on repository destination
Copy-item -Path ".\devops\choco_description.md"  `
          -Destination ".\dist\$ModuleName\readme.md" `
          -Force `
          -Verbose
# Create Nuget nuspec, Proget, gitlab, PSGallery
New-NuspecPackageFile @NuSpecParams
# Create New Verification CheckSums requires root module directory
set-location ".\dist\$ModuleName"
New-VerificationFile -Path .\  -Output .\tools | Format-Table -auto
Test-Verification -Path .\ | Format-Table -auto
Set-location ../../ # back
New-NupkgPackage -path ".\dist\$ModuleName"  -outpath ".\dist\nuget"
# ===========================================


# ===========================================
#             PowerShell Gallery
# ===========================================
[console]::write( "Creating Zip File for PSGallery `n" )
[console]::write( "Source: .\dist\$($ModuleName)\* `n" )
[console]::write( "output: .\dist\psgal\$($zipFileName) `n" )
$zipFileName = "$ModuleName.zip"
# Create Zip With .nuspec file for PSGallery
# copy-item -recurse -path ".\dist\$ModuleName" -destination ".\dist\psgal\$ModuleName"
compress-archive -path ".\dist\$ModuleName\*" `
                 -destinationpath ".\dist\psgal\$zipFileName" `
                 -compressionlevel optimal `
                 -update
# ===========================================


# ===========================================
#                CHOCOLATEY
# ===========================================
# Remove nuspec file from build bold
Remove-Item -Path ".\dist\$ModuleName\$ModuleName.nuspec"

# Choco supports markdown nuget and psgallary done
$Choco_description = Get-Content -Path .\devops\choco_description.md -Raw

$NuSpecParamsChoco = @{
  path              = ".\dist\$ModuleName"
  ModuleName        = $ModuleName
  ModuleVersion     = $ModuleManifest.Version -replace "\.\d+$", "" # remove the extra .0 as semver has 0.0.0 and powershell 0.0.0.0
  Author            = $ModuleManifest.Author
  Description       = $Choco_description #-replace '```', '```' -replace '\`', '``'
  Summary           = $ModuleManifest.Description
  ProjectUrl        = $ModuleManifest.PrivateData.PSData.ProjectUrl
  IconUrl           = $ModuleManifest.PrivateData.PSData.IconUrl
  docsUrl           = $ModuleManifest.PrivateData.PSData.docsUrl
  projectSourceUrl  = $ModuleManifest.PrivateData.PSData.projectSourceUrl 
  MailingListUrl    = $ModuleManifest.PrivateData.PSData.MailingListUrl
  bugTrackerUrl     = $ModuleManifest.PrivateData.PSData.BugTrackerUrl
  LicenseUrl        = $ModuleManifest.PrivateData.PSData.LicenseUrl
  ReleaseNotes      = $ModuleManifest.PrivateData.PSData.ReleaseNotes
  company           = $ModuleManifest.CompanyName
  Tags              = $ModuleManifest.Tags
  dependencies      = $ModuleManifest.ExternalModuleDependencies
  PreRelease        = $PreRelease
  LicenseAcceptance = $false
}

# Copy Custom Readme base on repository destination
Copy-item -Path ".\devops\choco_description.md"  `
          -Destination ".\dist\$ModuleName\readme.md" `
          -Force `
          -Verbose
# Create Choco nuspec
New-ChocoNuspecFile @NuSpecParamsChoco
# Create New Verification CheckSums Request root module directory
Set-Location ".\dist\$ModuleName"
New-VerificationFile -Path .\ -Output .\tools | Format-Table -auto
Test-Verification -Path .\ | Format-Table -auto
Set-Location ../../ # back
New-ChocoPackage -path ".\dist\$ModuleName"  -outpath ".\dist\choco"