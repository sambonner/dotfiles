#!/bin/bash
cd
cp -R dotfiles/.vim ~/.vim
sudo apt-get install exuberant-ctags x11-xserver-utils
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle
vim +PluginInstall +qall


