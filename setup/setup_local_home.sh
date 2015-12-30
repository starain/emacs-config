#!/bin/bash

# Setup environment
if [ $# -lt 0 ]
then
    echo "Usage ${BASH_SOURCE[0]} [environment_sub_dir]"
    exit
fi

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_DIR="$CONFIG_DIR"
if [ $# -eq 1 ]
then
    ENV_DIR_NAME="$1"
    ENV_DIR="$CONFIG_DIR/$ENV_DIR_NAME"
fi

# sync all git submodule
git submodule update --init --recursive

# helm has special requirement for setting up
cd $CONFIG_DIR/thirdparty/helm
make
cd $CONFIG_DIR

MAGIC_ANCHOR="Setup by setup_local_home.sh"

echo ";; BEGIN: $MAGIC_ANCHOR" >> ~/.emacs
echo "(load-file \"$ENV_DIR/start.el\")" >> ~/.emacs
echo ";; END: $MAGIC_ANCHOR" >> ~/.emacs
