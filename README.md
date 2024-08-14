# git-autocommit
git commit every time a file is saved on Windows

Inspired by [https://github.com/DieterReuter/git-autocommit?tab=readme-ov-file](https://github.com/DieterReuter/git-autocommit)

Based on [Facebook Watchman]([url](https://github.com/facebook/watchman)) 

For both installation options, you must first install Watchman on Windows from either the [latest release](https://github.com/facebook/watchman/releases/latest) or using [Chocolatey](https://community.chocolatey.org/packages/watchman)

1. Automatic Install Option:
* copy and run `autoInstall.ps1` in the desired git repo directory
* depending on script permissions, may need to run `powershell -ExecutionPolicy Bypass -File autoInstall.ps1`

  OR

  Just run the following powershell command in the desired directory:

  `
$tempScript = Join-Path $env:TEMP "autoInstall.ps1"
iwr -useb 'https://raw.githubusercontent.com/danielrbenjamin/git-autocommit/main/autoInstall.ps1' -OutFile $tempScript
powershell -ExecutionPolicy Bypass -File $tempScript
  `
  
2. Manual Install Option:
* Copy the `.watchmanconfig` and `autoGitCommit.ps1` files into the desired directory, replacing PROJECTDIRECTORY with the actual file path
* In PowerShell, run `watchman watch .` in the desired directory
* Then run `watchman -- trigger "PROJECTDIRECTORY" save-trigger '**/*' -- powershell -ExecutionPolicy Bypass -File "PROJECTDIRECTORY\autoGitCommit.ps1"`, replacing PROJECTDIRECTORY with the actual file path

To temporarily pause git-autocommit, create a .txt file with the name `New Text Document.txt`. To resume, delete the file.
