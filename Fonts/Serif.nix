{ config, pkgs, ... }: {

	# Default serif fonts.
	# https://search.nixos.org/options?channel=24.05&show=fonts.fontconfig.defaultFonts.serif
	fonts.fontconfig.defaultFonts.serif = [
		"UbuntuMono Nerd Font"
		"Noto Color Emoji"
	];

}
