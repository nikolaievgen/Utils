
#!/bin/bash
# Copy web project to utils and push

echo Copy web project to utils and push

# Set curr directory
old=$PWD
echo CURR DIR: $(pwd)
cd "$(dirname "$BASH_SOURCE[0]")" 
echo CHANGE TO CURR DIR: $(pwd)

# Fetch form remotes
git pull

# Copy to vimrc
cp -r /var/www/html/second second

# Commit and Push to remote
git add ./second
git commit -m"Web project modify"
git push

# Revert old directory
cd $old
echo CURR DIR: $(pwd)



