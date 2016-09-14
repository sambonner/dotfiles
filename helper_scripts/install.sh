#!/bin/bash
cd
cp dotfiles/.vimrc .vimrc
cp -R dotfiles/.vim ~/.vim
sudo apt-get install exuberant-ctags x11-xserver-utils
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle
vim +PluginInstall +qall
cd ~/.vim/bundle/tagbar-phpctags.vim/ && make

