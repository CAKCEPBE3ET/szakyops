#!/usr/bin/env bash

# ==============================================================================
#  Project:     Szakyops 
#  File:        uninstall.sh
#  Description: Uninstaller of Szakyops
#  Author:      Stephen/Szaky (info@szakysoft.hu)
#  Website:     https://szakysoft.hu
#  Version:     1.1.1
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

#Created v1.1.0
echo "Removing scheduled cron jobs..."
for target_user in root "${SUDO_USER:-}"; do
    [ -z "$target_user" ] && continue
    tmp_cron=$(mktemp)
    crontab -u "$target_user" -l 2>/dev/null | grep -v -E "/opt/szakyops/szakyops|run_szakysave" > "$tmp_cron" || true #Modified v1.1.1
    if [ -s "$tmp_cron" ]; then
        crontab -u "$target_user" "$tmp_cron"
    else
        crontab -u "$target_user" -r 2>/dev/null || true
    fi
    rm -f "$tmp_cron"
done

echo "Removing sudoers rules created by szakyops..."
rm -f /etc/sudoers.d/szakyops-shutdown
###############

echo "Szakyops has been successfully uninstalled."
