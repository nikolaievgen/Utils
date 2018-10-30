# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# Transfer files
# Add this to .bashrc or its equivalent 
transfer() {
  if [ $# -eq 0 ]; then 
    echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; 
    return 1; fi 
    tmpfile=$( mktemp -t transferXXX ); 
  if tty -s; then 
    basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g');
    curl --progress-bar --upload-file "$1" "https://t.bk.ru/$basefile" >> $tmpfile;
  else
    curl --progress-bar--upload-file "-" "https://t.bk.ru/$1" >> $tmpfile ;
  fi; 
  cat $tmpfile;
  rm -f $tmpfile; 
}

alias mc='LANG=en_EN.UTF-8 . /usr/libexec/mc/mc-wrapper.sh'
 
export VISUAL=vim
export EDITOR="$VISUAL"

alias ll='ls -la --color=auto'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
