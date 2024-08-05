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
# Navigate to the project directory
cd "$projectDir"

# Add all changes
git add -A

# Commit changes with a timestamp message
git commit -m "Auto-commit: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
"@
Set-Content -Path $autoCommitScriptPath -Value $autoCommitScriptContent -Force

# Start watching the directory with Watchman
& watchman watch $projectDir

# Remove existing trigger if it exists
& watchman trigger-del $projectDir $triggerName

# Create a new Watchman trigger to run the script with ExecutionPolicy Bypass
$watchmanTriggerCommand = "watchman -- trigger $projectDir $triggerName '**/*' -- powershell -ExecutionPolicy Bypass -File $autoCommitScriptPath"
Invoke-Expression $watchmanTriggerCommand

Write-Host "Setup completed. Watchman is now watching the directory and will auto-commit changes."
