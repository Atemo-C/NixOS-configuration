# Note!
Currently, I am doing some work in the experimental branch as well as separate work and testing on a fully clean/fresh installation on my HP 250 G6 laptop. I have discovered a lot of cruft that can now be removed, a lot of improvements and bug fixes, as well as other things. \
This current configuration is still what I use on my main PC, and as such, it will be kept up-to-date, no problem there. However, improvements mentioned earlier will come at a later date this year, for I have lots of things to do, but it is very exciting indeed! \
A list of improvements that have been achieved in the experimental branch and/or the installation on my HP 250 G6 can be found [here](https://github.com/Atemo-C/NixOS-configuration?tab=readme-ov-file#improvements), at the bottom of this README.

---

![Screenshot of the desktop on my HP 250 G6](https://github.com/Atemo-C/NixOS-configuration/blob/main/Desktop.webp)

# General information.
This NixOS configuration is almost exactly what I use on my own systems. \
It is a single-user setup with the [Niri](https://github.com/YaLTeR/niri) Wayland compositor as its base environment. It uses NixOS unstable under the hood, with some help from [Home Manager](https://github.com/nix-community/home-manager). \
It is a successor to [my old NixOS configuration](https://github.com/Atemo-C/OLD-NixOS-Configuration), which is now archived. \
When using this configuration, make sure to read and modify each module of interest to you. It is, after all, made for myself first. It is assumed that you have prior experience with NixOS *(without flakes)*, or you **will** be lost.

# To know and do when using this configuration. ‎
## Permissions of `/etc/nixos/*`
To make the experience as painless as possible, the entire `/etc/nixos/` dierctory and all of its files have user read and write access, without the need for a password. If this is a security concern for you, considering disabling this in the [`./uncategorized/nix-settings.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/uncategorized/nix-settings.nix) module.

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

---

# Improvements
Refer to the very top of this README!
Things already improved in testing that will be here sooner or later:
- Default terminal emulator is now handled properly with `xdg-terinal-exec`, allowing the removal of weird .desktop files and other entries, as well as a much cleaner and easier configuration of the default terminal emulator to use.
- Addition of certain useful nix utilties, such as `nix-prefetch-github`
- Declarative configuration of Flatpaks to be installed with [nix-flatpak](https://github.com/gmodena/nix-flatpak) installed without Flakes.
- Simplifed theming configuration, as well as environment variables for theming to shorten paths and so on.
- Enabling binaries in `~/.local/bin/` to be detected.
- Removal of now unecessary workarounds to fix certain bugs in nixpkgs that have been fixed.
- More logical fragmentation of the configuration, and less of it.
- Consistent syntax and formatting accross all modules and shell scripts.
- Simpler and more thoroughly tested shell scripts.
- Less resource usage (RAM, CPU) by default, whilst improving functionality.
- More…
