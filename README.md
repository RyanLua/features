# Rojo Dev Container Feature

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/RyanLua/features?quickstart=1)

A dev container feature that installs [Rojo](https://rojo.space/) and optionally [Aftman](https://github.com/LPGhatguy/aftman) for toolchain management. Useful for developing Roblox experiences using [dev container supported tools](https://containers.dev/supporting.html) such as [GitHub Codespaces](https://github.com/features/codespaces).

## Usage

To use this feature, add the following to your `devcontainer.json` file:

```json
"features": {
	"ghcr.io/ryanlua/features/rojo:latest": {
		"version": "latest",
		"installAftman": true
	}
}
```

Learn more about this feature by seeing [feature's README](https://github.com/RyanLua/features/tree/main/src/rojo).

## Template

For a Roblox template using this feature, see https://github.com/RyanLua/templates.
