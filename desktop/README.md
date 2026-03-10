<p align="center">
	<img
		src="https://c.tenor.com/PnuoQnKXre4AAAAj/ralsei-waving.gif"
		alt="Ralsei from DELTARUNE waving at you"
	/>
</p>

# Desktop directory
This directory contains all the necessary modules and configuration files to build a working desktop \
It contains:
- **[ly](https://codeberg.org/fairyglade/ly)** as the display manager;
- **[Niri](https://github.com/niri-wm/niri)** as the Wayland compositor;
- **[Noctalia](https://github.com/noctalia-dev/noctalia-shell)** as the desktop shell;
- **[cmd-polkit](https://github.com/OmarCastro/cmd-polkit)** with **[Fuzzel](https://codeberg.org/dnkl/fuzzel)** as the Polkit authentification agent;
- **[swayidle](https://github.com/swaywm/swayidle)** as the idle daemon and **[sway-audio-idle-inhibit](https://search.nixos.org/packages?channel=unstable&query=swayidle)** to prevent it from triggering when audio is playing;
- Some shell scripts to complete the experience;
- Most relevant configuration files, which are automatically linked in the user's `$HOME` directory.

Things such as the default file manager, terminal emulator, and others, are configured in their relevant directories, outside of the desktop directory.