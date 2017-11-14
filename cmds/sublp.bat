rem Butch file to run sublime text editor
rem It open current directory

@echo off

set cur_dir=%cd%

call "r:\Program Files\Sublime Text 3\subl.exe" "%cur_dir%"
