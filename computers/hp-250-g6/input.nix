{ ... }: {
	# ZSA keyboard support.
	imports = [ ../../input/zsa.nix ];

	# Keyboard layout configuration on this system.
	# To see a complete list of layouts, variants, and other settings:
	# • https://gist.github.com/jatcwang/ae3b7019f219b8cdc6798329108c9aee
	#
	# To see why this list cannot easily be seen within NixOS:
	# • https://github.com/NixOS/nixpkgs/issues/254523
	# • https://github.com/NixOS/nixpkgs/issues/286283
	services.xserver.xkb = {
		layout = "fr,us";
		variant = ",intl";
	};
}