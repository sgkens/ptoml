# Remove dist folder if it exists
if(test-path ".\dist"){ remove-item .\dist -Recurse -Force -erroraction silentlycontinue }
else{New-Item -Path .\ -Name dist -ItemType Directory}

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



# Import Modules local for now
import-module -Name G:\devspace\projects\powershell\_repos\commitfusion\; # Get-GitAutoVerion extracted and used as standalone
import-module -name G:\devspace\projects\powershell\_repos\quicklog\;
import-module -name G:\devspace\projects\powershell\_repos\psmpacker\; 
import-module -Name G:\devspace\projects\powershell\_repos\nupsforge\; 
import-module -name G:\devspace\projects\powershell\_repos\csverify\; 


# Build the module
.\devops\scripts\build-module.ps1
.\devops\scripts\Build-packages.ps1