{ ... }: {
	imports = [
		# OpenTabletDriver for drawing tablets.
		../../input/opentabletdriver.nix

		# ZSA keyboard support.
		../../input/zsa.nix

		# Utility to convert a MiDiPLUS SmartPAD into a full macropad.
		../../extra-modules/scripts/midiplus-smartpad-macropad.nix
	];

	# Keyboard layout configuration on this system.
	# To see a complete list of layouts, variants, and other settings:
	# • https://gist.github.com/jatcwang/ae3b7019f219b8cdc6798329108c9aee
	#
	# To see why this list cannot easily be seen within NixOS:
	# • https://github.com/NixOS/nixpkgs/issues/254523
	# • https://github.com/NixOS/nixpkgs/issues/286283
	services.xserver.xkb = {
		layout = "us,fr";
		variant = "intl,";
	};
}