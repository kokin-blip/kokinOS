# KokinOS Test Plan

## CI

- Container image builds successfully.
- Both `kokinos` and `kokinos-nvidia` images publish to GHCR.
- Signing succeeds after `SIGNING_SECRET` is configured.
- Disk image workflow produces QCOW2 and Anaconda ISO artifacts.

## VM

- VMware Fusion boots the `kokinos` Anaconda ISO.
- Apple Silicon VMware Fusion boots the `kokinos-mac` ARM64 Anaconda ISO.
- ISO boots and installs.
- Login screen appears.
- KDE Plasma starts.
- KokinOS wallpaper, icon theme, welcome app, and Plymouth theme are present.
- Flatpak app management works.
- `bootc rollback` works after an update.

## Hardware

- AMD GPU desktop or laptop.
- Intel iGPU laptop.
- NVIDIA desktop or laptop using `kokinos-nvidia`.

## Workflows

- Steam launches.
- A Proton game launches.
- Lutris or Heroic path works.
- MangoHud works.
- Controller input works.
- Distrobox creates and enters a development container.
- Podman runs a container.
