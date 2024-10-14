# Check if Watchman is installed
if (-not (Get-Command watchman -ErrorAction SilentlyContinue)) {
    Write-Host "Watchman is not installed. Please install Watchman and try again."
    exit
}

# Define project directory as the current location
$projectDir = Get-Location

# Paths to the config and script files
$watchmanConfigPath = Join-Path $projectDir ".watchmanconfig"
$autoCommitScriptPath = Join-Path $projectDir "autoGitCommit.ps1"
$triggerName = "autoGitCommit"

# URLs of the autoGitCommit.ps1 and .watchmanconfig files on GitHub
$autoCommitUrl = "https://raw.githubusercontent.com/danielrbenjamin/git-autocommit/refs/heads/main/autoGitCommit.ps1"
$watchmanConfigUrl = "https://raw.githubusercontent.com/danielrbenjamin/git-autocommit/refs/heads/main/.watchmanconfig"

# Download the autoGitCommit.ps1 script from GitHub
try {
    Invoke-WebRequest -Uri $autoCommitUrl -OutFile $autoCommitScriptPath -ErrorAction Stop
    Write-Host "Downloaded autoGitCommit.ps1 successfully."
} catch {
    Write-Host "Failed to download autoGitCommit.ps1 from GitHub."
    exit
}

# Download the .watchmanconfig file from GitHub
try {
    Invoke-WebRequest -Uri $watchmanConfigUrl -OutFile $watchmanConfigPath -ErrorAction Stop
    Write-Host "Downloaded .watchmanconfig successfully."
} catch {
    Write-Host "Failed to download .watchmanconfig from GitHub."
    exit
}

# Start watching the directory with Watchman
try {
    & watchman watch-project .
    Write-Host "Watchman is now watching the directory."
} catch {
    Write-Host "Failed to start watching the directory with Watchman."
    exit
}

# Create a new Watchman trigger to run the script with ExecutionPolicy Bypass
$watchmanTriggerCommand = "watchman -- trigger $projectDir $triggerName '**/*' -- powershell -ExecutionPolicy Bypass -File $autoCommitScriptPath"
try {
    Invoke-Expression $watchmanTriggerCommand
    Write-Host "Watchman trigger created successfully."
} catch {
    Write-Host "Failed to create Watchman trigger."
    exit
}

Write-Host "Setup completed. Watchman is now watching the directory and will auto-commit changes."
