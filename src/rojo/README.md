
# Rojo (rojo)

Installs the provided version of Rojo, as well as Aftman and dependencies.

## Example Usage

```json
"features": {
    "ghcr.io/RyanLua/features/rojo:0": {}
}
```

## Base Image Requirements

**Important**: This feature requires Ubuntu 22.04+ or equivalent due to GLIBC compatibility requirements. 

When using the `rokit` toolchain manager (default), ensure your base image supports GLIBC 2.33+:

```json
{
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu-22.04",
  "features": {
    "ghcr.io/RyanLua/features/rojo:0": {}
  }
}
```

For older base images, use `aftman` or `foreman` instead:

```json
"features": {
    "ghcr.io/RyanLua/features/rojo:0": {
        "toolchainManager": "aftman"
    }
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Select or enter a version of Rojo to install. | string | latest |
| toolchainManager | Select a toolchain manager to install. | string | rokit |

## Customizations

### VS Code Extensions

- `evaera.vscode-rojo`



## OS Support

This Feature should work on recent versions of Debian/Ubuntu-based distributions with the `apt` package manager installed.

`bash` is required to execute the `install.sh` script.

`GLIBC_2.33`, `GLIBC_2.32`, or `GLIBC_2.34` are required to install [Aftman](https://github.com/LPGhatguy/aftman).

---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/RyanLua/features/blob/main/src/rojo/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
