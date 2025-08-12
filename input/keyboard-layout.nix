{ config, ... }: {
	# Keyboard layout to use.
	# To see a complete list of layouts, variants, and other settings:
	# • https://gist.github.com/jatcwang/ae3b7019f219b8cdc6798329108c9aee
	#
	# And why this list cannot be seen within NixOS:
	# • https://github.com/NixOS/nixpkgs/issues/254523
	# • https://github.com/NixOS/nixpkgs/issues/286283
	#
	# For Niri, the keyboard layout needs to be manually configured in the `./desktop/files/niri.kdl` file.
	services.xserver.xkb = {
		# Keyboard layout to use.
		layout = "us";
		#layout = "fr";

		# Keyboard layout variant to use.
		variant = "intl";
	};

	# Whether to let the virtual console's (TTY's) keyboard layout be the same as the one configured above.
	# If false, it needs to be set using the `console.keyMap` option.
	console.useXkbConfig = true;
}
