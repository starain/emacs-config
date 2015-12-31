#!/bin/bash

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MAGIC_ANCHOR="Setup by setup_emacs.sh"

install() {
    # sync all git submodule
    git submodule update --init --recursive

    # helm has special requirement for setting up
    cd $CONFIG_DIR/thirdparty/helm
    make
    cd $CONFIG_DIR

    echo ";; BEGIN: $MAGIC_ANCHOR" >> ~/.emacs
    echo "(load-file \"$CONFIG_DIR/start.el\")" >> ~/.emacs
    echo ";; END: $MAGIC_ANCHOR" >> ~/.emacs
}

uninstall() {
    echo "Removing config from $f"

    TMP_FILE=$(mktemp)
    sed "/$MAGIC_ANCHOR/,/$MAGIC_ANCHOR/d" ~/.emacs > $TMP_FILE && mv $TMP_FILE ~/.emacs
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
