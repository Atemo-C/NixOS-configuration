This branch is considered to be a "throwaway" one. Nothing here is expected to be functional, important, of quality, and more. \
It is here for me to play around, to throw things at the wall and see what sticks, and more. Though, of course, and perhaps more importantly, what sticks will eventually make its way into the main branch. \
If you are looking for the experimental or main branch, you can find them here respectively: \
[Experimental branch](https://github.com/Atemo-C/NixOS-configuration/tree/experimental) \
[Main branch](https://github.com/Atemo-C/NixOS-configuration)

What follows will be the text of a "serious" configuration.
However, and rather obviously, it shall not be taken as entirely factual or accurate, as it might not represent the current state of this configuration, but a past, future, or theoretical one.

<hr>

<p align="center">Thank you for your attention to this matter. Have a pirouetting Ralsei.</p>
<p align="center"><img src="https://deltarune.wiki/images/Ralsei_battle_pirouette.gif" alt="GIF of Ralsei from DELTARUNE doing a cute pirouette."></p>

<hr>

# Atemo's NixOS configuration
###### An opinionated NixOS setup that does not piss me off.
This is the NixOS configuration I use on my devices. It is a successor to my old NixOS configuration, wihch has long been archived here: \
[https://github.com/Atemo-C/OLD-NixOS-Configuration](https://github.com/Atemo-C/OLD-NixOS-Configuration)

The base of this system is NixOS, using either the **`nixos-unstable`** or **`nixos-unstable-small`** channel. It uses the **Niri** Wayland compositor as its desktop base with the **Noctalia Shell** for its desktop shell, building around them to create a desktop experience I can be satisfied using. \
[https://nixos.org/](https://nixos.org/) \
[https://github.com/niri-wm/niri](https://github.com/niri-wm/niri) \
[https://github.com/noctalia-dev/noctalia-shell](https://github.com/noctalia-dev/noctalia-shell)

It is a single-user setup, with minimal use of **Home Manager** (installed and managed declaratively within NixOS's configuration, and rebuilt alongside it). Everything else is standard NixOS with some custom modules, and with no use of Nix Flakes. \
[https://github.com/nix-community/home-manager](https://github.com/nix-community/home-manager)

Configuration files that are not handled by built-in NixOS options are, when it makes sense to do so, linked automatically to the user's directory. This also allows them to be updated automatically whenever changed, without the need for any system rebuilding. \
[https://search.nixos.org/options?channel=unstable&show=systemd.user.tmpfiles.users.%3Cname%3E.rules](https://search.nixos.org/options?channel=unstable&show=systemd.user.tmpfiles.users.%3Cname%3E.rules)

Most packages installed here ship with their own module, to **`programs.<name>.enable`** them. Some add additional options and configurations for convenience, easy configuration, package tweaks, and more (like the previously mentionned configuration linking). When options from these custom modules are used, the comments in the Nix modules will be marked with **`[C]`**. See the Niri module for a nice example: \
[https://github.com/Atemo-C/NixOS-configuration/blob/Throwaway/desktop/niri.nix](https://github.com/Atemo-C/NixOS-configuration/blob/Throwaway/desktop/niri.nix)

Since this entire experience is adapted to what I want and what I am able to do, this will most likely not fit most people's needs and comfort zone. You may feel free to take inspiration from my work, but I encourage you to build your own desktop from scratch. I have found, in my own experience, that doing so leads to a better, more understandable, less confusing, and less frustrating experience in the end than if I were to use somebody else's configuration and modify it. This, of course, may be different for you.

With that out of the way, we can now proceed with the installation instructions.
These are the steps I take to install NixOS on my devices; It may not work for you, nor be what you want. Feel free to adapt them to your liking. This remains, after all, a configuration made for myself first.