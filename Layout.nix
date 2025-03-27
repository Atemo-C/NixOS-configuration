{ config, ... }: {

	# Keyboard layout in the Linux console (TTY).
	console.keyMap = "us-acentos";

	# Keyboard layout in the Hyprland desktop.
	home-manager.users.${config.custom.name}.wayland.windowManager.hyprland.settings.input = {
		# Keyboard layout to use.
		kb_layout = "us";

		# Keyboard layout variant to use.
		kb_variant = "intl";
	};

#	# Keyboard layout in other graphical environments.
#	services.xserver.xkb = {
#		# Keyboard layout to use.
#		layout = "us";
#
#		# Keyboard layout variant to use.
#		variant = "intl";
#	};

}
