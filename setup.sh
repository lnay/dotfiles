#!/bin/sh

REPO_DIR=`pwd`

STOW_SOURCE=$REPO_DIR/home_dir/
STOW_TARGET=~/

# Create directories necessary in ~/.config/
(cd $STOW_SOURCE ; echo .config/*/) | (cd ~ ; xargs mkdir -p)

stow . --verbose --adopt -d $STOW_SOURCE -t $STOW_TARGET
