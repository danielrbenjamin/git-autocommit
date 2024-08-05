# git-autocommit
git commit every time a file is saved on Windows

Inspired by [https://github.com/DieterReuter/git-autocommit?tab=readme-ov-file](https://github.com/DieterReuter/git-autocommit)

Based on [Facebook Watchman]([url](https://github.com/facebook/watchman)) 

For both installation options, you must first install Watchman on Windows from either the [latest release](https://github.com/facebook/watchman/releases/latest) or using [Chocolatey](https://community.chocolatey.org/packages/watchman)

1. Automatic Install Option:
* run autoinstall.ps1 in the desired git repo directory

2. Manual Install Option:
* Copy the .watchmanconfig file and autoGitCommit.ps1 into the desired directory, making sure to CHANGE PROJECTDIRECTORY on autoGitCommit.ps1 to actual file path
* In PowerShell, run `watchman watch .` in the desired directory
* Then `run watchman -- trigger "PROJECTDIRECTORY" save-trigger '**/*' -- powershell -ExecutionPolicy Bypass -File "PROJECTDIRECTORY\autoGitCommit.ps1"`, replacing PROJECTDIRECTORY with the actual file path
