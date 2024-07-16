{ config, pkgs, ... }: {

	# Default emoji fonts.
	# https://search.nixos.org/options?channel=24.05&show=fonts.fontconfig.defaultFonts.emoji
	fonts.fontconfig.defaultFonts.emoji = [
		"Noto Color Emoji"
	];

}
