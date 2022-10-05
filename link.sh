#!/usr/bin/env bash

echo "Linking neovim"
ln -s $(pwd)/.config/nvim ~/.config/nvim

# echo "Linking tmux"
# ln -s $(pwd)/tmux.conf ~/.tmux.conf

echo "Linking zshrc"
ln -s $(pwd)/.zshrc ~/.zshrc
