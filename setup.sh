#!/bin/bash

set -eu

if [[ $# -ne 1 ]]; then
    echo -e "###########################"
    echo -e "# Usage: bash $(basename $0) <system>"
    echo -e "# This script creates symlinks for your dotilfes"
    echo -e "############################\n"
    echo -e "For <system> choose between 'osx' and 'ubuntu'\n"
    exit
fi

system=$1

########## Variables

olddir="$HOME/.dotfiles_old/"             # old dotfiles backup directory
files=$(ls ./$system)                     # list of files/folders to symlink in homedir

##########

# create dotfiles_old
echo -n "Creating $olddir for backup of any existing dotfiles in $HOME ..."
mkdir -p "$olddir"
echo "done"

# move any existing dotfiles in $HOME to dotfiles_old directory, then create symlinks from $HOME to any files here
for file in $files; do
    echo "Moving any existing dotfiles from $HOME to $olddir"
    if [[ -e "$HOME/.$file" ]]; then
        mv "$HOME/.$file" "$olddir"
    fi
    echo "Symlinking $file to $HOME"
    ln -sf "$HOME/.dotfiles/$system/$file" "$HOME/.$file"
done

mkdir -p "$HOME/.vim/un"
mkdir -p "$HOME/.vim/tmp"
mkdir -p "$HOME/.vim/backup"
mkdir -p "$HOME/.local/src"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/pandoc"

exit
