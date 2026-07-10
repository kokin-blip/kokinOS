# KokinOS Install Notes

KokinOS beta images are published to GitHub Container Registry.

## Rebase From An Existing Fedora Atomic/Bazzite System

AMD/Intel:

```bash
sudo bootc switch ghcr.io/kokin-blip/kokinos:stable
systemctl reboot
```

NVIDIA:

```bash
sudo bootc switch ghcr.io/kokin-blip/kokinos-nvidia:stable
systemctl reboot
```

## ISO Artifacts

Run the `Build disk images` workflow from GitHub Actions and choose `amd64`. The workflow builds QCOW2 and Anaconda ISO artifacts for both KokinOS images.

Use the standard image for AMD/Intel systems and the NVIDIA image for NVIDIA systems.

## Rollback

If a booted deployment has problems:

```bash
sudo bootc rollback
systemctl reboot
```
