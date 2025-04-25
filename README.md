# [1] General information
This is an almost identical version of the NixOS configuration that I use. It is made for single-user use on a desktop or laptop system. \
It does not use Flakes, but does make use of Home Manager. Since March of 2025, this now assumes an installation pulling packages only from unstable. \
It is an overhaul of my previous NixOS configuration, which can still be found [here](https://github.com/Atemo-C/OLD-NixOS-Configuration). \
If you want to use this configuration (or rather, a version of it), on your own system, it is highly recommended that you read what each module does and edit them if needed. \
&nbsp;
# [2] To do when using this configuration

## [2.1] Name.
In `User/Name.nix`, you can set your user's name and title at `userName` and `userTitle`. They will automatically be applied to the modules that need them; They will use the `${config.userName}` and `${config.userTitle}` values using the `User/Name-module.nix` module.

## [2.2] Hostname.
In `Networking.nix`, you can set your computer's name on the network at `networking.hostName`.

## [2.3] NixOS state version.
If you have installed a NixOS version higher/lower than the value currently used here (`24.11`), you must change the value of `system.stateVersion` in `Nix-settings.nix`. After that, you should never need to change it, unless you install NixOS from scratch with a different (higher) version. You do not have to nor should change this number if you keep the same installation, even when upgrading NixOS version.

## [2.4] Graphics drivers, etc.
There are other modules imported in `configuration.nix` that you may wish to comment/uncommend, and individually tweak. Be sure to check relevant ones out.

## [2.5] Home Manager version
The `User/Home-manager.nix` module fetches the tarball of the desired Home Manager version, which should ideally be the same version as the NixOS version currently running. In it, if needed, change the `master` part in `"https://github.com/nix-community/home-manager/archive/master.tar.gz"` to the appropriate version, like `release-24.11`.

## [2.6] Flatpaks with Flathub
Currently, the Flathub Flatpak repository cannot be declaratively defined in NixOS nor Home Manager without using a custom Nix Flake. As such, you have to manually add it with a shell command after installation. If you are using the FISH shell, there should already be an abbreviation to do so, being the following:
`enable-flathub`

# [3] Use cases and feature implementation

## [3.1] Targeted use case
- Single user
- Personal computing
- Desktops and laptops

## [3.2] Not yet implemented or tested, including but not limited to
- Secure Boot
- Accessibility
- Touchscreen
- Non-offload Nvidia PRIME
- Remote desktop
- Snap packaging system
- Computers with:
	- A non-x86_64 (AMD64) CPU architecture
	- No adequate GPU acceleration (Hyprland)
	- Hybrid GPU setup (NVIDIA PRIME, etc)
	- Less than 2 GiB of RAM (Swap can be heavily used with less than 4, 8-16 GiB is recommended)
	- Less than 64 GiB of storage (Some Nix storage optimizations are already enabled) \
&nbsp;

# [4] Other NixOS resources
Help is available in:
- The configuration.nix(5) man page
- The on-device manual by running the `nixos-help` command
- The online manual \
	[Online manual](https://nixos.org/manual/nixos/stable/index.html)
- The NixOS Wiki \
  	[NixOS Wiki](https://wiki.nixos.org)
- The Nix.dev documentation for the Nix ecosystem. \
	[Nix.dev](https://nix.dev/)

A searchable list of available packages for NixOS can be found here. \
[NixOS package search](https://search.nixos.org/packages) \
Alternatively, we can use `nix search` in a terminal.

A searchable list of available options for NixOS can be found here. \
[NixOS options search](https://search.nixos.org/options)

A (slow) list of available options for Home Manager can be found here. \
[Home Manager search](https://nix-community.github.io/home-manager/options.xhtml) \
&nbsp;
