# [1] General information
This is an almost identical version of the NixOS configuration that I use. It is made for single-user use on a desktop or laptop system. \
It does not use Flakes and never, ever will, but it does make use of Home Manager and some unstable packages whilst on a stable version. \
It is an overhaul of my previous NixOS configuration, which can still be found [here](https://github.com/Atemo-C/OLD-NixOS-Configuration). \
(Amajor update on the 16th of September 2024 overhauled the structure again, though most things are still working the same way under the hood.) \
If you want to use this configuration (or rather, a version of it), on your own system, it is hightly recommended that you read what each module does and edit them if needed. \
&nbsp;
# [2] To do when using this configuration

## [2.1] User name and title
You can set your user's name and title in the `User/Name.nix` module. They will automatically be applied to the modules that need them; They will use the `${config.custom.name}` and `${config.custom.title}` values that are defined by you in `User/Name.nix`.

## [2.2] Hostname
You can set your computer's name on the network in the `Networking/Settings.nix` module.

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
If you have installed a NixOS version higher/lower than the value currently used here (`24.05`), you must change the value of `system.stateVersion` in the `Packaging/System.nix` module to it. After that, you should never need to change it, unless you install NixOS from scratch with a different version. You do not have to nor should not change this number if you keep the same installation, even when upgrading NixOS version.

## [2.5] Home Manager version
The `User/Home-manager.nix` module fetches the tarball of the desired Home Manager version, which should ideally be the same version as the NixOS version currently running. In it, if needed, change the `24.05` part in `"https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz"` to the appropriate version.

## [2.6] BIOS or EFI boot
In `configuration.nix`, comment/uncomment the desired boot mode. You can tweak the `Boot/EFI` and `Boot/BIOS` modules on their own for futher configuration if needed.

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
- Non-offload Nvidia PRIME
- Remote desktop
- Snap packaging system
- Use in most virtual machines (with Hyprland)
- Computers with:
	- A non-x86_64 (AMD64) CPU architecture
	- No adequate GPU acceleration (Hyprland)
	- Hybrid GPU setup (NVIDIA PRIME, etc)
	- Less than 2 GiB of RAM (Swap will be heavily used with less than 4, 8-16 GiB is recommended)
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

# [5] Bonus: Concepts
In the [`Concepts`](https://github.com/Atemo-C/NixOS-configuration/tree/main/Concepts) directory, you may find some concepts of NixOS modules that I would love to be implemented into NixOS proper somehow. \
They are non-functional and thus not imported into `configuration.nix`; Their presence does not interfere with anything.
