{ config, pkgs, ... }: {

	# Default sans serif fonts.
	# https://search.nixos.org/options?channel=24.05&show=fonts.fontconfig.defaultFonts.sansSerif
	fonts.fontconfig.defaultFonts.sansSerif = [ "UbuntuMono Nerd Font" ];

}
