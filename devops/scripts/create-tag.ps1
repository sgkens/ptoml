using module ..\keyfile\keyfile.psm1 # Import Get-KeyFromFile

#---CONFIG----------------------------
$reponame = Get-KeyfromFile -path '.\devops\build_config.json' -key 'ModuleName'
# note: this is the user that will be used to push the tag ie if using group use group name
$gitUser = Get-KeyfromFile -path '.\devops\build_config.json' -key 'GitGroup' 
#---CONFIG----------------------------

# Generate Version
$semver_version = "v$((Get-GitAutoVersion).version)"

# push Tag
git config --global user.name $gitUser
git config --global user.email "$($ENV:GITLAB_EMAIL)"
git tag "$semver_version"
git push --tags https://${GITLAB_API_KEY}@gitlab.com/$gitUser/$reponame.git HEAD:main