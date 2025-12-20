# Make sure to configure your keyboard layout in your device's `settings.nix` module.
# This module makes sure it is applied in most places on the system, without headaches.
{ config, ... }: {
	# Set the keyboard layout settings environment variables.
	# Some programs rely on these variables for the keboard settings to be applied.
	environment.variables = {
		XKB_DEFAULT_LAYOUT = config.services.xserver.xkb.layout;
		XKB_DEFAULT_VARIANT = config.services.xserver.xkb.variant;
	};

	# Whether to let the TTY's keyboard layout be the same as in graphical environments.
	# If `false`, it needs to be configured using the `console.keyMap` option.
	console.useXkbConfig = true;

	# Whether to let Kmscon's keyboard layout be the same as in graphical environments.
	# If `false`, it needs to be configured using the `services.kmscon.extraConfig` option.
	services.kmscon.useXkbConfig = true;
}