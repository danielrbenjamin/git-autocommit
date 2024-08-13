# Check for pause file
if (Test-Path -Path "PROJECTDIRECTORY") {
    exit
}

# Navigate to the project directory
cd "PROJECTDIRECTORY"

# Add all changes
git add -A

# Commit added changes with a timestamp message
git commit -m "Auto-commit: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
