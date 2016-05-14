#!/bin/bash
# Automate installation of Atom plugins

# Needed for linter and autopep8
sudo pip install pep8
sudo pip install flake8

# Python
apm i linter
# apm linter-python-pep8
apm i linter-pep8
apm i linter-python-flake8
apm i autocomplete-python
apm i python-autopep8
apm i python-tools

apm i color-picker
apm i file-icons
apm i file-type-icons
apm i language-lua
apm i minimap
apm i minimap-cursorline
apm i minimap-pigments
apm i pigments

# Themes
apm i atom-materials-syntax
apm i atom-material-syntax-dark
apm i atom-material-ui

# Installing the config file
if [ -f ~/.atom/config.cson ]; then
    echo "Saving config.cson as config.cson.old"
    mv ~/.atom/config.cson ~/.atom/config.cson.old
fi
echo "Installing Atom config as ~/.atom/config.cson"
cp ~/.atom/config.cson ~/.atom/config.cson.old
n
