# Your keyboard layout is configured in your device's `settings.nix` module.
# This module makes sure that it is applied in as many places on the system as possible.
{ config, ... }: {
	# Set the keyboard layout settings environment variables.
	# Some programs rely on these variables for the keyboard layout settings to be applied.
	environment.variables = {
		XKB_DEFAULT_LAYOUT = config.services.xserver.xkb.layout;
		XKB_DEFAULT_MODEL = config.services.xserver.xkb.model;
		XKB_DEFAULT_OPTIONS = config.services.xserver.xkb.option;
		XKB_DEFAULT_VARIANT = config.services.xserver.xkb.variant;
	};

	# Whether to let the TTY's keyboard layout be the same as in graphical environments.
	# If `false`, it needs to be configured using the `console.keyMap` option.
	console.useXkbConfig = true;

	# Whether to let Kmscon's keyboard layout be the same as in graphical environments.
	# If `false`, it needs to be configured using the `services.kmscon.extraConfig` option.
	services.kmscon.useXkbConfig = true;
}