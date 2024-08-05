# Navigate to the project directory
cd "PROJECT DIRECTORY"

# Add all changes
git add -A

# Commit added changes with a timestamp message
git commit -m "Auto-commit: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
