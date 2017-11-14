rem process
set branch="amigo_3.2"

cmd /c git stash
cmd /c git fetch origin
cmd /c git checkout %branch%
cmd /c git pull --rebase origin %BRANCH%

call am_generate_build_debug