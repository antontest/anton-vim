#! /bin/bash
# Name : install.sh
# Func : install .vimrs
# Time : 2015-10-11 19:52:38

test -f ~/.vimrc && echo ".vimrc already exist!" && exit 1

test -f `pwd`/.vimrc && ln `pwd`/.vimrc ~/.vimrc && echo ".vimrc install
success!" && exit 0
echo ".vimrc install failed!" && exit 1
