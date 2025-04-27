{ config, ... }: rec {

	# Keyboard layout configuration to use in graphical environments.
	# To see a complete list: https://gist.github.com/jatcwang/ae3b7019f219b8cdc6798329108c9aee
	# And why this list cannot be seen within NixOS:
	# • https://github.com/NixOS/nixpkgs/issues/254523
	# • https://github.com/NixOS/nixpkgs/issues/286283
	services.xserver.xkb = {
		# Keyboard layout to use.
		layout = "us";

		# Keyboard layout variant to use.
		variant = "intl";
	};

	# Keyboard layout configuration to use in the Hyprland Wayland compositor.
	home-manager.users.${config.userName}.wayland.windowManager.hyprland.settings.input = {
		# Keyboard layout to use.
		kb_layout = services.xserver.xkb.layout;

		# Keyboard layout variant to use.
		kb_variant = services.xserver.xkb.variant;
	};

	# Whether to use the virtual console (TTY) keymap from the xserver keyboard settings.
	console.useXkbConfig = true;

}
