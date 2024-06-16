{ config, ... }: {

	fonts = {

		# Whether to create a directory with all fonts in /run/current-system/sw/share/X11/fonts.
		# https://search.nixos.org/options?channel=24.05&show=fonts.fontDir.enable
		fontDir.enable = true;

		fontconfig = {

			# Generate system fonts cache for 32-bit applications.
			cache32Bit = true;

			# Hinting style.
			# https://search.nixos.org/options?channel=24.05&show=fonts.fontconfig.hinting.style
			hinting.style = "slight";
		};
	};

}
