#!/bin/bash
# Copy dev vimrc from utils to vim

echo  Copy dev vimrc from utils to vim
# Set curr directory
old=$PWD
echo CURR DIR: $(pwd)
cd "$(dirname "$BASH_SOURCE[0]")" 
echo CHANGE TO CURR DIR: $(pwd)

# Fetch form remotes
git pull

# Copy to vimrc
cp vimrc_dev ~/.vim/vimrc 

# Revert old directory
cd $old
echo CURR DIR: $(pwd)



