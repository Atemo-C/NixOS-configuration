{ pkgs, ... }: {
	boot = {
		# Paths of LUKS-encrypted storage devices necessary for the system.
		# Optional ones (e.g. removable encrypted drives) should not be put here.
		initrd.luks.devices = {
			root.device = "/dev/disk/by-uuid/80ef44a6-7ee0-4001-bc09-7b5fcd11b46e";
			swap.device = "/dev/disk/by-uuid/56c4a6c9-e2d5-4b02-a13d-45ad9302a19e";
		};

		# Whether the installation process is allowed to modify EFI boot variables.
		# Once installed, if after an update, it fails to "install" again,
		# it should be entirey safe to turn this option off.
		loader.efi.canTouchEfiVariables = false;
	};

	# Filesystem options.
	fileSystems = {
		# ZSTD compression for the root `/` and `/home/` volumes.
		"/".options = [ "compress=zstd:3" ];
		"/home".options = [ "compress=zstd:3" ];

		# ZSTD compression and no access time updae for the `/nix/` volume.
		"/nix".options = [ "compress=zstd:3" "noatime" ];
	};

	hardware = {
		# Whether to enable support for Bluetooth.
		bluetooth.enable = true;

		# Intel Media Driver for VAAPI for Broadwell (7th Gen) and above Intel iGPUs.
		graphics.extraPackages = [ pkgs.intel-media-driver ];
	};

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
		# Keyboard layout, or multiple keyboard layouts separated by a comma.
		layout = "fr,us";

		# Keyboard layout variant, or multiple keyboard variants separated by a comma.
		variant = ",intl";
	};

	# Whether to enable the ModemManager service for using cellular data.
	# Disable this if you do not use it, to improve boot times.
	systemd.services.ModemManager.enable = false;
}