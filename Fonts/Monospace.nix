{ config, pkgs, ... }: {

	# Default monospace fonts.
	# https://search.nixos.org/options?channel=24.05&show=fonts.fontconfig.defaultFonts.monospace
	fonts.fontconfig.defaultFonts.monospace = [
		"UbuntuMono Nerd Font"
		"Noto Color Emoji"
	];

}
