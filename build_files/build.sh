#!/bin/bash

set -ouex pipefail
### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

#CachyOS Kernel
dnf copr enable bieszczaders/kernel-cachyos
dnf install -y kernel-cachyos

setsebool -P domain_kernel_load_modules on

dnf copr enable bieszczaders/kernel-cachyos-addons
dnf swap zram-generator-defaults cachyos-settings
dracut -f
#Packages
dnf install -y tmux
dnf install -y zed
dnf install -y steam
dnf install -y podman-compose
dnf install -y gnome-tweaks



dnf copr disable bieszczaders/kernel-cachyos
dnf copr disable bieszczaders/kernel-cachyos-addons
# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
