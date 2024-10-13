# git-autocommit
git commit every time a file is saved on Windows

Inspired by [https://github.com/DieterReuter/git-autocommit?tab=readme-ov-file](https://github.com/DieterReuter/git-autocommit)

Dependent on [Facebook Watchman](https://facebook.github.io/watchman/)

For both installation options, you must first install Watchman on Windows from either the [latest release](https://github.com/facebook/watchman/releases/latest) or using [Chocolatey](https://community.chocolatey.org/packages/watchman). \
The target directory should already be a git repo.

1. Automatic Install Option:
* run `Invoke-WebRequest -Uri "https://raw.githubusercontent.com/danielrbenjamin/git-autocommit/023e2b220ba33b133f5060a19a4e6c708c6fadca/autoInstall.ps1" -OutFile "$env:TEMP\autoInstall.ps1"; powershell -ExecutionPolicy Bypass -File "$env:TEMP\autoInstall.ps1"` in the desired git repo directory

2. Manual Install Option:
* Copy the `.watchmanconfig` and `autoGitCommit.ps1` files into the desired directory, replacing `projectDirectory` with the actual file path
* In PowerShell, run `watchman watch .` in the desired directory
* Then run `watchman -- trigger "projectDirectory" save-trigger '**/*' -- powershell -ExecutionPolicy Bypass -File "projectDirectory\autoGitCommit.ps1"`, replacing projectDirectory with the actual file path

To temporarily pause git-autocommit, create a file with the name `.autogitpause`. To resume, delete the file.
