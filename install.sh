#!/usr/bin/env bash

# ==============================================================================
#  Project:     Szakyops 
#  File:        install.sh
#  Description: Installer of Szakyops
#  Author:      Stephen Szaky (info@szakysoft.hu)
#  Website:     https://szakysoft.hu
#  Version:     1.0.2
#  License:     MIT
# ==============================================================================

set -e

if [[ $EUID -ne 0 ]]; then
    echo "This installer must be run as root."
    echo "Use: sudo ./install.sh"
    exit 1
fi

if [[ ! -d "$(dirname "$(realpath "$0")")/modules" ]]; then
    echo "Downloading source files from GitHub..."
    TMP_REPO="/tmp/szakyops_git_clean_repo"
    rm -rf "$TMP_REPO"
    git clone --depth 1 https://github.com/CAKCEPBE3ET/Szakyops.git "$TMP_REPO" > /dev/null 2>&1
    SOURCE_DIR="$TMP_REPO"
    IS_REMOTE=true
else
    SOURCE_DIR=$(dirname "$(realpath "$0")")
    IS_REMOTE=false
fi

INSTALL_DIR="/opt/szakyops"
BIN_LINK="/usr/local/bin/szakyops"

echo "Installing szakyops toolset..."

if [[ -d "$INSTALL_DIR" ]]; then
    rm -rf "$INSTALL_DIR"
fi

mkdir -p "$INSTALL_DIR"

cp -a "$SOURCE_DIR/." "$INSTALL_DIR/"

rm -rf "$INSTALL_DIR/.git"

if [[ -f "$INSTALL_DIR/szakyops" ]]; then
    chmod 755 "$INSTALL_DIR/szakyops"
fi
if [[ -f "$INSTALL_DIR/uninstall.sh" ]]; then
    chmod 755 "$INSTALL_DIR/uninstall.sh"
fi
if [[ -d "$INSTALL_DIR/modules" ]]; then
    chmod 755 "$INSTALL_DIR/modules"/*
fi

ln -sf "$INSTALL_DIR/szakyops" "$BIN_LINK"

echo "Done installing to $INSTALL_DIR!"

if [ "$IS_REMOTE" = true ]; then
    echo "Cleaning up remote installer temporary files..."
    rm -rf "$SOURCE_DIR"
    rm -f /tmp/szakyops_install.sh
else
    if [[ "$SOURCE_DIR" != "/" && "$SOURCE_DIR" != "$INSTALL_DIR" && "$SOURCE_DIR" != "/tmp" ]]; then
        echo "Cleaning up local installer repository..."
        rm -rf "$SOURCE_DIR"
    fi
fi

echo
echo "You can now run:"
echo "  sudo szakyops"
