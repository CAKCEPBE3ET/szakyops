#!/usr/bin/env bash

# ==============================================================================
#  Project:     Szakyops 
#  File:        uninstall.sh
#  Description: Uninstaller of Szakyops
#  Author:      Stephen Szaky (info@szakysoft.hu)
#  Website:     https://szakysoft.hu
#  Version:     1.0.2
#  License:     MIT
# ==============================================================================


set -e

if [[ $EUID -ne 0 ]]; then
    echo "This uninstaller must be run as root."
    echo "Use: sudo ./uninstall.sh"
    exit 1
fi

echo "Removing szakyops toolset..."

rm -f /usr/local/bin/szakyops

rm -rf /opt/szakyops

echo "Szakyops has been successfully uninstalled."
