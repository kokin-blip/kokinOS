# KokinOS

KokinOS is a Bazzite-derived Fedora Atomic KDE Linux distribution for gaming, programming, and everyday use. It keeps the Bazzite gaming foundation and adds KokinOS branding, developer defaults, and a polished KDE Plasma first impression.

V1 is a downstream distribution built from Fedora Atomic, Universal Blue, and Bazzite. The long-term project can become more independent over time, but starting from a strong base keeps the first public builds usable for gaming and daily-driver work.

## Why This Repo Says Image

KokinOS is the distribution. Container images and ISO files are the release artifacts.

Fedora Atomic and bootc-based systems are built from bootable OCI container images. That means `ghcr.io/kokin-blip/kokinos:stable` is not a normal app container; it is the OS payload used by `bootc`, the installer ISO, rollback, and updates.

## Images

| Image | Base | Use |
| --- | --- | --- |
| `ghcr.io/kokin-blip/kokinos:stable` | `ghcr.io/ublue-os/bazzite:stable` | AMD and Intel systems |
| `ghcr.io/kokin-blip/kokinos-nvidia:stable` | `ghcr.io/ublue-os/bazzite-nvidia-open:stable` | NVIDIA systems |
| `ghcr.io/kokin-blip/kokinos-mac:stable` | `quay.io/fedora/fedora-kinoite:42` | Apple Silicon VMware Fusion testing |

`kokinos-mac` is a test flavor for ARM64 Macs. It uses Fedora Kinoite instead of Bazzite because the Bazzite base image is currently x86_64-only in this repo's build path.

## Build

```bash
just build kokinos stable ghcr.io/ublue-os/bazzite:stable
just build kokinos-nvidia stable ghcr.io/ublue-os/bazzite-nvidia-open:stable
just build kokinos-mac stable quay.io/fedora/fedora-kinoite:42
```

Published builds are created by GitHub Actions and pushed to GitHub Container Registry.

## Signing

Container signing is wired into `.github/workflows/build.yml`. Before public releases, generate a cosign key pair and add the private key as the `SIGNING_SECRET` repository secret:

```bash
COSIGN_PASSWORD="" cosign generate-key-pair
gh secret set SIGNING_SECRET < cosign.key
```

Commit `cosign.pub`. Never commit `cosign.key`.

## Install And Testing

See [docs/install.md](docs/install.md), [docs/testing.md](docs/testing.md), and [docs/branding.md](docs/branding.md).

For Docker snapshotter errors such as `mismatched image rootfs and manifest layers`, use the cleanup and digest-pull commands in [docs/install.md](docs/install.md#docker-pull-troubleshooting).

## Sources

KokinOS is built with the Universal Blue image-template and derives from Bazzite:

- https://github.com/ublue-os/image-template
- https://docs.bazzite.gg/
- https://docs.bazzite.gg/Advanced/creating_custom_image/
