if "%2"=="" (
  set argument_path=%root%amigo_browser_38
) else (
  set argument_path=%2
)

echo %argument_path%
start "" /MAX TortoiseGitProc.exe /command:%1 /path:%argument_path%
