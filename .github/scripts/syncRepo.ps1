# ------------------------------------------------------------------------------------
# Sync the current repo with a remote repo
# ------------------------------------------------------------------------------------
# You must supply the Org Name, Repo Name, and a PAT token that has write access to the repo.
# Example Usage:
# ./SyncRepo.ps1  -orgName 'orgName' -repoName 'repoName' -patToken 'xxxxxxxx'
#  > git remote add destination https://<insert-pat-here>@github.com/lluppes/test-sync-repo.git
#  > git push destination main -f
#  > git remote remove destination
# ------------------------------------------------------------------------------------

param(
    [Parameter(Mandatory = $true)] [string] $repoName,
    [Parameter(Mandatory = $true)] [string] $orgName,
    [Parameter(Mandatory = $true)] [string] $patToken
)

Write-Host "----------------------------------------------------------------------------------------------------" -ForegroundColor Yellow
Write-Host "** $(Get-Date -Format HH:mm:ss) - Starting Sync Repo with the following parameters:" -ForegroundColor Yellow
Write-Host "** Target GitHub Org: $orgName" -ForegroundColor Yellow
Write-Host "** Target Repository: $repoName" -ForegroundColor Yellow
Write-Host "** PAT Token: ********" -ForegroundColor Yellow
Write-Host "----------------------------------------------------------------------------------------------------" -ForegroundColor Yellow
Write-Host "`n"

Write-Host "WARNING: Continuing with this action will do a FORCE Push over the Target Repository $repoName" -ForegroundColor Red
$confirmation = Read-Host "Do you want to continue with syncing the repo and overwriting the target? (y/n)"
if ($confirmation -ne 'y' -and $confirmation -ne 'Y') {
  Write-Host "Operation cancelled by user." -ForegroundColor Red
  exit
}

Write-Host "Adding Git Remote Destination..." -ForegroundColor Yellow
Write-Host "  git remote add destination https://$($patToken)@github.com/$($orgName)/$($repoName).git" -ForegroundColor Yellow
git remote add destination https://$($patToken)@github.com/$($orgName)/$($repoName).git

Write-Host "Pushing changes to destination..." -ForegroundColor Yellow
Write-Host "  git push destination main -f" -ForegroundColor Yellow
git push destination main -f

Write-Host "Removing Git Remote Destination..." -ForegroundColor Yellow
Write-Host "  git remote remove destination" -ForegroundColor Yellow
git remote remove destination

Write-Host "Finished!" -ForegroundColor Green
