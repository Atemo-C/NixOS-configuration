{ config, ... }: {

	# Generate system fonts cache for 32-bit applications.
	# https://search.nixos.org/options?channel=24.05&show=fonts.fontconfig.cache32Bit
	fonts.fontconfig.cache32Bit = true;

}
