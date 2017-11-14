
@echo off

:: Pull && merge with arg branch && build project

::echo.Pull ^&^& Merge
:: goto:eof
::
echo.Pull ^&^& Merge with arg branch ^&^& build project
set branch=%1

:: Pull
call git pull
if %ERRORLEVEL% GEQ 1 (
  echo.Pull error!
  goto:eof
  )

:: Merge
call git merge origin/%branch%
if %ERRORLEVEL% GEQ 1 (
  echo.Merge error!
  goto:eof
  )

:: Build
call ./am_build.bat

