<h1 align="center">
	<img
		src="https://deltarune.wiki/images/Ralsei_battle_pirouette.gif"
		alt="GIF of Ralsei from DELTARUNE doing a cute pirouette."
	/>
	"Throwaway" branch
	<img
		src="https://deltarune.wiki/images/Ralsei_battle_pirouette.gif"
		alt="GIF of Ralsei from DELTARUNE doing a cute pirouette."
	/>
</h1>

This branch is considered to be a "throwaway" one. Nothing here is expected to be functional, important, of quality, and more.
It is here for me to play around, to throw things at the wall and see what sticks, and more. Though, of course, and perhaps more importantly, what sticks will eventually make its way into the main branch. \
If you are looking for the experimental or main branch, you can find them here respectively:
- [Experimental branch](https://github.com/Atemo-C/NixOS-configuration/tree/experimental)
- [Main branch](https://github.com/Atemo-C/NixOS-configuration)

What follows will be the text of a "serious" configuration.
However, and rather obviously, it shall not be taken as factual or accurate, as it might not represent the current state of this configuration.

---

# About this configuration
This is the NixOS configuration I use on my physical and virtual devices.
It is a successor to my old NixOS configuration, which has long been archived here:
- [My legacy NixOS configuration](https://github.com/Atemo-C/OLD-NixOS-Configuration)

The base of this system is NixOS, be it from the **`nixos-unstable`** or **`nixos-unstable-small`** channel. \
It uses the Niri Wayland compositor as its base, and builds around it to create a desktop experience I can be content with. Not quite what I dream of, but close enough to work with.

It is a single-user setup, with minimal use of Home Manager and Flatpaks (configured declaratively and in the general system configuration as well). Otherwise, everything else is standard NixOS, and without Flakes.

Since this entire experience is adapted to what I want and what I am able to do, this will most likely not work out for most other people. You may feel free to take inspiration from my work, but I encourage you to do your own thing. I have found that starting from scratch and building up leads to me having a better experience and understanding of the system, whereas such is not often the case when I use somebody else's configuration. This may be different for you…
