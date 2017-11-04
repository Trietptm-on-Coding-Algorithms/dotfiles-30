#!/bin/bash
# Automate installation of Atom plugins

# Needed for linter and autopep8
# (for security, use --user to install as user)
pip install pep8 --user
pip install flake8 --user

# Python Plugins
apm i linter linter-pep8 autocomplete-python python-autopep8 python-tools

# Misc Plugins
apm i color-picker file-type-icons language-lua minimap minimap-cursorline minimap-pigments pigments

# Themes
apm i atom-materials-syntax atom-material-syntax-dark atom-material-ui

# Installing the config file
if [ -f ~/.atom/config.cson ]; then
    echo "[*] Creating backup of old Atom config file."
    mv ~/.atom/config.cson ~/.atom/config.cson.old
fi
echo "[*] Installing Atom config."
cp atom-config.cson ~/.atom/config.cson
