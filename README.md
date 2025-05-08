![image](https://github.com/Atemo-C/NixOS-configuration/blob/main/Desktop.webp)

# [1] General information.
This is an almost identical version of the NixOS configuration that I use. It is made for a single-user environment on an x86_64 CPU-based PC. \
Since March 2025, it now assumes an installation pulling packages from either the `unstable` or `unstable-small` branches. \
It is a successor to [my previous NixOS configuration](https://github.com/Atemo-C/OLD-NixOS-Configuration), which is now archived. \
If you want to use this configuration (or rather, a version of it) on your system, it is highly recommended that you read what each module does, & edit them if needed. It is, after all, a very personalized system that fits my own needs. \
&nbsp;

# [2] To do when using this configuration.

## [2.1] BIOS boot.
**This only applies if you are booting in BIOS mode.**
In the [`Boot.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/Boot.nix) module, you will find the option to set the storage device on which the `Limine` bootloader should be installed onto *[(`boot.loader.limine.biosDevice`)](https://github.com/Atemo-C/NixOS-configuration/blob/main/Boot.nix#L10)*. You need to set this value for it to be installed. \
Be careful: Using `/dev/sdX` is not recommended, for if you use multiple drives, these names may change upon reboots or other hardware/software changes. Instead, it is recommended to use the disk's ID, found in `/dev/disk/by-id`. An example using a Samsung NVME SSD is provided in the configuration.

## [2.2] User name & description.
In the [`User/Name.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/User/Name.nix) module, you can set your user's name & description *(title)*. They will automatically be applied to the modules that need them, using `${config.userName}` & `${config.userTitle}` where needed. \
To see which modules use these variables, open a terminal emulator where this configuration is located, & you can run the following commands:
- `grep -Rn "\${config.userName}"`
- `grep -Rn "\${config.userTitle}"` \
*"`-R`" reads all files under each directory, recursively, also following any symbolic links.* \
*"`-n`" shows the relevant line number at the end of the file name.*

## [2.3] Host name.
In the [`Networking.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/Networking.nix) module, you can set the PC's name over the network at [`networking.hostName`](https://github.com/Atemo-C/NixOS-configuration/blob/main/Networking.nix#L14).

## [2.4] NixOS state version.
If you have initially installed NixOS with a version different from the one present in this configuration, you will need to change its value *(currently, [`25.05`](https://github.com/Atemo-C/NixOS-configuration/blob/main/Nix-settings.nix#L5)* to the desired one in the [`Nix-settings.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/Nix-settings.nix) module. \
Note that, after that, you should never change this number. Only change it when fully re-installing NixOS.

## [2.5] NVIDIA GPUs.
To enable support for NVIDIA GPUs *(16XX+ 20XX+)* with the relevant proprietary drivers, you can uncomment the [`./NVIDIA.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/configuration.nix#L24) import in the [`configuration.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/configuration.nix) module.

## [2.6] Flatpaks & Flathub.
Currently, the Flathub Flatpak repository cannot be easily declaratively defined in NixOS & Home Manager by themselves. As such, it needs to be manually added with a shell command after installation. \
If you are using the FISH shell, I added an abbreviation that will do it for you: [`enable-flathub`](https://github.com/Atemo-C/NixOS-configuration/blob/main/User/Shell.nix#L62). \
&nbsp;

## [2.7] Guest additions.
If you are installing on a virtual machine, you might consider uncommenting the relevant Guest agents/additions in the [`configuration.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/configuration.nix) module.

## [2.8] Desktop environment.
This configuration is aimed and sometimes assumes *(to be fixed)* the use of the [Hyprland](https://hyprland.org/) Wayland compositor. However, you can enable the [XFCE](https://xfce.org/) desktop environment instead by uncommenting the relevant modules in the [`configuration.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/configuration.nix) module, as long as you also disable Hyprland.

# [3] Use cases & features implementation.

## [3.1] Targeted use case.
- Single user.
- Personal computing.
- Desktops & laptops.

## [3.2] Not yet implemented or tested, including but not limited to…
- Secure Boot.
- Accessibility.
- Touchscreen.
- Remote desktop.
- Snap packaging system.
- Computers with:
	- A non-x86_64 *(AMD64)* CPU architecture.
	- No adequate GPU acceleration when using `Hyprland`.
	- Hybrid GPU setup *(NVIDIA PRIME, etc)*.
	- Less than 2 GiB of RAM *(swap can be heavily used with less than 4, 8-16 GiB is recommended)*.
	- Less than 64 GiB of storage *(some Nix storage optimizations are already enabled)*. \
&nbsp;

# [4] Some useful NixOS resources & credits.
Help is available in:
- The configuration.nix(5) man page.
- The on-device manual by running the `nixos-help` command.
- The [online manual](https://nixos.org/manual/nixos/stable/index.html)
- The [NixOS Wiki](https://wiki.nixos.org)
- The [Nix.dev](https://nix.dev/) documentation for the Nix ecosystem.

A searchable list of available packages for NixOS can be found here: \
[NixOS package search](https://search.nixos.org/packages)

A searchable list of available options for NixOS can be found here: \
[NixOS options search](https://search.nixos.org/options)

A (slow) list of available options for Home Manager can be found here: \
[Home Manager search](https://nix-community.github.io/home-manager/options.xhtml)

The beautiful wallpaper in the screenshot is made by [Byrotek](https://www.deviantart.com/byrotek).
