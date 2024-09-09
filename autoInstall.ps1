# Get the directory where the script is being run
$projectDir = Get-Location

# Paths to the config and script files
$watchmanConfigPath = Join-Path $projectDir ".watchmanconfig"
$autoCommitScriptPath = Join-Path $projectDir "autoGitCommit.ps1"
$triggerName = "auto-commit"

# Create .watchmanconfig file to ignore .git directory
$watchmanConfigContent = @'
{
  "ignore_dirs": [".git"]
}
'@
Set-Content -Path $watchmanConfigPath -Value $watchmanConfigContent -Force

# Create autoGitCommit.ps1 script
$autoCommitScriptContent = @"
# Check for pause file
if (Test-Path -Path `"$projectDir\New Text Document.txt`") {
    exit
}

# Get the names of changed files
$changedFiles = git status --porcelain | ForEach-Object { $_.Substring(3) } | Out-String

# Add all changes
git add -A

# Commit added changes with a timestamp and list of changed files
if (-not [string]::IsNullOrWhiteSpace($changedFiles)) {

    $commitMessage = "Auto-commit: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')`nChanged files:`n$changedFiles"

    git commit -m $commitMessage

}

"@

Set-Content -Path $autoCommitScriptPath -Value $autoCommitScriptContent -Force

# Start watching the directory with Watchman
& watchman watch "`"$projectDir`""

# Remove existing trigger if it exists
& watchman trigger-del "`"$projectDir`"" $triggerName

# Create a new Watchman trigger to run the script with ExecutionPolicy Bypass
$watchmanTriggerCommand = "watchman -- trigger `"$projectDir`" $triggerName '**/*' -- powershell -ExecutionPolicy Bypass -File `"$autoCommitScriptPath`""
Invoke-Expression $watchmanTriggerCommand

Write-Host "Setup completed. Watchman is now watching the directory and will auto-commit changes."
