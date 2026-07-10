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

For Apple Silicon VMware Fusion testing, run the same workflow with:

- `platform`: `arm64`
- `image`: `kokinos-mac`
- `disk_type`: `anaconda-iso`

The Mac test image is based on Fedora Kinoite ARM64 rather than Bazzite, because VMware Fusion on Apple Silicon runs ARM64 guests and cannot boot the x86_64 Bazzite-based KokinOS images.

## VMware Fusion

VMware Fusion is a good first VM target for KokinOS smoke testing.

1. Run the `Build disk images` workflow from GitHub Actions.
2. Choose `amd64` for a normal x86_64 VM, or `arm64` with `kokinos-mac` on Apple Silicon.
3. Download the `anaconda-iso` artifact for the image you selected.
4. Create a new Linux VM in VMware Fusion and attach the KokinOS ISO.
5. Boot the VM, install KokinOS, then reboot into the installed system.

Use the standard `kokinos` ISO for VMware Fusion first. The `kokinos-nvidia` image is for NVIDIA hardware testing and is not useful inside a typical VMware virtual GPU setup.

VM testing proves that the installer, boot, login, and desktop defaults work. It does not replace hardware testing for Steam/Proton performance, NVIDIA drivers, controllers, suspend/resume, or real GPU behavior.

## Docker Pull Troubleshooting

KokinOS images are bootable OS container images. Docker can pull them for inspection, but Docker is not the supported install or boot path. Use `bootc switch` or the ISO artifacts for actual installs.

If Docker reports `failed to unpack image on snapshotter overlayfs: mismatched image rootfs and manifest layers`, first clear the partial local copy and pull the current digest:

```bash
docker image rm ghcr.io/kokin-blip/kokinos:stable || true
docker pull ghcr.io/kokin-blip/kokinos@sha256:118f9a4d9a5d21c9fb52d23c264b86fe1bfc7b122084ea7dbf5030d03ba4e95b
```

For NVIDIA:

```bash
docker image rm ghcr.io/kokin-blip/kokinos-nvidia:stable || true
docker pull ghcr.io/kokin-blip/kokinos-nvidia@sha256:0fc44d86ee436f51d5713e2543b75969d9d4432d4ff83c5f1271296a3acc4041
```

If the error persists, verify the published metadata before debugging Docker storage:

```bash
skopeo inspect --raw docker://ghcr.io/kokin-blip/kokinos:stable | jq '.layers | length'
skopeo inspect --config docker://ghcr.io/kokin-blip/kokinos:stable | jq '.rootfs.diff_ids | length'
```

Both commands should print the same number. If they match, the registry image is structurally valid and the Docker error is local snapshotter/cache state.

## Rollback

If a booted deployment has problems:

```bash
sudo bootc rollback
systemctl reboot
```
