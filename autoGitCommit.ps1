# Check for pause file
if (Test-Path -Path "C:\Users\danie\Documents\Documents\Education\UBC\Miscellaneous\ECs\MEMS\Fenrir Hand v1\New Text Document.txt") {
    exit
}

# Navigate to the project directory
cd "C:\Users\danie\Documents\Documents\Education\UBC\Miscellaneous\ECs\MEMS\Fenrir Hand v1"

# Add all changes
git add -A

# Commit added changes with a timestamp message
git commit -m "Auto-commit: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
