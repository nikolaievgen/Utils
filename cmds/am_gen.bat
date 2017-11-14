set DEPOT_TOOLS_WIN_TOOLCHAIN=0

call gclient runhooks
gn gen out/Debug --args="is_official_build=false is_debug=true target_cpu = ""x86""" --ide=vs
:gn gen out/Release --args="is_official_build=false is_debug=false is_component_build=false target_cpu = ""x86""" --ide=vs
