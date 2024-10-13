# Define project directory as the current location and use forward slashes
$projectDir = (Get-Location).ToString() -replace '\\', '/'

# Ensure that the path is properly quoted in case of spaces or special characters
$quotedProjectDir = "`"$projectDir`""

# Paths to the config and script files
$watchmanConfigPath = Join-Path $projectDir ".watchmanconfig"
$autoCommitScriptPath = Join-Path $projectDir "autoGitCommit.ps1"
$triggerName = "autoGitCommit"

# URLs of the autoGitCommit.ps1 and .watchmanconfig files on GitHub
$autoCommitUrl = "https://raw.githubusercontent.com/danielrbenjamin/git-autocommit/023e2b220ba33b133f5060a19a4e6c708c6fadca/autoGitCommit.ps1"
$watchmanConfigUrl = "https://raw.githubusercontent.com/danielrbenjamin/git-autocommit/023e2b220ba33b133f5060a19a4e6c708c6fadca/.watchmanconfig"

# Download the autoGitCommit.ps1 script from GitHub
Invoke-WebRequest -Uri $autoCommitUrl -OutFile $autoCommitScriptPath

# Download the .watchmanconfig file from GitHub
Invoke-WebRequest -Uri $watchmanConfigUrl -OutFile $watchmanConfigPath

# Start watching the directory with Watchman using forward slashes and quoted path
& watchman watch $quotedProjectDir

# Create a new Watchman trigger to run the script with ExecutionPolicy Bypass using the quoted path
$watchmanTriggerCommand = "watchman -- trigger $quotedProjectDir $triggerName '**/*' -- powershell -ExecutionPolicy Bypass -File `"$autoCommitScriptPath`""
Invoke-Expression $watchmanTriggerCommand

Write-Host "Setup completed. Watchman is now watching the directory and will auto-commit changes."
