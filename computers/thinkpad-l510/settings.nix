{ ... }: {
	boot = {
		# Define the LUKS-encrypted storage devices (root and swap).
		initrd.luks.devices = {
			root.device = "/dev/disk/by-uuid/UUID-HERE";
			swap.device = "/dev/disk/by-uuid/UUID-HERE";
		};

		loader.limine = {
			# Set the drive to install the Limine bootloader onto.
			biosDevice = "/dev/disk/by-id/ID-HERE";

			# Disable support for EFI booting.
			efiSupport = false;
		};
	};

	# Filesystem options.
	fileSystems = {
		"/".options = [ "compress=zstd:3" ];
		"/home".options = [ "compress=zstd:3" ];
		"/nix".options = [ "compress=zstd:3" "noatime" ];
	};

	# Extra packages for hardware acceleration.
	hardware.graphics.extraPackages = lib.optionals config.hardware.graphics.enable (with pkgs; [
		# VA-API for older Intel GPUs using the i915 driver.
		intel-vaapi-driver

		# OpenCL for Intel GPUs.
		intel-compute-runtime
	]);

	# Set the computer's name on the network.
	networking.hostName = "ThinkPad-L510";

	programs.pmutils = {
		# Whether to enable a small collection of scripts that handle suspend and resume on behalf of HAL.
		enable = true;

		# Whether `pm-suspend` should be used when invoking `systemctl supsend`.
		# This can be useful on devices where suspend does not work otherwise (e.g. ThinkPad L510).
		replaceSuspend = true;
	};

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