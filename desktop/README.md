# Desktop directory
This directory contains modules and configuration files to build the base of the graphical desktop.

## [`niri.nix`](./niri.nix)
This module is imported in [`configuration.nix`](../configuration.nix).

### [`programs.niri.enable`](./niri.nix#L3)
• [Niri's GitHub page](https://github.com/niri-wm/niri)

Niri is a scrollable-tiling Wayland compositor. \
This is the core of the graphical environment. I chose it because I like the scrollable-tiling window management model, and because it runs great on anything ranging from my 2009 ThinkPad L510, to my Ryzen 5-based PC with both integrated Vega 11 graphics and a dedicated GTX 1660 SUPER GPU, and to my Ryzen 7-based PC with an RX 9070 XT.

Note that, if you try to run Niri in a virtual machine or weak device, it currently needs working 3D acceleration of some kind. See this issue for more details: \
• [niri-wm/niri/#218 - software renderer](https://github.com/niri-wm/niri/issues/218)

This option is built into NixOS, but here has some additional configurations thanks to the [`niri.nix`](../extra-modules/atemo_cajaku/programs/niri.nix) programs module in this configuration. Notably, it:
- Adds an option to link the configuration (`false` by default);
- Adds an option to install the XWayland Satellite for XWayland integration (`true` by default);
- Enables Dconf;
- Enables hardware-accelerated graphics normally and for 32-bit programs;
- Applies fixes for gsettings issues (see [this issue](https://github.com/NixOS/nixpkgs/issues/149812) and [this part of the solution](https://github.com/thomX75/nixos-modules/blob/main/Glib-Schemas-Fix/glib-schemas-fix.nix)).

##

### [`programs.niri.linkConfiguration`](./niri.nix#L4)
**`[C]`** Link Niri's configuration directory, from [`/etc/nixos/desktop/files/niri/`](./files/niri/) to `~/.config/niri/`.

This option is created by the [`niri.nix`](../extra-modules/atemo_cajaku/programs/niri.nix#L6) programs module. \
If, for some reason, you already have a pre-existing `~/.config/niri/` directory that was created before the activation of this module, it needs to be deleted, so that the one in `/etc/nixos/desktop/files/niri/` can be successfully linked.

##

### [`programs.noctalia-shell.enable`](./niri.nix#L9)
• [Noctalia Shell's website](https://github.com/noctalia-dev/noctalia-shell)

**`[C]`** Noctalia Shell is a sleek and minimal desktop shell thoughtfully crafted for Wayland, built with Quickshell. \
Before using it, I had many components, all more lightweight but all more cumbersome and annoying to deal with separately (waybar, dunst, fuzzel, swayidle, swaylock, many questionably-written shell scripts…). This is the all-in-one solution to that I like most; And whilst it is not nearly as lightweight, it offers too much convenience, niceties, and integration *not* to use.

This option is created by the [`noctalia-shell.nix`](../extra-modules/atemo_cajaku/programs/noctalia-shell.nix#L3) programs module. \
I try to keep the Noctalia Shell as up-to-date as possible, as it can sometimes take quite a while for the updates to be merged into nixpkgs. As such, the [`noctalia-shell.nix`](../extra-modules/atemo_cajaku/packages/noctalia-shell.nix) and [`noctalia-qs.nix`](../extra-modules/atemo_cajaku/packages/noctalia-qs.nix) package modules exist too, residing in [`/etc/nixos/extra_modules/atemo_cajaku/packages/`](../extra-modules/atemo_cajaku/packages/).

##

### [`programs.noctalia-shell.linkConfiguration.enable`](./niri.nix#L10)
**`[C]`** Link Noctalia Shell's configuration directory, from [`/etc/nixos/desktop/files/noctalia-shell/`](./files/noctalia/) to `~/.config/noctalia/`.

This option is created by the [`noctalia-shell.nix`](../extra-modules/atemo_cajaku/programs/noctalia-shell.nix#L5) programs module. \
If, for some reason, you already have a pre-existing `~/.config/noctalia/` directory that was created before the activation of this module, it needs to be deleted, so that the one in `/etc/nixos/desktop/files/noctalia/` can be successfully linked.

##

### [`programs.niri-screenshot.enable`](./niri.nix#L13)
**`[C]`** This is a simple DASH shell script to facilitate taking screenshots in Niri. Use the `screenshot --help` command to see more information.

This option is created by the [`niri-screenshot.nix`](../extra-modules/atemo_cajaku/programs/niri-screenshot.nix#L2) programs module. It installs the follownig package module: [`/etc/nixos/extra-modules/atemo_cajaku/packages/niri-screenshot.nix`](../extra-modules/atemo_cajaku/packages/niri-screenshot.nix).

##

### [`programs.fish.shellAbbrs."n"`](./niri.nix#L14)
Type `n` in the TTY to start the Niri Wayland compositor after having logged in.