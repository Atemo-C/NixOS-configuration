{ config, ... }: {

	# Keyboard layout in the Linux console (TTY).
	console.keyMap = "us-acentos";

	# Keyboard layout in the Hyprland Wayland compositor.
	home-manager.users.${config.userName}.wayland.windowManager.hyprland.settings.input = {
		# Keyboard layout to use.
		kb_layout = "us";

		# Keyboard layout variant to use.
		kb_variant = "intl";
	};

#	# Keyboard layout to use in other graphical environments.
#	services.xserver.xkb = {
#		# Keyboard layout to use.
#		layout = "us";
#
#		# Keyboard layout variant to use.
#		variant = "intl";
#	};

}
