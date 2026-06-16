{ config, ... }: {
	# Whether the TTY should use the same keyboard layout as the desktop.
	console.useXkbConfig = true;

	# Environment variables to apply the keyboard layout settings globally.
	# These settings are to be defined in your device's `settings.nix` module.
	environment.variables = {
		XKB_DEFAULT_LAYOUT = config.services.xserver.xkb.layout;
		XKB_DEFAULT_MODEL = config.services.xserver.xkb.model;
		XKB_DEFAULT_OPTIONS = config.services.xserver.xkb.options;
		XKB_DEFAULT_VARIANT = config.services.xserver.xkb.variant;
	};
}