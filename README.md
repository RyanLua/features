# Rojo Dev Container Feature

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/RyanLua/features?quickstart=1)

A dev container feature that installs [Rojo](https://rojo.space/) and optionally [Aftman](https://github.com/LPGhatguy/aftman) for toolchain management. Useful for developing Roblox experiences using [dev container supported tools](https://containers.dev/supporting.html) such as [GitHub Codespaces](https://github.com/features/codespaces).

## Known issues and remarks

### A device running Roblox Studio is needed to sync

You need a device that can run Roblox Studio to be able to sync code and publish places. This just allows you to use any device to edit code and a bit more. You can still build models and places using Rojo as well as download them.

### Rojo can't install the Roblox Studio plugin

Rojo can't install the Rojo plugin for Roblox Studio since it is running in the cloud and does not have access to your device. You will to install it manually from [GitHub](https://github.com/rojo-rbx/rojo/releases) or the [Roblox Creator Store](https://create.roblox.com/store/asset/13916111004).

### Port needs to be 80 on Roblox Studio

Because of how GitHub Codespaces works, if you want to sync to Roblox Studio in a codespace, you need to set the port to `80` in the plugin even though it shows it is forwarded as `34872`.

You also need to remove the `https://` at the beginning and the `/` end of the forwarded address. `https://your-project-34872.app.github.dev/` turns into `your-project-34872.app.github.dev`.

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

Learn more about this feature by seeing the [feature's README](https://github.com/RyanLua/features/tree/main/src/rojo).

## Template

For a Roblox template using this feature, see https://github.com/RyanLua/templates.
