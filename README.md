![Screenshot of the desktop on my HP 250 G6](https://github.com/Atemo-C/NixOS-configuration/blob/main/Desktop.webp)

# General information.
This NixOS configuration is almost exactly what I use on my own systems. \
It is a single-user setup with the [Niri](https://github.com/YaLTeR/niri) Wayland compositor as its base environment. It uses NixOS unstable under the hood, with some help from [Home Manager](https://github.com/nix-community/home-manager). \
It is a successor to [my old NixOS configuration](https://github.com/Atemo-C/OLD-NixOS-Configuration), which is now archived. \
When using this configuration, make sure to read and modify each module of interest to you. It is, after all, made for myself first. It is assumed that you have prior experience with NixOS *(without flakes)*, or you **will** be lost.

# To know and do when using this configuration. ‎
## Permissions of `/etc/nixos/*`
To make the experience as painless as possible, I recommend to run `sudo chown your-user-name:users -R /etc/nixos/`. This allows the entire `/etc/nixos/` dierctory and all of its files to have user read and write access, without the need for a password.

## Hardware configuration files.
This configuration splits hardware modules into two:
- The automatically-generated hardware configuration file in the [`./hardware/generated/`](https://github.com/Atemo-C/NixOS-configuration/blob/main/hardware/generated/) directory, renamed to fit the device that is targeted.
- The manually-written hardware configuration file in the [`./hardware/devices/`](https://github.com/Atemo-C/NixOS-configuration/blob/main/hardware/devices/) directory, renamed to fit the device that is targeted.

The automatically-generated hardware configuration files are untouched from the ones created by running `nixos-generate-config --root /path/to/system`. \
The manually-written hardware configuration files contains settings such as, but not limited to:
- Kernel version
- If the system boots in EFI or BIOS mode
- Hostname
- Optional network modules
- Workarounds for specific hardware/firmware bugs
- Default keyboard layout with priority over the [`./input/keyboard-layout.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/input/keyboard-layout.nix) module
- Firmware update manager with [fwupd](https://fwupd.org/)

Naturally, you can see the already-present files to see what you should configure yourself.

## User name and title.
In the [`./user/name.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/user/name.nix) module, you must set your user's name and title *(description)*. They will be automatically be applied to all the modules that need them, using `${config.userName}` and `${config.userTitle}`. \
To see which modules use these variables, open a console where this configuration is located, and run the following command: `grep -Rn "\${config.user"` \
*`-R` reads all files under each directory, recursively, also following any symbolic links.*
*`-n` shows the relevant line number at the end of the file names.*

## NVIDIA GPUs and `configuration.nix`.
To enable support for NVIDIA GPUs *(16XX+ 20XX+)* with the relevant proprietary drivers, you can uncomment the `./nvidia.nix` import in the [`configuration.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/configuration.nix) module. In here, you will also find literally every module that can be commented in/out for your needs.

# Use cases and features implementation.
## Targeted usecase.
- Single user.
- Personal computing.
- Desktop and laptops.

## Not yet implemented or tested, including but not limited to:
- Accessibility.
- Touchscreen.
- Remote desktop.
- Computers with:
	- A non-x86_64 *(AMD64)* CPU architecture.
	- Hybrid GPU setup *(NVIDIA PRIME, etc)*.
	- Less than 2GiB of RAM *(swap WILL be heavily used with less than 6 when building the system)*.
	- Less than 48GiB of storage *(some Nix storage optimizations are already enabled)*.

# Some useful NixOS resources and credits.
Help is available in:
- The configuration.nix(5) man page.
- The on-device manual by running the `nixos-help` command.
- The [online manual](https://nixos.org/manual/nixos/stable/index.html)
- The [NixOS Wiki](https://wiki.nixos.org)
- The [Nix.dev](https://nix.dev/) documentation for the Nix ecosystem.

A searchable list of available packages for NixOS can be found here: \
[NixOS package search](https://search.nixos.org/packages?channel=unstable)

A searchable list of available options for NixOS can be found here: \
[NixOS options search](https://search.nixos.org/options?channel=unstable)

A (slow) list of available options for Home Manager can be found here: \
[Home Manager search](https://nix-community.github.io/home-manager/options.xhtml)

The beautiful wallpaper in the screenshot is made by [t1na](https://www.deviantart.com/t1na).
