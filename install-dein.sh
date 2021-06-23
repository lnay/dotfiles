#!/bin/sh

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > dein-installer.sh
# For example, we just use `~/.cache/dein` as installation directory
sh ./dein-installer.sh ~/.cache/dein
rm ./dein-installer.sh

