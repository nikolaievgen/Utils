
#!/bin/bash
# Copy vim vimrc to utils and push

echo Copy vim vimrc to utils and push

# Set curr directory
old=$PWD
echo CURR DIR: $(pwd)
cd "$(dirname "$BASH_SOURCE[0]")" 
echo CHANGE TO CURR DIR: $(pwd)

# Fetch form remotes
git pull

# Copy to vimrc
cp ~/.vim/vimrc vimrc_dev  

# Commit and Push to remote
git add ./vimrc_dev
git commit -m"Vimrc modify"
git push

# Revert old directory
cd $old
echo CURR DIR: $(pwd)



