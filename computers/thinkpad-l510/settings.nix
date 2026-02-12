{ pkgs, ... }: {
	boot = {
		# Paths of LUKS-encrypted storage devices necessary for the system.
		# Optional ones (e.g. removable encrypted drives) should not be put here.
		initrd.luks.devices = {
			root.device = "/dev/disk/by-uuid/11111111-1111-1111-1111-111111111111";
			swap.device = "/dev/disk/by-uuid/22222222-2222-2222-2222-222222222222";
		};

		loader.limine = {
			# Set the drive to install the Limine bootloader onto.
			biosDevice = "/dev/disk/by-id/ata-WDC_WD1600BEVS-08VAT2_WD-WXP1A30R8683";

			# Disable support for EFI booting.
			efiSupport = false;
		};
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
		hardware.bluetooth.enable = true;

		# VA-API user mode driver for 6th gen and older Intel iGPUs.
		graphics.extraPackages = [ pkgs.intel-vaapi-driver ];
	};

	# Set the computer's name on the network.
	networking.hostName = "THINKPAD-L510";

	programs.pmutils = {
		# whether to enable pmutils, a small collection of scripts handling suspend and resume on behalf of HAl.
		enable = true;

		# Whether pmutils commands should replace their systemctl equivalent for suspend/hibernation actions.
		replaceAll = true;
	};

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