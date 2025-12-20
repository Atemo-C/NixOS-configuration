{ ... }: {
	boot = {
		# Define the LUKS-encrypted storage devices (root and swap).
		initrd.luks.devices = {
			root.device = "/dev/disk/by-uuid/80ef44a6-7ee0-4001-bc09-7b5fcd11b46e";
			swap.device = "/dev/disk/by-uuid/56c4a6c9-e2d5-4b02-a13d-45ad9302a19e";
		};

		# Whether to let the installation process modify EFI boot variables.
		# If you have errors when updating NixOS after it has been installed,
		# as in, the bootloader fails to "install" again, it is safe to turn this off.
		loader.efi.canTouchEfiVariables = false;
	};

	# Filesystem options.
	fileSystems = {
		"/".options = [ "compress=zstd:3" ];
		"/home".options = [ "compress=zstd:3" ];
		"/nix"options = [ "compress=zstd:3" "noatime" ];
	};

	# Extra packages for hardware acceleration.
	hardware.graphics.extraPackages = lib.optionals config.hardware.graphics.enable (with pkgs; [
		# VA-API for modern Intel GPUs.
		intel-media-driver

		# OpenCL for Intel GPUs.
		intel-compute-runtime
	]);

	# Set the computer's name on the network.
	networking.hostName = "HP-250-G6";

	# Keyboard layout settings.
	# To see a complete list of layouts, variants, and other settings:
	# • https://gist.github.com/jatcwang/ae3b7019f219b8cdc6798329108c9aee
	#
	# To see why this list cannot easily be seen within NixOS:
	# • https://github.com/NixOS/nixpkgs/issues/254523
	# • https://github.com/NixOS/nixpkgs/issues/286283
	services.xserver.xkb = {
		layout = "fr,us";
		variant = ",intl";
	};

	# Disable the ModemManager service to improve boto times and save resources.
	# Only enable if using cellular data (tethering from a mobile device does not count).
	systemd.services.ModemManager.enable = false;
}