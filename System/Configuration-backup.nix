{ config, ... }: {

	# Copies the NixOS configuration file and links it from the resulting system.
	# https://search.nixos.org/options?channel=24.05&show=system.copySystemConfiguration
	system.copySystemConfiguration = true;

}
