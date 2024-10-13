# Define project directory
$projectDirectory = "C:\Users\danie\Downloads\test folder"

# Check for pause file
if (Test-Path -Path "$projectDirectory\.autogitpause") {
    exit
}

# Navigate to the project directory
cd $projectDirectory

# Get the list of changed files along with their status (e.g., M = Modified, A = Added, D = Deleted)
$changedFiles = git status --porcelain | ForEach-Object {
    $status, $file = $_ -split '\s+', 2
    "{0}: {1}" -f $status, $file
}

# Add all changes
git add -A

# Commit added changes with a timestamp and list of changed files with their status
$commitMessage = "Auto-commit: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')`nFiles changed:`n$($changedFiles -join "`n")"
git commit -m "$commitMessage"
