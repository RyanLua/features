
# Rojo (rojo)

Installs the provided version of Rojo, a toolchain manager and dependencies.

## Example Usage

```json
"features": {
    "ghcr.io/RyanLua/features/rojo:0": {}
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

This Feature should work on recent versions of Debian/Ubuntu-based distributions with the `apt` package manager installed. Debian `trixie` (or `debian-13`) or later is required because of the `GLIBC_2.39` requirement for Rojo.

`bash` is required to execute the `install.sh` script.

`GLIBC_2.33`, `GLIBC_2.32`, or `GLIBC_2.34` are required to install [Aftman](https://github.com/LPGhatguy/aftman) and [Rokit](https://github.com/rojo-rbx/rokit). `GLIBC_2.39` is required to install [Rojo](https://github.com/rojo-rbx/rojo).

---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/RyanLua/features/blob/main/src/rojo/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
