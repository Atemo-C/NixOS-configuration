{ config, ... }: {
	# Keyboard layout settings.
	# To see a complete list of layouts, variants, and other settings:
	# • https://gist.github.com/jatcwang/ae3b7019f219b8cdc6798329108c9aee
	#
	# To see why this list cannot easily be seen within NixOS:
	# • https://github.com/NixOS/nixpkgs/issues/254523
	# • https://github.com/NixOS/nixpkgs/issues/286283
	services.xserver.xkb.layout = "us";
	services.xserver.xkb.variant = "intl";

	# Export the used keyboard layout. Some programs rely on this setting for it to be properly applied.
	environment.variables.XKB_DEFAULT_LAYOUT = configservices.xserver.xkb.layout;
	environment.variables.XKB_DEFAULT_VARIANT = config.services.xserver.xkb.variant;

	# Whether to let the virtual console's (TTY's) keyboard layout be the same as the one configured above.
	# If false, it needs to be manually configured with the `console.keyMap` option.
	console.useXkbConfig = true;
}