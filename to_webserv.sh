#!/bin/bash
#  Copy project from utils to www

echo Copy project from utils to www
# Set curr directory
old=$PWD
echo CURR DIR: $(pwd)
cd "$(dirname "$BASH_SOURCE[0]")" 
echo CHANGE TO CURR DIR: $(pwd)

# Fetch form remotes
git pull

# Copy to www
cp -r second /var/www/html/second

# Revert old directory
cd $old
echo CURR DIR: $(pwd)



