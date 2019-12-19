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

 
export VISUAL=vim
export EDITOR="$VISUAL"

alias mc='LANG=en_EN.UTF-8 . /usr/libexec/mc/mc-wrapper.sh'
alias ll='ls -la --color=auto'
alias ctagsd='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q'
alias g++11="g++ -std=c++11"
alias ag='ag --path-to-ignore=/home/n.orgeev/proj/working/base/.ignore'
alias python3="/opt/rh/rh-python36/root/usr/bin/python3.6"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export JAVA_HOME=/usr/java/jdk1.8.0_144
export PATH=$JAVA_HOME/bin:$PATH

# Ryby & tmuxinator
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"
# source ~/.bin/tmuxinator.bash

alias sudo="/bin/sudo"
export PATH=/opt/rh/devtoolset-7/root/bin/:$PATH
