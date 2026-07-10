#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### KokinOS developer defaults
dnf5 install -y \
    cargo \
    gcc \
    gh \
    git \
    golang \
    just \
    nodejs \
    python3-pip \
    rust \
    tmux

### Branding
if [[ -f /usr/lib/os-release ]]; then
    cp -f /usr/lib/os-release /usr/lib/kokinos/os-release.base
    sed -i \
        -e 's/^NAME=.*/NAME="KokinOS"/' \
        -e 's/^PRETTY_NAME=.*/PRETTY_NAME="KokinOS Beta"/' \
        -e 's/^VARIANT=.*/VARIANT="KDE Gaming Developer Edition"/' \
        -e 's/^VARIANT_ID=.*/VARIANT_ID=kokinos-kde/' \
        -e 's|^HOME_URL=.*|HOME_URL="https://github.com/kokin-blip/kokinOS"|' \
        -e 's|^DOCUMENTATION_URL=.*|DOCUMENTATION_URL="https://github.com/kokin-blip/kokinOS/tree/main/docs"|' \
        -e 's|^BUG_REPORT_URL=.*|BUG_REPORT_URL="https://github.com/kokin-blip/kokinOS/issues"|' \
        /usr/lib/os-release
fi

if command -v plymouth-set-default-theme >/dev/null 2>&1; then
    plymouth-set-default-theme kokinos || true
fi

systemctl enable podman.socket
