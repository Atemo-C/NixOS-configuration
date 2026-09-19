{ ... }: {
	imports = [
		# Display configuration.
		./display.nix

		# Input devices and keyboard layout.
		./input.nix

		# Storage configuration.
		./storage.nix

		# GPU configuration and utilities.
		./gpu.nix

		# Virtualisation software.
		../../virtualsation/virt-manager.nix
	];

	# Whether the installation process is allowed to modify EFI boot variables.
	# Once installed and working, if after an update, it fails to "install" again,
	# it should be safe to turn this option off, even if it is not ideal.
	# We love firmware bugs.
	boot.loader.efi.canTouchEfiVariables = true;

	# Name of the computer over the network.
	networking.hostName = "R7-PC";

	nix.settings = {
		# Limit the amount of cores used when building NixOS.
		# This is done to give some responsiveness and RAM back,
		# allowing the use of the system relatively normally when building.
		cores = 14;

		# Limit the number of maximum jobs running when building NixOS.
		# This is mostly so that the output is neater, and I like to see
		# programs compile one by one cleanly as well.
		# Not optimal for faster rebuilds.
		max-jobs = 1;
	};

	# Whether to enable fwupd, a DBus service allowing applications to update firmware.
	services.fwupd.enable = true;

	# Whether to enable Modem Mangaer, to handle cellular data.
	systemd.services.ModemManager.enable = false;
}
