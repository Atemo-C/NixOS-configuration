This branch is considered to be a "throwaway" one. Nothing here is expected to be functional, important, of quality, and more. \
It is here for me to play around, to throw things at the wall and see what sticks, and more. Though, of course, and perhaps more importantly, what sticks will eventually make its way into the main branch. \
If you are looking for the experimental or main branch, you can find them here respectively:
- [Experimental branch](https://github.com/Atemo-C/NixOS-configuration/tree/experimental)
- [Main branch](https://github.com/Atemo-C/NixOS-configuration)

What follows will be the text of a "serious" configuration.
However, and rather obviously, it shall not be taken as factual or accurate, as it might not represent the current state of this configuration, but a past, future, or theoretical one.

---


<h1 align="center">
	<img
		src="https://deltarune.wiki/images/Ralsei_battle_pirouette.gif"
		alt="GIF of Ralsei from DELTARUNE doing a cute pirouette."
	>
	Atemo's NixOS configuration
	<img
		src="https://deltarune.wiki/images/Ralsei_battle_pirouette.gif"
		alt="GIF of Ralsei from DELTARUNE doing a cute pirouette."
	>
</h1>

This is the NixOS configuration I use on my devices. It is a successor to my old NixOS configuration, wihch has long been archived here:
- [https://github.com/Atemo-C/OLD-NixOS-Configuration](https://github.com/Atemo-C/OLD-NixOS-Configuration)

The base of this system is **NixOS**, using either the **`nixos-unstable`** or **`nixos-unstable-small`** channel. \
It uses the **Niri** Wayland compositor as its base with the **Noctalia Shell** for its devsktop shell, and builds around them to create a desktop experiece I can be satisfied using.
- [https://nixos.org/](https://nixos.org/)
- [https://github.com/niri-wm/niri](https://github.com/niri-wm/niri)
- [https://github.com/noctalia-dev/noctalia-shell](https://github.com/noctalia-dev/noctalia-shell)

It is a single-user estup, with minimal use of Home Manager and Flatpaks (both installed and configured declaratively, rebuilding alongside NixOS). Everything else is standard NixOS, and without the use of Nix Flakes.
- [https://github.com/nix-community/home-manager](https://github.com/nix-community/home-manager)
- [https://github.com/nix-community/home-manager](https://github.com/nix-community/home-manager)

Configuration files that are not managed directly by built-in `programs.<name> = {};` options are instead, when possible and convenient, linked by systemd from the NixOS configuartion to the user's relevant directories. This also allows them to be updated automatically whenever changed, without the need for any rebuilding.
- [https://search.nixos.org/options?channel=unstable&query=systemd.user.tmpfiles.users.&show=systemd.user.tmpfiles.users.%3Cname%3E.rules](https://search.nixos.org/options?channel=unstable&query=systemd.user.tmpfiles.users.&show=systemd.user.tmpfiles.users.%3Cname%3E.rules)

Most packages here are shipped with their own custom module, to `programs.<name>.enable` them. Some may add additional options for convenience, easy configuration, or the previously mentionned linking of configuration files and directories. When options from these custom modules are used, the comments in the Nix modules will be marked with **`[C]`**. See the following example:
- [https://github.com/Atemo-C/NixOS-configuration/blob/Throwaway/desktop/niri.nix#L6](https://github.com/Atemo-C/NixOS-configuration/blob/Throwaway/desktop/niri.nix#L6)

Since this entire experience is adapted to what I want and what I am able to do, this will most likely not fit most people's needs and comfort zone. You may feel free to take inspiration from my work, but I encourage you to build your own desktop from scratch. I have found, in my own experience, that doing so leads to a better, more understandable, less confusing, and less frustrating experience in the end than if I were to use somebody else's configuration and modify it. This, of course, may be different for you.