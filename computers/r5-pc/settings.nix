{ config, lib, pkgs, ... }: {
	boot = {
		# Paths of LUKS-encrypted storage devices necessary for the system.
		# Optional ones (e.g. removable encrypted drives) should not be put here.
		initrd.luks.devices = {
			root = {
				# Storage device's UUID.
				device = "/dev/disk/by-uuid/11111111-1111-1111-1111-111111111111";

				# Whether to allow discards (only for SSDs).
				allowDiscards = true;
			};

			swap = {
				# Storage device's UUID.
				device = "/dev/disk/by-uuid/22222222-2222-2222-2222-222222222222";

				# Whether to allow discards (only for SSDs).
				allowDiscards = true;
			};
		};

		# Whether the installation process is allowed to modify EFI boot variables.
		# Once installed, if after an update, it fails to "install" again,
		# it should be entirey safe to turn this option off.
		loader.efi.canTouchEfiVariables = true;
	};

	# Filesystem options.
	fileSystems = {
		# ZSTD compression for the root `/` and `/home/` volumes.
		"/".options = [ "compress=zstd:3" ];
		"/home".options = [ "compress=zstd:3" ];

		# ZSTD compression and no access time updae for the `/nix/` volume.
		"/nix".options = [ "compress=zstd:3" "noatime" ];
	};

	# Import the proprietary NVIDIA drivers module (for 165X and above GPUs).
	imports = [ /etc/nixos/gpu/nvidia.nix ];

	# Set the computer's name on the network.
	networking.hostName = "R5-PC";

	services = {
		# Whether to enable LACT, a tool for monitoring, configuring, and overclocking GPUs.
		lact.enable = lib.mkIf (lib.elem "nvidia" config.services.xserver.videoDrivers) true;

		# Keyboard layout settings.
		# To see a complete list of layouts, variants, and other settings:
		# • https://gist.github.com/jatcwang/ae3b7019f219b8cdc6798329108c9aee
		#
		# To see why this list cannot easily be seen within NixOS:
		# • https://github.com/NixOS/nixpkgs/issues/254523
		# • https://github.com/NixOS/nixpkgs/issues/286283
		services.xserver.xkb = {
			# Keyboard layout, or multiple keyboard layouts separated by a comma.
			layout = "us,fr";

			# Keyboard layout variant, or multiple keyboard variants separated by a comma.
			variant = "intl,";
		};
	};

	# Whether to enable the ModemManager service for using cellular data.
	# Disable this if you do not use it, to improve boot times.
	systemd.services.ModemManager.enable = false;
}