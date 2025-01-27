# Remove all build temp files, .dlls, .nupkg, .nuspec from rootfolder
# usefull if building locally

remove-item .\dist -Recurse -Force -erroraction silentlycontinue
remove-item .\lib\ptoml -Recurse -Force -erroraction silentlycontinue