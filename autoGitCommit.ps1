# Define project directory as the current location
$projectDirectory = Get-Location

# Check if this is a git repository (i.e., if .git folder exists)
if (-not (Test-Path "$projectDirectory\.git")) {
    Write-Host "This directory is not a git repository."
    exit
}

# Check for pause file
if (Test-Path -Path "$projectDirectory\.autogitpause") {
    Write-Host "Autogit is paused. Exiting..."
    exit
}

# Get the list of changed files along with their status
$changedFiles = git status --porcelain

# Add all changes
git add -A

# Commit added changes with a timestamp and list of changed files with their status
$commitMessage = "Auto-commit: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')`nFiles changed:`n$($changedFiles -join "`n")"

git commit -m "$commitMessage"
