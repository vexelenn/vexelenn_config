#!/bin/bash
# Array of files to link
files=( ".tmux.conf" ".vimrc" ".zshrc" )

# Location of your dotfiles repository
repo="$HOME/.vexelenn_config/"

# Change to the dotfiles directory
cd $repo

for file in "${files[@]}"; do
   # If file exists in home directory, rename it to backup
   if [ -f "$HOME/$file" ]; then
     mv $HOME/$file $HOME/$file.bak
   fi
   # Create symbolic link to file in repository
   ln -s $repo/$file $HOME/$file
   echo "Installed $file"
done
