$projectDirectory = Get-Location

# Check for pause file
if (Test-Path -Path "$projectDirectory\.autogitpause") { 
    exit
}

# Add all changes
git add -A

# Get the list of changed files along with their status
$changedFilesArray = git diff --cached --name-status

$changedFiles = $changedFilesArray -join "`n"

# Commit added changes with a timestamp in the title and the list of changed files with their status in the description
$commitTitle = "Auto-commit: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$commitDescription = "Files changed:`n$($changedFiles)"
git commit -m "$commitTitle" -m "$commitDescription"
