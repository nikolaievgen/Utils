set GYP_DEFINES=component=shared_library 
set GYP_GENERATORS=msvs-ninja,ninja
:set GYP_GENERATORS=ninja,msvs
set DEPOT_TOOLS_WIN_TOOLCHAIN=0
set GYP_MSVS_VERSION=2013

call gclient runhooks
:call gclient runhooks --force

ninja -C src\out\Debug chrome
