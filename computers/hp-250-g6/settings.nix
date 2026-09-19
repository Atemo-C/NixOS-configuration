{ ... }: {
	imports = [
		# The main system configuration.
		# Not importing it results in, well, no system.
		../../configuration.nix

		# The automatically-generated hardware configuration file.
		# Not importing it results in, again, no system.
#		./hardware-configuration.nix

		# Input devices and keyboard layout.
		./input.nix

		# Storage configuration.
		./storage.nix

		# Bluetooth support.
		../../system/bluetooth.nix
	];

	# Whether the installation process is allowed to modify EFI boot variables.
	# Once installed and working, if after an update, it fails to "install" again,
	# it should be safe to turn this option off, even if it is not ideal.
	# We love firmware bugs.
	boot.loader.efi.canTouchEfiVariables = true;

	# Name of the computer over the network.
	# For this NixOS configuration, it must be lower-case.
	networking.hostName = "hp-250-g6";

	nix.settings = {
		# Limit the amount of cores used when building NixOS.
		# This is done to give some responsiveness and RAM back,
		# allowing the use of the system relatively normally when building.
		cores = 2;

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