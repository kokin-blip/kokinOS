# KokinOS

KokinOS is a Bazzite-derived Fedora Atomic KDE image for gaming, programming, and everyday use. It keeps the Bazzite gaming foundation and adds KokinOS branding, developer defaults, and a polished KDE Plasma first impression.

KokinOS is a downstream custom image, not an independent Linux distribution from scratch.

## Images

| Image | Base | Use |
| --- | --- | --- |
| `ghcr.io/kokin-blip/kokinos:stable` | `ghcr.io/ublue-os/bazzite:stable` | AMD and Intel systems |
| `ghcr.io/kokin-blip/kokinos-nvidia:stable` | `ghcr.io/ublue-os/bazzite-nvidia-open:stable` | NVIDIA systems |

## Build

```bash
just build kokinos stable ghcr.io/ublue-os/bazzite:stable
just build kokinos-nvidia stable ghcr.io/ublue-os/bazzite-nvidia-open:stable
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

## Sources

KokinOS is built with the Universal Blue image-template and derives from Bazzite:

- https://github.com/ublue-os/image-template
- https://docs.bazzite.gg/
- https://docs.bazzite.gg/Advanced/creating_custom_image/
