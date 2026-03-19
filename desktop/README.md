> *As I am writing this, and coding, I am listening to OneShot's soundtracks.* \
> *These musics bring great and terrible memories, and I cherish them with my very heart.* \
> *If only for a limited amount of time, I feel at peace; Despite everything…* \
> *Thank you, Nightmargin (Casey Gu), Eliza Velasquez, and Michael Shirt.* \
> \- Atemo Cajaku

---

# 📁 Desktop directory
This directory contains the essential modules to build the foundations of the desktop I use. \
The desktop consists of a few key core components:
- The [**Niri**](https://github.com/niri-wm/niri) Wayland compositor;
- The [**Noctalia Shell**](https://github.com/noctalia-dev/noctalia-shell);
- The [**Ly**](https://codeberg.org/fairyglade/ly) display manager;
- The [**XWayland Satellite**](https://github.com/Supreeeme/xwayland-satellite).

---

## Ly
**Ly** is the first thing you see after the [splash screen](https://github.com/Atemo-C/NixOS-configuration/blob/Throwaway/uncategorized/boot.nix). It is the Display Manager (what a stupid name that still is), which allows you to log into Niri (or any other supported environment). It is very simple, lightweight, and does not need to load an entire graphical environment onto itself. It does the job perfectly fine, and it needs to do no more. \
I would consider changing this to a good Wayland-only graphical display manager once/if I get a touchscreen device or need more accessibility, for Ly is entirely keyboard-driven. If you know of one, feel free to open an issue or pull request with your idea and implementation. \
In [the Niri module](https://github.com/Atemo-C/NixOS-configuration/blob/Throwaway/desktop/niri.nix#L11), support for X11 environments is disabled, as I only use Niri, which is Wayland-only.

## Niri
**Niri** is what you see upon logging in. This is the Wayland Compositor, aka, the desktop. It handles windows, compositing, keyboard shortcuts, and all kinds of complicated things needed for a desktop to do desktop things. \
I chose it as I love the tilling scrolling model, and as it runs on everything from my ThinkPad L510 to my current desktop PC without issue. \
In [its module](https://github.com/Atemo-C/NixOS-configuration/blob/Throwaway/desktop/niri.nix), Niri's settings are linked to the user's directory, Dconf and 32-bit graphics are enabled, and two workarounds for GSettings/Dconf settings are applied. You can read more about the latter two here: \
https://github.com/thomX75/nixos-modules/blob/main/Glib-Schemas-Fix/glib-schemas-fix.nix \
https://github.com/NixOS/nixpkgs/issues/149812

## Noctalia Shell
**Noctalia** is the desktop shell. It manages a lot of things (optionally), some of which include: Bar, dock, widgets, notifications, program and session menus, idle management, screen locking, night light, color scheme generator, wallpapers… \
It does a lot of things, and it does them well. It uses more resources than my previous implementation of using Waybar with a ton of shell scripts and other utilities, but the experience is so much better, tightly integrated, smooth, and painless, that I felt it was worth the switch. \
In [the Niri module](https://github.com/Atemo-C/NixOS-configuration/blob/Throwaway/desktop/niri.nix#L33), Noctalia's settings are linked to the user's directory.

## XWayland Satellite
**XWayland Satellite** is here to provide compatibility for X11-only programs, or programs that currently still run better on X11 environments. If you do not run any such program, you may feel free to exclude this, and save just about a hundred megabytes of RAM at idle. \
For me, I keep it, if just for that occasional archaic Java application, or the Steam client not yet natively and fully supporting Wayland.

---

## Additional things.
A [screenshot script](https://github.com/Atemo-C/NixOS-configuration/blob/Throwaway/desktop/screenshot.nix) is provided. It leverages Niri's built-in screenshot utility, and extends it with others to have a more complete and intuitive screenshot experience. The tools used in the script do not "pollute" the user's environment, and are self-contained to the script. \
Of course, if you install some of these same utilities on the system, they will not be duplicated; Nix will automatically make it automatically available to both. The joy of symlinks.
