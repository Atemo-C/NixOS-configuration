{ pkgs, ... }: {
	virtualisation.waydroid = {
		# Enable the Waydriod Android emulator.
		enable = true;

		# Which Waydroid package to use.
		package = pkgs.waydroid-nftables;
	};

	# User-friendly way to configure Waydroid and install extensions;
	# Including but not limited to Magisk and ARM translation.
	environment.systemPackages = [ pkgs.waydroid-helper ];
}