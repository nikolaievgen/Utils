set DEPOT_TOOLS_WIN_TOOLCHAIN=0

call gclient runhooks
CALL gn gen out/Release --args="is_official_build=true is_debug=false target_cpu = ""x86""" --ide=vs