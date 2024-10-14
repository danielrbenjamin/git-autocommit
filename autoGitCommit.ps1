# Add all changes
git add -A

# Get the list of changed files along with their status
$changedFiles = git status --porcelain

# Commit added changes with a timestamp message
git commit -m "Auto-commit: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')`nFiles changed:`n$(${changedFiles} -join "`n")"
