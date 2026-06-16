{ config, lib, pkgs, ... }: {
	virtualisation.waydroid = {
		# Whether to enable the Waydroid Android emulator.
		enable = true;

		# Which Waydroid package to use.
		package = pkgs.waydroid-nftables;
	};

	# User-friendly way to configure Waydriod and install extensions,
	# including but not limited to Magisk and ARM translation.
	environment.systemPackages = lib.optional config.virtualisation.waydroid.enable pkgs.waydroid-helper;
}