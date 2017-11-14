rem prepare
set root_path=f:\Projects\Amigo\AmigoMerge
set vs_path="e:\Program Files\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe"

set "PATH=%root_path%\depot_tools;%PATH%;"

start %vs_path% "%root_path%\amigo_browser_38\src\chrome\chrome.sln"
