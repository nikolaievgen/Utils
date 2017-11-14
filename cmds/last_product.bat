rem *******************************************************************************************
rem   Replace product build release
rem   ftp://amigo-builder.mail.msk/amigo_browser/last_stable_build.exe - release in production
rem   ftp://amigo-builder.mail.msk/amigo_browser/last_test_build.exe - last for testing
rem *******************************************************************************************

: for debug
set PRODUCTION_BUILD=0
set AMIGO_BROWSER_BRANCH=test
e:
cd e:\amigo_browser_38\%AMIGO_BROWSER_BRANCH%\
:

: determine name 
set last_build_name=e:\amigo_browser_38
if %PRODUCTION_BUILD%==1 (
  set last_build_name=%last_build_name%\last_stable_build.exe
) else (
  set last_build_name=%last_build_name%\last_test_build.exe
)

set new_build_name=e:\amigo_browser_38\%AMIGO_BROWSER_BRANCH%\out\amigo_setup_*.exe

: replace older
if exist %last_build_name% (
  del /f /q %last_build_name%
)

if exist %new_build_name% (
: copy new
  copy /B /Y e:\amigo_browser_38\%AMIGO_BROWSER_BRANCH%\out\amigo_setup_*.exe %last_build_name%
)
  
: for debug
f:
cd f:\Projects\Amigo\AmigoDebugAll\amigo_browser_38\
: