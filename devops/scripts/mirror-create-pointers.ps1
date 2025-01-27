using module ..\keyfile\keyfile.psm1 # Import Get-KeyFromFile
#---CONFIG----------------------------
$reponame = Get-KeyfromFile -path '.\devops\build_config.json' -key 'ModuleName'
$user = Get-KeyfromFile -path '.\devops\build_config.json' -key 'gituser'
$gitlab_mirror_name = "gitlab_mirror"
$github_mirror_name = "github_mirror"
    #---CONFIG----------------------------

try {


    $repo_string = "https://$user`:$ENV:GITLAB_API_KEY@$gitlab.com/$user/$RepoName.git"
    git remote add $gitlab_mirror_name $repo_string
    git remote set-url --push $name $repo_string
    git push $gitlab_mirror_name --all
    if($LASTEXITCODE -eq 0) {
        Write-Host "Gitlab Mirror Added"
    }else {
        throw [system.exception] "Failed to add Gitlab Mirror Exit Code:$LASTEXITCODE, url:$repo_string"
    }

    # ADD local Mirror - Github
    # -----------------
    $repo_string = "https://$user`:$ENV:GITHUB_API_KEY@$github.com/$user/$RepoName.git"
    git remote add $github_mirror_name $repo_string
    git remote set-url --push $name $repo_string
    git push $github_mirror_name --all
    if($LASTEXITCODE -eq 0) {
        Write-Host "Github Mirror Added"
    }else {
        throw [system.exception] "Failed to add Github Mirror Exit Code:$LASTEXITCODE, url:$repo_string"
    }

    }catch [system.exception] {
        [console]::write("failed to create local mirror: $($_.exception.message)`n")
    }
}

# Remove local Mirrors
# -----------------
git remote remove gitlab_mirror
git remote remove github_mirror
