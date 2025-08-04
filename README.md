# ⚠️ [ ENVIRONMENT CHANGE NOTICE ] ⚠️
## Hyprland+XFCE -> Niri
Work is ongoing in the background in preparation to switch from a Hyprland+XFCE setup to a purely Niri one.
Currently, in this repository, you will see the "old" configuration until I have fully updated everything, so, no worries, it will not change every five seconds under your fingers.

### Done:
*(last updated: 04/08/2025)*
- All desktop modules
- All gpu modules
- All hardware modules
- All icons
- All input modules
- All program modules
- All shell scripts
- All storage modules
- All theming modules
- Crazy mindmap of the entire configuration, because why not?

### To be done:
*(last updated: 04/08/2025)*
- All uncategorized modules
- All user modules
- All virtualisation modules
- Main configuration.nix (trivial)
- Brand new README.md

## Update as of the 26th of July, 2025
My networking has been really unstable over the past two months, and I have been quite busy doing a lot of things tech related…not.
Worry not, work is still ongoing despite the hurdles, and I am now daily driving the very same NixOS + Niri configuration that will soon come here.
However, there are still things that I need to finish, such as repolishing a few of the reworked modules, update and overhaul the README, work around certain of Niri's annoying limitations in some places, continue testing daily to catch any glaring bugs and issues, and wait for some pull requests in nixpkgs to be merged for a fully fucntionaly system (we do be hating when the calculator can't build and thus blocks super critical security updates, thanks for nothing, NixOS! Ended up just making my own better).
Anyway, you may continue to read what I wrote a few weeks…months(?) ago below.

### Upcoming changes.
Relevant changes will include, but will probably not be limited to:
- Removing the Hyprland Wayland compositor.
- Removing the XFCE desktop environment.
- Adding the Niri Wayland compositor.
- Adapting the relevant shell scripts, where possible, to work with Niri _(this will also allow me to complete https://github.com/Atemo-C/NixOS-configuration/issues/3)_.
- Cleaning up other modules & making the syntax and comments across them more consisent.
- Pulling some of my configuration files from [my dotfiles](https://github.com/Atemo-C/Dotfiles) to here.

### My reasons to switch.
Here are some of the reasons I am making the switch to Niri:
- Less resource usage and a bit faster on my machines _(especially noticeable on my older laptops)_.
- Actually runs on my ThinkPad L510 _(as such, XFCE is no longer needed, as I only had it for computers where Hyprland does not work)_.
- The concept of this scrollable _(not-really-automatic-but-tilling)_ Wayland compositor intruiges me, and I quite like it for now.
- It allows me to take a step back and refresh a lot of other things that I used to use until now, such as my default terminal emulator, or how I handle some configuration files.
- It allows me to experiment with a pure Wayland-only setup _(though, XWaylandsatellite will probably end up being used at some point)_.
- It allows me to notice and potentially fix issues that I did not notice in Hyprland, such as QT apps not liking the `gtk2` engine for theming in a pure Wayland environment _(this one hurts my soul (but I found a solution))_.

---

For now, the configuration will not change. I am testing everything on my side and will upload everything once the work is complete.
Yep, another big commit coming up.

---
---
---

![image](https://github.com/Atemo-C/NixOS-configuration/blob/main/Desktop.webp)

# [1] General information.
This NixOS configuration is made for a single-user, desktop environment on an X86_64 (AMD64) CPU-based PC. \
It assumes an installation pulling packages from the `unstable` branch. \
It is a successor to [my previous NixOS configuration](https://github.com/Atemo-C/OLD-NixOS-Configuration), which is now archived. \
When using this configuration, make sure to read and modify each module of interest to you. It is, after all, made for myself first.

# [2] To do when using this configuration.

## [2.1] BIOS boot.
**This only applies if you are booting in BIOS mode.**
In the [`Boot.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/Boot.nix) module, you will find the option to set the storage device on which the `Limine` bootloader should be installed onto *[(`boot.loader.limine.biosDevice`)](https://github.com/Atemo-C/NixOS-configuration/blob/main/Boot.nix#L19)*. You need to set this value for it to be installed. \
Be careful: Using `/dev/sdX` is not recommended, for if you use multiple drives, these names may change upon reboots or other hardware/software changes. Instead, it is recommended to use the disk's ID, found in `/dev/disk/by-id`. An example using a Samsung NVME SSD is provided in the configuration.

## [2.2] User name & description.
In the [`User/Name.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/User/Name.nix) module, you can set your user's name & description *(title)*. They will automatically be applied to the modules that need them, using `${config.userName}` & `${config.userTitle}` where needed. \
To see which modules use these variables, open a terminal emulator where this configuration is located, & you can run the following commands:
- `grep -Rn "\${config.userName}"`
- `grep -Rn "\${config.userTitle}"` \
*"`-R`" reads all files under each directory, recursively, also following any symbolic links.* \
*"`-n`" shows the relevant line number at the end of the file name.*

## [2.3] Host name.
In the [`Networking.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/Networking.nix) module, you can set the PC's name over the network at [`networking.hostName`](https://github.com/Atemo-C/NixOS-configuration/blob/main/Networking.nix#L18).

## [2.4] NixOS state version.
If you have initially installed NixOS with a version different from the one present in this configuration, you will need to change its value *(currently, [`25.05`](https://github.com/Atemo-C/NixOS-configuration/blob/main/Nix-settings.nix#L5)* to the desired one in the [`Nix-settings.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/Nix-settings.nix) module. \
Note that, after that, you should never change this number. Only change it when fully re-installing NixOS.

## [2.5] NVIDIA GPUs.
To enable support for NVIDIA GPUs *(16XX+ 20XX+)* with the relevant proprietary drivers, you can uncomment the [`./NVIDIA.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/configuration.nix#L24) import in the [`configuration.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/configuration.nix) module.

## [2.6] Flatpaks & Flathub.
Currently, the Flathub Flatpak repository cannot be easily declaratively defined in NixOS & Home Manager by themselves. As such, it needs to be manually added with a shell command after installation. \
If you are using the FISH shell, I added an abbreviation that will do it for you: [`enable-flathub`](https://github.com/Atemo-C/NixOS-configuration/blob/main/User/Shell.nix#L61).

## [2.7] Guest additions.
If you are installing on a virtual machine, you might consider uncommenting the relevant Guest agents/additions in the [`configuration.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/configuration.nix) module.

## [2.8] Desktop environment.
This configuration is aimed and sometimes assumes *(to be fixed)* the use of the [Hyprland](https://hyprland.org/) Wayland compositor. However, you can enable the [XFCE](https://xfce.org/) desktop environment instead by uncommenting the relevant modules in the [`configuration.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/configuration.nix) module, as long as you also disable Hyprland in the [`./Hyprland/Enable.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/Hyprland/Enable.nix) module. \
&nbsp;

## [2.9] Suspend action.
By default, `systemctl suspend` should just work. However, on some older hardware with certain firmware bugs and other quirks, it might not work properly. This is the case on my ThinkPad L510 (see https://github.com/NixOS/nixpkgs/issues/409934 for more details). \
If this is the case for your computer, you can uncomment a custom suspend override in the [`Power.nix`](https://github.com/Atemo-C/NixOS-configuration/blob/main/Power.nix#L17) module, which will use `pm-suspend` from the [`pmutils`]() package to suspend.

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
