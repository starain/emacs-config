#!/bin/bash

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MAGIC_ANCHOR="Setup by setup_emacs.sh"

DEFAULT_CONFIG_FILE="$HOME/.emacs"

install() {
    # sync all git submodule
    cd $CONFIG_DIR
    git submodule update --init --recursive

    echo ";; BEGIN: $MAGIC_ANCHOR" >> $DEFAULT_CONFIG_FILE
    echo "(load-file \"$CONFIG_DIR/start.el\")" >> $DEFAULT_CONFIG_FILE
    echo ";; END: $MAGIC_ANCHOR" >> $DEFAULT_CONFIG_FILE
}

uninstall() {
    echo "Removing config from $DEFAULT_CONFIG_FILE"

    TMP_FILE=$(mktemp)
    sed "/$MAGIC_ANCHOR/,/$MAGIC_ANCHOR/d" $DEFAULT_CONFIG_FILE > $TMP_FILE && mv $TMP_FILE $DEFAULT_CONFIG_FILE
}

case "$1" in
'install')
    install
    ;;
'uninstall')
    uninstall
    ;;
*)
    echo "Usage ${BASH_SOURCE[0]} install/uninstall"
    exit
    ;;
esac
