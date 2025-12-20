{ ... }: {
	boot = {
		# Define the LUKS-encrypted storage devices (root and swap).
		initrd.luks.devices = {
			root.device = "/dev/disk/by-uuid/UUID-HERE";
			swap.device = "/dev/disk/by-uuid/UUID-HERE";
		};

		# Whether to let the installation process modify EFI boot variables.
		# If you have errors when updating NixOS after it has been installed,
		# as in, the bootloader fails to "install" again, it is safe to turn this off.
		loader.efi.canTouchEfiVariables = true;
	};

	# Filesystem options.
	fileSystems = {
		"/".options = [ "compress=zstd:3" ];
		"/home".options = [ "compress=zstd:3" ];
		"/nix"options = [ "compress=zstd:3" "noatime" ];
	};

	# Set the computer's name on the network.
	networking.hostName = "R5-PC";

	services = {
		# Whether to enable LACT, a tool for monitoring, configuring, and overclocking GPUs.
		lact.enable = true;

		# Keyboard layout settings.
		# To see a complete list of layouts, variants, and other settings:
		# • https://gist.github.com/jatcwang/ae3b7019f219b8cdc6798329108c9aee
		#
		# To see why this list cannot easily be seen within NixOS:
		# • https://github.com/NixOS/nixpkgs/issues/254523
		# • https://github.com/NixOS/nixpkgs/issues/286283
		xserver.xkb = {
			layout = "us,fr";
			variant = "intl,";
		};
	};

	# Disable the ModemManager service to improve boto times and save resources.
	# Only enable if using cellular data (tethering from a mobile device does not count).
	systemd.services.ModemManager.enable = false;
}