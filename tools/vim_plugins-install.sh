#!/bin/bash

echo "[*] Moving to .vim/bundle/ directory"
cd ~/.vim/bundle/

echo "[*] Cloning nerdtree from git"
git clone https://github.com/scrooloose/nerdtree.git

echo "[*] Cloning YouCompleteMe from git"
git clone https://github.com/Valloric/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive
echo "[*] Building YouCompleteMe"
./install.py -clang-completer
cd ~/.vim/bundle/

echo "[*] Installing Python-mode"
git clone https://github.com/klen/python-mode.git

echo "[*] Installing lightline"
git clone https://github.com/itchyny/lightline.vim
