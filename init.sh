#!/bin/bash

# Symlink dotfiles

FILES="$(ls -A -1 | grep -viw .git | grep -viw README.md | grep -viw init.sh)"
SRC_DIR="$(pwd)"

cd ~

for f in $FILES
do
  ln -sf $SRC_DIR/$f $f
done

# Further init... git config
git config --global init.templatedir '~/.git_template'
git config --global core.excludesfile ~/.gitignore_global

