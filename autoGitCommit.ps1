# Check for pause file
if (Test-Path -Path `"$projectDir\New Text Document.txt`") {
    exit
}

# Navigate to the project directory
cd `"$projectDir`"

# Add all changes
git add -A

# Commit added changes with a timestamp message
git commit -m `"Auto-commit: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')`"
