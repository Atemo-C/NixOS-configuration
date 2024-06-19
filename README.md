# \[NEXT\] - NixOS configuration
This is an overhaul of my existing NixOS configuration. I plan to take my time to complete and tweak it before eventually transitioning over to it. \

My current NixOS configuration can be found here: \
https://github.com/Atemo-C/NixOS-Configuration/

---

# [1] General information
This is an almost identical version of the NixOS configuration that I use. It is made for single-user use on a desktop or laptop system. \
It does not use Flakes and never, ever will, but it does make use of Home Manager and some unstable packages whilst on a stable version.

If you want to use this configuration (or rather, a version of it), on your own system, it is hightly recommended that you read what each module does and edit them if needed. \
&nbsp;
# [2] To do when using this configuration

## [2.1] User name and title
You can set your user's name and title in the `User/Name.nix` module. They will automatically be applied to the modules that need them; They will use the `${config.Custom.Name}` and `${config.Custom.Title}` values that are defined by you in `User/Name.nix`.

## [2.2] Hostname
You can set your computer's name on the network in the `Networking/Hostname.nix` module.

## [2.3] Flatpaks with Flathub
Currently, the Flathub Flatpak repository cannot be declaratively defined in NixOS nor Home Manager without using a custom Nix Flake. As such, you have to manually add it with a shell command after installation.
```shell
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```
This can also be done for the user, if you wish to install Flatpaks for your user only specifically.
```shell
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

## [2.4] NixOS state version
If you have installed a NixOS version higher/lower than the value currently used here (`24.05`), you must change the value of `system.stateVersion` in the `System/State-version.nix` module to it. After that, you should never need to change it, unless you install NixOS from scratch with a different version. You do not and should not change this number if you keep the same installation, even when upgrading NixOS version.

## [2.5] Home Manager version
The version of Home Manager used should match the version of NixOS you are currently using. Its value can be changed in the `User/Home-manager.nix` module. \
&nbsp;
# [3] Use cases and feature implementation

## [3.1] Targeted use case
- Single user
- Personal computing
- Desktops and laptops

## [3.2] Not yet implemented or tested, including but not limited to
- Legacy BIOS
- Secure Boot
- Accessibility
- Touchscreen
- NVIDIA PRIME
- Remote desktop
- Snap packaging system
- Use in most virtual machines (with Hyprland)
- Computers with:
	- A non-x86_64 (AMD64) CPU architecture
	- No adequate GPU acceleration (Hyprland)
	- Less than 4 GiB of RAM (Swap will be heavily used with less, 8-16 GiB is recommended)
	- Less than 128 GiB of storage (Some Nix storage optimizations are already enabled) \
&nbsp;

# [4] Other NixOS resources
Help is available in:
- The configuration.nix(5) man page
- The on-device manual by running the `nixos-help` command
- The online manual \
	[Online manual](https://nixos.org/manual/nixos/stable/index.html)
- The NixOS Wiki \
  	[NixOS Wiki](https://wiki.nixos.org)
- The Nix.dev documentation for the Nix ecosystem.
	[Nix.dev](https://nix.dev/)

A searchable list of available packages for NixOS can be found here. \
[NixOS package search](https://search.nixos.org/packages) \
Alternatively, we can use `nix search` in a terminal.

A searchable list of available options for NixOS can be found here. \
[NixOS options search](https://search.nixos.org/options)

A (slow) list of available options for Home Manager can be found here. \
[Home Manager search](https://nix-community.github.io/home-manager/options.xhtml)
