{ config, ... }: {

	# Whether to create a directory with all fonts in /run/current-system/sw/share/X11/fonts.
	# https://search.nixos.org/options?channel=24.05&show=fonts.fontDir.enable
	fonts.fontDir.enable = true;

}
