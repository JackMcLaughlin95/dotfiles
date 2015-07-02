#!/bin/bash

# Symlink dotfiles

FILES="$(ls -A -I README.md -I init.sh)"

for f in $FILES
do
  `ln -s ${f} ~/${f}`
done

# Further init... git config
git config --global init.templatedir '~/.git_template'
git config --global core.excludesfile ~/.gitignore_global

git config --global user.email "nathan@nathansplace.co.uk"
git config --global user.name "NathanG"

