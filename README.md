# Rojo Dev Container Feature

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/RyanLua/features?quickstart=1)

This is a feature for Rojo which allows you to use Rojo in dev containers. This is useful for developing Roblox experiences using tools such as [GitHub Codespaces](https://github.com/features/codespaces).

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
